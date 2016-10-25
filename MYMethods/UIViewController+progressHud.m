//
//  UIViewController+progressHud.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/20.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "UIViewController+progressHud.h"
#import "AppDelegate.h"
#import <objc/runtime.h>

static void *strKey = &strKey; // ??
@implementation UIViewController (progressHud)
- (void)setHUDView:(UIView *)HUDView
{
    objc_setAssociatedObject(self, &strKey, HUDView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)HUDView {
    return objc_getAssociatedObject(self, &strKey);
}
- (void)creatHudOfUIIImageView
{
    if (!self.HUDView) {
        self.HUDView = [[UIView alloc]init];
        self.HUDView.backgroundColor = [UIColor clearColor];
        UIView *indicatorBackView = [[UIView alloc]init];
        indicatorBackView.backgroundColor = [UIColor whiteColor];
        indicatorBackView.layer.cornerRadius = 5;
        indicatorBackView.layer.masksToBounds = YES;
        indicatorBackView.alpha = 0.8;
        
        //
//        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//        indicator.tag = 111;
//        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
//        indicator.center = CGPointMake(25, 25);
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 90)];
        imageView.tag = 222;
        NSMutableArray * arr= [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"loading-1.png"],[UIImage imageNamed:@"loading-2.png"],[UIImage imageNamed:@"loading-3.png"],[UIImage imageNamed:@"loading-4.png"], nil];
        imageView.animationImages = arr;
        
        
        [indicatorBackView addSubview:imageView];
        [self.HUDView addSubview:indicatorBackView];
        
        NSLayoutConstraint *c11 = [NSLayoutConstraint  constraintWithItem:indicatorBackView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:120];
        
        NSLayoutConstraint *c22 = [NSLayoutConstraint constraintWithItem:indicatorBackView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:90.0f];
        
        NSLayoutConstraint*c33 = [NSLayoutConstraint constraintWithItem:self.HUDView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:indicatorBackView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0.0f] ;
        NSLayoutConstraint*c44 = [NSLayoutConstraint constraintWithItem:self.HUDView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:indicatorBackView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0.0f] ;
        indicatorBackView.translatesAutoresizingMaskIntoConstraints = NO;
        [indicatorBackView addConstraint:c11] ;
        [indicatorBackView addConstraint:c22] ;
        [self.HUDView addConstraint:c33] ;
        [self.HUDView addConstraint:c44] ;
    }
    if (!self.HUDView.superview) {
        [self.view addSubview:self.HUDView];
        NSLayoutConstraint*c1 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.HUDView attribute:NSLayoutAttributeLeading multiplier:1 constant:0.0f] ;
        NSLayoutConstraint*c2 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.HUDView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0.0f] ;
        NSLayoutConstraint*c3 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.HUDView attribute:NSLayoutAttributeTop multiplier:1 constant:0.0f] ;
        NSLayoutConstraint*c4 = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.HUDView attribute:NSLayoutAttributeBottom multiplier:1 constant:0.0f] ;
        self.HUDView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addConstraint:c1] ;
        [self.view addConstraint:c2] ;
        [self.view addConstraint:c3] ;
        [self.view addConstraint:c4] ;
    }
//    UIActivityIndicatorView *indicator =(UIActivityIndicatorView *) [self.view viewWithTag:111];
//    [indicator startAnimating];
    
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:222];
    imageView.animationDuration = 0.4;
    imageView.animationRepeatCount = 0;
    [imageView startAnimating];
}

- (void)dismissHud
{
    if (self.HUDView && self.HUDView.superview) {
//        UIActivityIndicatorView *indicator =(UIActivityIndicatorView *) [self.view viewWithTag:111];
//        [indicator stopAnimating];
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:222];
       
        [imageView stopAnimating];
        [self.HUDView removeFromSuperview];
    }
}

- (void)creatHudToWindow
{
    if(!self.HUDView){
        self.HUDView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen]bounds]] ;
        
        UIControl*control = [[UIControl alloc]initWithFrame:self.HUDView.bounds] ;
        [self.HUDView addSubview:control] ;
        
        self.HUDView.backgroundColor = [UIColor clearColor] ;
        control.backgroundColor = [UIColor blackColor] ;
        control.alpha = 0.1 ;
        UIActivityIndicatorView*indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)] ;
        indicator.center = CGPointMake(self.HUDView.bounds.size.width/2, self.HUDView.bounds.size.height/2) ;
        indicator.tag = 111 ;
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite ;
        [self.HUDView addSubview:indicator] ;
        
        
    }
    if(!self.HUDView.superview ){
        
        [APPDELEGATE.window addSubview:self.HUDView];
    }
    UIActivityIndicatorView*indicator = (UIActivityIndicatorView*)[self.HUDView viewWithTag:111] ;
    [indicator startAnimating] ;
    

}

























@end
