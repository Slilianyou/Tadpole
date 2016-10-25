//
//  NSTimer+Addition.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/10/21.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)
- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
