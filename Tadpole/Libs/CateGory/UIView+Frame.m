//
//  UIView+UIView_Frame.m
//  jzjpad
//
//  Created by zhangjiucheng on 14/9/11.
//  Copyright (c) 2014年 com.sikaipad.jzjpad. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (UIView_Frame)
- (CGFloat)width{
    return self.frame.size.width;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (CGFloat)left{
    return self.frame.origin.x;
}

- (CGFloat)right{
    return self.frame.origin.x+self.frame.size.width;
}

- (CGFloat)top{
    return self.frame.origin.y;
}

- (CGFloat)bottom{
    return self.frame.origin.y+self.frame.size.height;
}


- (void)setTop:(CGFloat)top{
    CGRect rc = self.frame;
    rc.origin.y = top;
    self.frame = rc;
}


- (void)setLeft:(CGFloat)left{
    CGRect rc = self.frame;
    rc.origin.x = left;
    self.frame = rc;
}


- (void)setWidth:(CGFloat)w{
    
    CGRect rc = self.frame;
    rc.size.width = w;
    self.frame = rc;
}



- (void)setHeight:(CGFloat)h{
    CGRect rc = self.frame;
    rc.size.height = h;
    self.frame = rc;
}
@end
