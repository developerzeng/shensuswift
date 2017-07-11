//
//  LotteryItemViewCell.m
//  LotteryForecast
//
//  Created by 杨健 on 2017/4/16.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "LotteryItemViewCell.h"

@interface LotteryItemViewCell()

@end

@implementation LotteryItemViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
 //    self.lotteryItemBtn.layer.cornerRadius = kItemWH * 0.5;
    self.lotteryItemBtn.layer.masksToBounds = YES;
}

- (void)setNumber:(NSString *)number{
    [self.lotteryItemBtn setTitle:number forState:UIControlStateNormal];
//    [self.lotteryItemBtn setBackgroundColor:[UIColor colorWithRed:212 green:43 blue:51]];
}

- (void)setLottery:(Lottery *)lottery{
    if ([lottery.lotteryName isEqualToString:@"胜负任九"] || [lottery.lotteryName isEqualToString:@"北京单场"] || [lottery.lotteryName isEqualToString:@"半全场"] || [lottery.lotteryName isEqualToString:@"进球彩"]) {
 //      [self.lotteryItemBtn setBackgroundColor:[UIColor colorWithRed:85 green:177 blue:72]];
   //     self.lotteryItemBtn.layer.cornerRadius = kItemWH * 0.2;
    }else{
        
 //       [self.lotteryItemBtn setBackgroundColor:[UIColor colorWithRed:212 green:43 blue:51]];
   //     self.lotteryItemBtn.layer.cornerRadius = kItemWH * 0.5;
    }
    self.lotteryItemBtn.layer.masksToBounds = YES;
}

//-(void)setBoard:(Board *)board{
////    _board = board;
//  //  [self.lotteryItemBtn setTitle:board.number forState:UIControlStateNormal];
//   
//    //[self.lotteryItemBtn setBackgroundColor:[board.color isEqualToString:@"red"]?kRedBoardSelectedBG:kBlueBoardSelectedBG];
//}

@end
