//
//  RTMPNetTool.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/27.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SVProgressHUD.h"


NS_ASSUME_NONNULL_BEGIN
@interface RTMPNetTool : NSObject

+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

+ (NSDictionary *)transformation:(id)responseObject;

+ (void)get:(nonnull NSString *)urlString progress:(nullable void (^)(NSProgress * _Nonnull progress))progressBlock success:(nullable void (^)(id _Nonnull responseObject)) successBlock failure:(nullable void (^)(NSString * _Nonnull errorLD))failureBlock;

+ (void)get:(nonnull NSString *)urlString parameters:(nullable NSDictionary <NSString *, id> *)parameters progress:(nullable void (^)(NSProgress * _Nonnull progress))progressBlock success:(nullable void (^)(id _Nonnull responseObject)) successBlock failure:(nullable void (^)(NSString * _Nonnull errorLD))failureBlock;

@end
NS_ASSUME_NONNULL_END