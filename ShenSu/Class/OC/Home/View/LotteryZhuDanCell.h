//
//  LotteryZhuDanCell.h
//  LotteryForecast
//
//  Created by 杨健 on 2017/5/2.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lottery.h"
@class LotteryZhuDanCell;

@protocol LotteryZhuDanCellDelegate <NSObject>

-(void)LotteryZhuDanCellDeletedCell:(LotteryZhuDanCell*)cell;

@end


@interface LotteryZhuDanCell : UITableViewCell
@property (nonatomic,strong)Lottery *lottery;
@property (nonatomic,strong)NSMutableArray *boards;

@property(nonatomic,weak)id <LotteryZhuDanCellDelegate> delegate;

@end
