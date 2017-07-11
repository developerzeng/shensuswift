//
//  LotteryResultCell.m
//  LotteryForecast
//
//  Created by 杨健 on 2017/4/17.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "LotteryResultCell.h"

@interface LotteryResultCell()

@property (weak, nonatomic) IBOutlet UILabel *lotteryResultLabel;

@end

@implementation LotteryResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setText:(NSString *)text{
    self.lotteryResultLabel.text = text;
}

@end
