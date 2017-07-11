//
//  HomeCollectionViewCell.h
//  LotteryForecast
//
//  Created by 杨健 on 2017/4/26.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Lottery;

@protocol LotteryHomeViewCellDelegate <NSObject>

- (void)lotteryHomeCellClick:(Lottery*)lottery;

@end

@interface LotteryHomeViewCell : UICollectionViewCell
@property (nonatomic,copy)NSString *requestKey;

@property(nonatomic,weak)id <LotteryHomeViewCellDelegate> delegate;
@end
