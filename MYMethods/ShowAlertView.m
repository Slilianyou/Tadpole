//
//  ShowAlertView.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/1/8.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "ShowAlertView.h"

@implementation ShowAlertView
+(void)showAlertViewWithMessage:(NSString *)message andDelegate:(id)delegate andTag:(NSInteger)tag
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:delegate cancelButtonTitle: @"确定"otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}




























@end
