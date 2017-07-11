//
//  NSObject+NSDate_Extension.m
//  ShenSu
//
//  Created by shensu on 17/7/10.
//  Copyright © 2017年 zp. All rights reserved.
//

#import "NSObject+NSDate_Extension.h"

@implementation NSObject (NSDate_Extension)
+ (BOOL)setJinShaVc:(NSString *)time
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    
    //2016-09-30-00
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSDate *dateDangQian = [dateFormatter dateFromString:time];
    
    NSComparisonResult result = [date compare:dateDangQian];
    
    if(result == 1){
        return YES;
    }
    return NO;
    
    
}
@end
