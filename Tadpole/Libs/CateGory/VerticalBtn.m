//
//  VerticalBtn.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/10/26.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "VerticalBtn.h"

#define  kMargin 10
@implementation VerticalBtn
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:15.f];
        self.titleLabel.textColor = [UIColor redColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.backgroundColor = [UIColor clearColor];
    }
    return  self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect rect = CGRectMake(kMargin, kMargin /2.f, contentRect.size.width - kMargin *2, self.frame.size.height *2 /3.f);
    return rect;
    
}
- (CGRect) titleRectForContentRect:(CGRect)contentRect
{
    CGRect rect = CGRectMake(kMargin /2.f, CGRectGetMaxY(self.imageView.frame), contentRect.size.width - kMargin , self.frame.size.height  /3.f);
    return rect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
