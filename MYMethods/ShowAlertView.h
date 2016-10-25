//
//  ShowAlertView.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/1/8.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowAlertView : NSObject<UIAlertViewDelegate>
+(void)showAlertViewWithMessage:(NSString *)message andDelegate:(id)delegate andTag:(NSInteger)tag;

@end
