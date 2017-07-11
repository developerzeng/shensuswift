//
//  LotteryOpenInfoCell.m
//  LotteryForecast
//
//  Created by 杨健 on 2017/5/14.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "LotteryOpenInfoCell.h"

@interface LotteryOpenInfoCell()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation LotteryOpenInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topViewClick)];
    [self.topView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bottomViewCLick)];
    [self.bottomView addGestureRecognizer:tap2];
}

- (void)topViewClick{
    if ([self.delegate respondsToSelector:@selector(LotteryOpenInfoCellClick:)]) {
        [self.delegate LotteryOpenInfoCellClick:self.topView];
    }
    
}

- (void)bottomViewCLick{
    if ([self.delegate respondsToSelector:@selector(LotteryOpenInfoCellClick:)]) {
        [self.delegate LotteryOpenInfoCellClick:self.bottomView];
    }
}




@end
