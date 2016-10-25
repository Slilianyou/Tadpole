//
//  UIViewController+progressHud.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/20.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (progressHud)
@property (nonatomic, strong)UIView *HUDView;
- (void)creatHudOfUIIImageView;
- (void)creatHudToWindow;
- (void)dismissHud;
@end
