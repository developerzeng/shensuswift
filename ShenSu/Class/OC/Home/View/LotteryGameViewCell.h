//
//  LotteryGameViewCell.h
//  LotteryForecast
//
//  Created by 杨健 on 2017/5/14.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LotteryGameViewCellDelegate <NSObject>
- (void)bottomCLick;
- (void)LotteryGameForeCast;
- (void)LotteryGameViewCellTextField:(UITextField *)textField;
@end

@interface LotteryGameViewCell : UICollectionViewCell

@property(nonatomic,weak)id <LotteryGameViewCellDelegate> delegate;

@end
