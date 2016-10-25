//
//  RLBaseDateTools.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/17.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "RLBaseDateTools.h"
#import "NSDate+RLBaseCalendar.h"



@implementation RLBaseDateTools
+ (NSDate *)getPreviousMonthframDate:(NSDate *)date
{
    NSDate *firstDateForPreviousMonth = nil;
    
    NSDate *currentFirstDate = [date YHBaseFirstDayOfCurrentMonth];
    NSTimeInterval oneDay = 24*60*60*1; // 1天的长度
    //前一个月的最后一天
    NSDate * preDate = [currentFirstDate dateByAddingTimeInterval:-oneDay];
    firstDateForPreviousMonth = [preDate YHBaseFirstDayOfCurrentMonth];
    return firstDateForPreviousMonth;
    
}
+ (NSDate *)getNextMonthframDate:(NSDate *)date
{
    NSDate *firstDateForNextMonth = nil;
    
    NSDate *currentFirstDate = [date YHBaseFirstDayOfCurrentMonth];
   
    NSTimeInterval oneDay = 24*60*60*1; // 1天的长度
    //前一个月的最后一天
    int monthNum = [date YHBaseNumberOfDaysInCurrentMonth];
    NSDate * nextDate = [currentFirstDate dateByAddingTimeInterval:oneDay *monthNum];
    firstDateForNextMonth = [nextDate YHBaseFirstDayOfCurrentMonth];
    return firstDateForNextMonth;
}
@end
