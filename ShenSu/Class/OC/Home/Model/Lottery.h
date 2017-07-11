//
//  Lottery.h
//  LotteryForecast
//
//  Created by 杨健 on 2017/4/16.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lottery : NSObject

@property (nonatomic,copy)NSString *name;    //彩种名称
@property (nonatomic,copy)NSString *issue;  //第多少期
@property (nonatomic,copy)NSString *open_time; //开奖时间
@property (nonatomic,copy)NSString *result;  //开奖结果
@property (nonatomic,copy)NSString *key;   //key值
@property (nonatomic,copy)NSString *sales;  //销售额
@property (nonatomic,copy)NSString *balance;  //奖池
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,strong)NSArray *prize;

@property (nonatomic,copy)NSString *caipiaoid;
@property (nonatomic,copy)NSString *issueno;
@property (nonatomic,copy)NSString *number;
@property (nonatomic,copy)NSString *refernumber;
@property (nonatomic,copy)NSString *opendate;
@property (nonatomic,copy)NSString *deadline;
@property (nonatomic,copy)NSString *saleamount;

@property (nonatomic,copy)NSString *expect;
@property (nonatomic,copy)NSString *opencode;
@property (nonatomic,copy)NSString *opentime;
@property (nonatomic,copy)NSString *opentimestamp;

@property (nonatomic,copy)NSString *lotteryNo;
@property (nonatomic,copy)NSString *ernieDateStr;
@property (nonatomic,copy)NSString *ernieDate;
@property (nonatomic,copy)NSString *openNumber;
@property (nonatomic,copy)NSString *lotteryName;

@end
