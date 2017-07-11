//
//  LotteryDiFangHeaderView.m
//  LotteryForecast
//
//  Created by 杨健 on 2017/4/21.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "LotteryHeaderView.h"

@interface LotteryHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@end

@implementation LotteryHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setHeaderName:(NSString *)headerName{
    self.headerLabel.text = headerName;
}

@end
