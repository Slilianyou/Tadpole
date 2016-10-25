//
//  RLBaseDateTools.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/17.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RLBaseDateTools : NSObject
+ (NSDate *)getPreviousMonthframDate:(NSDate *)date;
+ (NSDate *)getNextMonthframDate:(NSDate *)date;
@end
