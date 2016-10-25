//
//  UIButton+Set.h
//  JingZhuangJi
//
//  Created by zhangjiucheng on 15/2/15.
//  Copyright (c) 2015年 JingZhuangJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (quickSet)

- (void)setTitleColor:(UIColor*)color;
- (void)setTitle:(NSString*)title;
- (void)setImage:(UIImage*)image;
- (void)setTitleFont:(UIFont*)font;
@end