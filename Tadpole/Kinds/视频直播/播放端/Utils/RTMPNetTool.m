//
//  RTMPNetTool.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/27.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "RTMPNetTool.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"


@implementation RTMPNetTool
+ (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return str;
}

+ (NSDictionary *)transformation:(id)responseObject
{
    NSString *resultString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
    
#if DEBUG
    NSLog(@"**********************");
    NSLog(@"%@",resultString);
    NSLog(@"**********************");
#else
    
#endif
    NSData *jsonData = [resultString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    return dic;
}

+ (void)get:(nonnull NSString *)urlString progress:(nullable void (^)(NSProgress * _Nonnull progress))progressBlock success:(nullable void (^)(id _Nonnull responseObject)) successBlock failure:(nullable void (^)(NSString * _Nonnull errorLD))failureBlock
{
    NSParameterAssert(urlString);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    urlString = [NSMutableString stringWithFormat:@"%@%@",RTMPNetworkServer,urlString];
    __weak typeof (self) weakSelf = self;
    
    
}

+ (void)get:(nonnull NSString *)urlString parameters:(nullable NSDictionary <NSString *, id> *)parameters progress:(nullable void (^)(NSProgress * _Nonnull progress))progressBlock success:(nullable void (^)(id _Nonnull responseObject)) successBlock failure:(nullable void (^)(NSString * _Nonnull errorLD))failureBlock
{
    
}
@end
