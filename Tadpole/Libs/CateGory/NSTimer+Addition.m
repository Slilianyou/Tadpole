//
//  NSTimer+Addition.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/10/21.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "NSTimer+Addition.h"

@implementation NSTimer (Addition)
- (void)pauseTimer
{
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate distantFuture]];
}

- (void)resumeTimer
{
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}
















@end
