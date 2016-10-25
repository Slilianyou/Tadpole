//
//  LLYPhotoCaptionView.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/27.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "LLYPhotoCaptionView.h"
#import  <QuartzCore/QuartzCore.h>

@implementation LLYPhotoCaptionView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
        self.autoresizingMask =UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.f, 0.0f, self.frame.size.width - 40.0f, 40.f)];
        _textLabel.autoresizingMask =UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = UITextAlignmentCenter;
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.shadowColor = [UIColor blackColor];
        _textLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        [self addSubview:_textLabel];


    }
    return self;
}

- (void)layoutSubviews
{
    [self setNeedsDisplay];
    _textLabel.frame = CGRectMake(20.0f, 0.0f, self.frame.size.width - 40.0f, 40.f);
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();// 设置上下文
    [[UIColor colorWithWhite:1.0f alpha:0.8] setStroke];  //设置画笔颜色
    CGContextMoveToPoint(ctx, 0.0f, 0.0f);//开始画线
    CGContextAddLineToPoint(ctx, self.frame.size.width, 0.0f); // 画直线
    CGContextStrokePath(ctx);//开始绘制图片
}

- (void)setCaptionText:(NSString *)text hidden:(BOOL)val
{
    if (text == nil|| [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        _textLabel.text = nil;
        [self setHidden:YES];
    } else {
        [self setHidden:val];
        _textLabel.text = text;
    }
}

- (void)setCaptionHidden:(BOOL)hidden
{
    if (_hidden == hidden) return;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2f];
    if (hidden) {
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];//设置动画块中的动画属性变化的曲线
        self.frame = CGRectMake(0.0f, self.superview.frame.size.height, self.frame.size.width, self.frame.size.height);
    } else {
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        CGFloat toolbarSize = UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication]statusBarOrientation]) ? 32.f :44.0f;
        self.frame = CGRectMake(0.0f, self.superview.frame.size.height - (toolbarSize + self.frame.size.height), self.frame.size.width, self.frame.size.height);
    }
    [UIView commitAnimations];
    _hidden = hidden;
}


#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
    _textLabel=nil;
}


















@end
