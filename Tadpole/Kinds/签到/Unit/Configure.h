//
//  Configure.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/20.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Configure : NSObject
+ (id)sharedInstance;

/**
 *  现在本地时间
 */
- (NSDate *)today;
/**
 *  创建本地签到配置文件_______DaySign.plist
 */
- (NSString *)creatFilePathWithFileName:(NSString *)fileName;
/**
 *  return   plist array;
 *
 */
- (NSArray *)getPlistDataWithFileName:(NSString *)fileName;

@end
