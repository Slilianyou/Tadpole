//
//  UIButton+Set.m
//  JingZhuangJi
//
//  Created by zhangjiucheng on 15/2/15.
//  Copyright (c) 2015年 JingZhuangJi. All rights reserved.
//

#import "UIButton+Set.h"


@implementation UIButton (quickSet)
- (void)setTitleColor:(UIColor*)color{
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void)setTitle:(NSString*)title{
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setImage:(UIImage*)image{
    [self setImage:image
          forState:UIControlStateNormal];
}

- (void)setTitleFont:(UIFont*)font{
    [self.titleLabel setFont:font];
}
@end