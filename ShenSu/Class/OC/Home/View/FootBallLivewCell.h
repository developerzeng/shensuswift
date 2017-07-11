//
//  FootBallLivewCell.h
//  LotteryForecast
//
//  Created by 杨健 on 2017/5/15.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXFootBallLive.h"
@class FootBallLivewCell;

@protocol FootBallLivewCellDelegate <NSObject>

-(void)FootBallLivewCellCollection:(FootBallLivewCell *)cell andSelected:(BOOL)selected;

@end

@interface FootBallLivewCell : UITableViewCell
@property (nonatomic,strong)FXFootBallLive *live;

@property (nonatomic,weak)id<FootBallLivewCellDelegate> delegate;
@end
