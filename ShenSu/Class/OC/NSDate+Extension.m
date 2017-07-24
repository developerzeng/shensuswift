//
//  NSDate+Extension.m
//  ShenSu
//
//  Created by shensu on 17/7/24.
//  Copyright © 2017年 zp. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
+ (BOOL)setTimewithNow
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    
    //2016-09-30-00
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSDate *dateDangQian = [dateFormatter dateFromString:@"28-07-2017-000000"];
    
    NSComparisonResult result = [date compare:dateDangQian];
    
    if(result == 1){
        return YES;
    }
    return NO;
    
    
}

@end
