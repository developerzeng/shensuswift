//
//  LotteryOpenInfoCell.h
//  LotteryForecast
//
//  Created by 杨健 on 2017/5/14.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LotteryOpenInfoCellDelegate <NSObject>

- (void)LotteryOpenInfoCellClick:(UIView *)view;

@end

@interface LotteryOpenInfoCell : UICollectionViewCell

@property(nonatomic,weak)id <LotteryOpenInfoCellDelegate> delegate;

@end
