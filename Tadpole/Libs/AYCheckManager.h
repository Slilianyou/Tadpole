//
//  AYCheckManager.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/10/13.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AYCheckManager : NSObject
// 程序内部打开APPStore, 默认NO
@property (nonatomic, assign) BOOL openAPPStoreInSideAPP;
// 如果不能获取APP的更新信息，设置地区缩写countryAbbreviation ＝ @“cn”
@property (nonatomic, copy) NSString *countryAbbreviation;

#pragma mark --
+ (instancetype)sharedCheckManager;

- (void)checkVersion;

- (void)checkVersionWithAlertTitle:(NSString *)alertTitle nextTimeTitle:(NSString *)nextTimeTitle confimTitle:(NSString *)confimTitle;

- (void)checkVersionWithAlertTitle:(NSString *)alertTitle nextTimeTitle:(NSString *)nextTimeTitle confimTitle:(NSString *)confimTitle skipVersionTitle:(NSString *)skipVersionTitle;


@end
