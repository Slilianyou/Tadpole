//
//  UIViewController+progrssHud.m
//  EZhuiSu
//
//  Created by ss-iOS-LLY on 16/10/17.
//  Copyright © 2016年 Paiwogou@syscanit.com. All rights reserved.
//

#import "UIViewController+progrssHud.h"
#import <objc/runtime.h>

static void *hudKey = &hudKey;

@implementation UIViewController (progrssHud)
- (void)setHUDView:(LoadingView *)HUDView
{
    objc_setAssociatedObject(self, &hudKey, HUDView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (LoadingView *)HUDView
{
    return objc_getAssociatedObject(self, &hudKey);
}

- (void)creatHud
{
    if(self.HUDView.superview){
        
        return ;
    }
    else{
        [self creat] ;
    }
  
}
- (void)dissmissHud {
    [self dissmissHudAfterDelay:0] ;
}
- (void)dissmissHudAfterDelay:(float)time{
    if([self canDismissHud]){
        
        [self performSelector:@selector(dissmiss) withObject:nil afterDelay:time] ;
    }
}
- (void)dissmiss{
    [self.HUDView removeFromSuperview] ;
}
- (BOOL)canDismissHud{
    return  self.HUDView&&self.HUDView.superview ;
}
#pragma mark --
- (void)creat
{
    self.HUDView = [[UIView alloc]init] ;
    self.HUDView.backgroundColor = [UIColor clearColor] ;
    UIControl*control = [[UIControl alloc]init] ;
    control.backgroundColor = [UIColor darkGrayColor] ;
    control.tag = 11 ;
    [self.HUDView addSubview:control] ;
    NSLayoutConstraint*c1 = [NSLayoutConstraint constraintWithItem:self.HUDView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:control attribute:NSLayoutAttributeLeading multiplier:1 constant:0.0f] ;
    NSLayoutConstraint*c2 = [NSLayoutConstraint constraintWithItem:self.HUDView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:control attribute:NSLayoutAttributeTrailing multiplier:1 constant:0.0f] ;
    NSLayoutConstraint*c3 = [NSLayoutConstraint constraintWithItem:self.HUDView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:control attribute:NSLayoutAttributeTop multiplier:1 constant:0.0f] ;
    NSLayoutConstraint*c4 = [NSLayoutConstraint constraintWithItem:self.HUDView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:control attribute:NSLayoutAttributeBottom multiplier:1 constant:0.0f] ;
    control.translatesAutoresizingMaskIntoConstraints = NO;
    [self.HUDView addConstraint:c1] ;
    [self.HUDView addConstraint:c2] ;
    [self.HUDView addConstraint:c3] ;
    [self.HUDView addConstraint:c4] ;

    //
    LoadingView * loadingView = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, 120, 80) color:[UIColor greenColor] backgroundColor:[UIColor blackColor]];
    loadingView.alpha = 0.6;
    loadingView.layer.cornerRadius = 8.f;
    loadingView.layer.masksToBounds = YES;
    [self.HUDView addSubview:loadingView];
    
    NSLayoutConstraint *c11 = [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:120] ;
    NSLayoutConstraint *c22 = [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:80] ;
    NSLayoutConstraint *c33 = [NSLayoutConstraint constraintWithItem:self.HUDView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:loadingView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0.0f] ;
    NSLayoutConstraint *c44 = [NSLayoutConstraint constraintWithItem:self.HUDView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:loadingView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0.0f] ;
    loadingView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [loadingView addConstraint:c11] ;
    [loadingView addConstraint:c22] ;
    [self.HUDView addConstraint:c33] ;
    [self.HUDView addConstraint:c44] ;
    
    [self.view addSubview:self.HUDView] ;
    NSLayoutConstraint*a1 = [NSLayoutConstraint constraintWithItem:self.HUDView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0.0f] ;
    NSLayoutConstraint*a2 = [NSLayoutConstraint constraintWithItem:self.HUDView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0.0f] ;
    NSLayoutConstraint*a3 = [NSLayoutConstraint constraintWithItem:self.HUDView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0.0f] ;
    NSLayoutConstraint*a4 = [NSLayoutConstraint constraintWithItem:self.HUDView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0.0f] ;
    self.HUDView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:a1] ;
    [self.view addConstraint:a2] ;
    [self.view addConstraint:a3] ;
    [self.view addConstraint:a4] ;
    self.HUDView.alpha = 1;
    
    [self controlAlphaAddAnimation] ;
    
}

- (void)controlAlphaAddAnimation{
    UIControl *ctr = [self.HUDView viewWithTag:11] ;
    if(ctr){
        ctr.alpha = 0 ;
        [UIView animateWithDuration:0.5 animations:^{
            ctr.alpha = 0.2 ;
        }] ;
    }
}






















@end
