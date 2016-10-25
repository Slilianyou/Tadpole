//
//  NSDate+RLBaseCalendar.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/16.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "NSDate+RLBaseCalendar.h"

@implementation NSDate (RLBaseCalendar)
-(NSUInteger)YHBaseNumberOfDaysInCurrentMonth
{
    return [[NSCalendar currentCalendar]rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self].length;
}
- (NSDate *)YHBaseFirstDayOfCurrentMonth
{
    NSDate *startDate = nil;
    NSDate *localeDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&startDate interval:NULL forDate:self];
    if (ok) {
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:startDate];
       localeDate = [startDate dateByAddingTimeInterval:interval];
    }
    NSAssert(ok, @"Failed to calculate the first day of the month based on %@", self);
   
    return localeDate;
}

-(int)YHBaseWeekly
{
   NSInteger a = [[NSCalendar currentCalendar]ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:self];
    return  (int)a;
}


//
- (int)getYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit |NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit;
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
    
    return (int)dateComponents.year;
}
- (int)getMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlag = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponents = [calendar components:unitFlag fromDate:self];
    return (int)dateComponents.month;
}
- (int)getDay
{
    
    //恢复－－－－－GMT 0:00 格林威治标准时间;
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: self];
    NSDate *localeDate = [self  dateByAddingTimeInterval:-interval];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlag = NSDayCalendarUnit;
    NSDateComponents *dateComponents = [calendar components:unitFlag fromDate:localeDate];
    
    return (int)dateComponents.day;
}
- (int)getHour
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlag = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
   
    NSDateComponents *dateComponents = [calendar components:unitFlag fromDate:self];
    return (int)dateComponents.hour;
}
- (int)getMinute
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlag = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponents = [calendar components:unitFlag fromDate:self];
    return (int)dateComponents.hour;
}
- (int)getSecond
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlag = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponents = [calendar components:unitFlag fromDate:self];
    return (int)dateComponents.second;
}













































@end
