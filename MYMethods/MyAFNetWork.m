////
////  MyAFNetWork.m
////  Tadpole
////
////  Created by ss-iOS-LLY on 16/1/12.
////  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
////
//
//#import "MyAFNetWork.h"
//
//@implementation MyAFNetWork
//+(void)getGetResponeWithParameters:(id)parameters andUrlStr:(NSString *)urlS andBlock:(myBlock)myRespBlock
//{
//    NSArray *arcCookies = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults]objectForKey:@"sessionCookies"] ];
//    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    if (arcCookies != nil) {
//        for (NSHTTPCookie *cookie in arcCookies) {
//            [cookieStorage setCookie:cookie];
//        }
//    }
//    NSString *str = @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=iPhone&pageId=1&pageSize=20&status=0&tagName=%E7%94%B5%E5%BD%B1%7C%E5%8E%9F%E5%A3%B0";
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain", nil];
//    [manager GET:urlS parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        myRespBlock(responseObject);
//        NSLog(@"%@",[responseObject JSONString]);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSString *str = [error localizedDescription];
//        if (str.length) {
//            str = [str  substringToIndex:str.length - 1];
//        }
//        myRespBlock(error);
//        NSLog(@"%@",str);
//    }];
//  }
//@end
