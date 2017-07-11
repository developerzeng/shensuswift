//
//  LotteryHallHeaderView.h
//  NewHuangguan
//
//  Created by 杨健 on 2017/4/23.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryAd.h"

@protocol LotteryHallHeaderViewDelegate <NSObject>

- (void)LotteryHallHeaderViewClick:(LotteryAd*)ad;

@end

#import "LotteryAd.h"
@interface LotteryHallHeaderView : UICollectionReusableView


@property (nonatomic,strong)NSArray *adItems;
@property(nonatomic,weak)id <LotteryHallHeaderViewDelegate> delegate;
@end
