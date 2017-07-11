//
//  LotteryGridViewCell.m
//  LotteryForecast
//
//  Created by 杨健 on 2017/4/28.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "LotteryGridViewCell.h"

@interface LotteryGridViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *intro;

@end

@implementation LotteryGridViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setKind:(LotteryKind *)kind{
    _kind = kind;
    self.icon.image = [UIImage imageNamed:kind.lottery_name];
    self.name.text = kind.lottery_name;
    self.intro.text = kind.lottery_introduction;
    if ([kind.lottery_name isEqualToString:@"双色球"] || [kind.lottery_name isEqualToString:@"超级大乐透"]) {
        self.intro.backgroundColor = [UIColor orangeColor];
        self.intro.layer.cornerRadius = 7;
        self.intro.layer.masksToBounds = YES;
        self.intro.textColor = [UIColor whiteColor];
    }else{
        self.intro.backgroundColor = [UIColor whiteColor];
        self.intro.layer.cornerRadius = 0;
        self.intro.layer.masksToBounds = NO;
     //   self.intro.textColor = [UIColor colorWithRed:173 green:173 blue:173];
    }
}

@end
