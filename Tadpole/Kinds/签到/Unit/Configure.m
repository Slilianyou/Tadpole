//
//  Configure.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/20.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "Configure.h"

@implementation Configure
+ (id)sharedInstance
{
    static Configure *configure = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configure = [[self alloc]init];
    });
     return configure;
}


- (NSString *)creatFilePathWithFileName:(NSString *)fileName
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    
    return plistPath;
}
- (NSArray *)getPlistDataWithFileName:(NSString *)fileName
{
    NSString *filePath = [self creatFilePathWithFileName:fileName];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    return arr;
}
- (NSDate *)today
{
    NSDate *date = [NSDate date];
    NSTimeZone *timezone = [NSTimeZone systemTimeZone];
    NSTimeInterval timeterval = [timezone secondsFromGMTForDate:date];
    date = [date dateByAddingTimeInterval:timeterval];
    return date;
}





@end
