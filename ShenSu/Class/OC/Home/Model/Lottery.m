//
//  Lottery.m
//  LotteryForecast
//
//  Created by 杨健 on 2017/4/16.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "Lottery.h"

@implementation Lottery

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID" : @"id"};
}

+(NSDictionary *)mj_objectClassInArray{
    return @{@"prize":@"LotteryDetail"};
}

@end
