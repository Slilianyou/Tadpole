//
//  UIViewController+progrssHud.h
//  EZhuiSu
//
//  Created by ss-iOS-LLY on 16/10/17.
//  Copyright © 2016年 Paiwogou@syscanit.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingView.h"

@interface UIViewController (progrssHud)
@property (nonatomic, strong) UIView *HUDView;

- (void)creatHud;
- (void)dissmissHud;
@end














