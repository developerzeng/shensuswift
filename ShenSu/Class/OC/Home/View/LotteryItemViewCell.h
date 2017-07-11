//
//  LotteryItemViewCell.h
//  LotteryForecast
//
//  Created by 杨健 on 2017/4/16.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lottery.h"
//#import "Board.h"

@interface LotteryItemViewCell : UICollectionViewCell
@property (nonatomic,copy)NSString *number;
@property (nonatomic,strong)Lottery *lottery;
@property (weak, nonatomic) IBOutlet UIButton *lotteryItemBtn;
//@property (nonatomic,strong)Board *board;
@end
