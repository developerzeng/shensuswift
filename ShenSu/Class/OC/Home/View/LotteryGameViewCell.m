//
//  LotteryGameViewCell.m
//  LotteryForecast
//
//  Created by 杨健 on 2017/5/14.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "LotteryGameViewCell.h"

@interface LotteryGameViewCell()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *middleBtn;
@property (weak, nonatomic) IBOutlet UIButton *lastBtn;
@property (weak, nonatomic) IBOutlet UIButton *trendBtn;

@end

@implementation LotteryGameViewCell{
    UIButton *_tempBtn;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        NSLog(@"trendBtnSelected = %d",self.trendBtn.isSelected);
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.leftBtn.titleLabel.numberOfLines = 0;
    self.leftBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.leftBtn setTitle:@"胜\n 5.70" forState:UIControlStateNormal];
    
    self.middleBtn.titleLabel.numberOfLines = 0;
    self.middleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.middleBtn setTitle:@"平\n 4.00" forState:UIControlStateNormal];
    
    self.lastBtn.titleLabel.numberOfLines = 0;
    self.lastBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.lastBtn setTitle:@"负\n 1.47" forState:UIControlStateNormal];
    
    [self topBtnclick:self.leftBtn];
   
}
- (IBAction)forecastAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(LotteryGameForeCast)]) {
        [self.delegate LotteryGameForeCast];
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(LotteryGameViewCellTextField:)]) {
        [self.delegate LotteryGameViewCellTextField:textField];
    }
}

- (IBAction)topBtnclick:(UIButton *)sender {
    _tempBtn.selected = NO;
    _tempBtn = sender;
    sender.selected = YES;
    
}
- (IBAction)bottomClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(bottomCLick)]) {
        [self.delegate bottomCLick];
    }
}

@end
