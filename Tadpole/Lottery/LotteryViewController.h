//
//  LotteryViewController.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/8.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "RESideMenu.h"
#import "CUSViewController.h"
#import "CUSSenderGoldLayer.h"

@interface LotteryViewController : CUSViewController 
@property (nonatomic, strong) CALayer *rootLayer;

- (CALayer *)createLayer;

- (NSString *)getBackgroundImageName;
@end
