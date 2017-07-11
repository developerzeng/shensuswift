//
//  LotteryResultController.h
//  LotteryForecast
//
//  Created by 杨健 on 2017/4/16.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lottery.h"
#import "LotteryKind.h"

@interface LotteryResultController : UIViewController
@property (nonatomic,strong)Lottery *lottery;
@property (nonatomic,strong)LotteryKind *kind;
@end
