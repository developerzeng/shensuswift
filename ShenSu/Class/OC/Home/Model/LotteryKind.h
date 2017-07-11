//
//  LotteryKind.h
//  LotteryForecast
//
//  Created by 杨健 on 2017/4/28.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LotteryKind : NSObject
@property (nonatomic,copy)NSString *lottery_id;
@property (nonatomic,copy)NSString *lottery_name;
@property (nonatomic,copy)NSString *lottery_image_url;
@property (nonatomic,copy)NSString *lottery_introduction;
@property (nonatomic,copy)NSString *category_id;
@end
