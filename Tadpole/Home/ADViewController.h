//
//  ADViewController.h
//  PaiWoGou
//
//  Created by ss-iOS-LLY on 15/12/29.
//  Copyright © 2015年 Shanghai Easyka Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CUSViewController.h"
#import "CUSSenderGoldLayer.h"

@interface ADViewController : CUSViewController
@property (nonatomic,strong)UIButton *secondBtn;
@property (nonatomic, strong) CALayer *rootLayer;

- (CALayer *)createLayer;

- (NSString *)getBackgroundImageName;
@end
