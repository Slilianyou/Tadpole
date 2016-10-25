//
//  UIView+UIView_Frame.h
//  jzjpad
//
//  Created by zhangjiucheng on 14/9/11.
//  Copyright (c) 2014年 com.sikaipad.jzjpad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface UIView (UIView_Frame)
- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)left;
- (CGFloat)right;
- (CGFloat)top;
- (CGFloat)bottom;
- (void)setTop:(CGFloat)top;
- (void)setLeft:(CGFloat)left;
- (void)setWidth:(CGFloat)w;
- (void)setHeight:(CGFloat)h;
@end
