//
//  CUShowView.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/17.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "CUShowView.h"
#import <QuartzCore/QuartzCore.h>

#ifdef __IPHONE_6_0
# define IFLY_ALIGN_CENTER NSTextAlignmentCenter
#else
# define IFLY_ALIGN_CENTER UITextAlignmentCenter
#endif

@implementation CUShowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.75f];
        self.layer.cornerRadius = 5.0f;
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 100, 10)];
        _textLabel.numberOfLines = 0;
        _textLabel.font = [UIFont systemFontOfSize:17.f];
        _textLabel.textColor = [UIColor greenColor];
        _textLabel.textAlignment = IFLY_ALIGN_CENTER;
        _textLabel.backgroundColor = [UIColor blackColor];
        [self addSubview:_textLabel];
        
        // Create and add the activity indicator
        _aiv = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_aiv startAnimating];
        [self addSubview:_aiv];
        _queueCount = 0;
        
        // Create and add the GIf
        self.arr = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"loading-1"],[UIImage imageNamed:@"loading-2"],[UIImage imageNamed:@"loading-3"],[UIImage imageNamed:@"loading-4"], nil];
        self.imageViewGif = [[UIImageView alloc]initWithFrame:CGRectMake(5, 40, 100, 100)];
        self.imageViewGif.animationImages = self.arr;
        self.imageViewGif.animationDuration = 2;
        [self.imageViewGif startAnimating];
        [self addSubview:self.imageViewGif];
        
    }
    return self;
}

- (void)setText:(NSString *)text
{
     _textLabel.frame = CGRectMake(0, 10, 100, 10);
    _textLabel.text = text;
    [_textLabel sizeToFit];
    CGRect frame =  CGRectMake(5, 0, _textLabel.frame.size.width, _textLabel.frame.size.height);
    _textLabel.frame = frame;
    _textLabel.frame = CGRectMake(_textLabel.frame.origin.x + 40, _textLabel.frame.origin.y + 10,_textLabel.frame.size.width, _textLabel.frame.size.height);
    frame = CGRectMake((_ParentView.frame.size.width - (frame.size.width + 10 + 45))/2, self.frame.origin.y, _textLabel.frame.size.width + 10 + 45, _textLabel.frame.size.height + 120);
    
    _aiv.center = CGPointMake(25, _textLabel.bounds.size.height);
    self.imageViewGif.frame = CGRectMake(5, 40, _textLabel.frame.size.width, 100);
    self.frame = frame;
    
}

- (void)show
{
    self.alpha = 1.0f;
}

- (void)hide
{
    self.alpha = 0.0f;
}































@end
