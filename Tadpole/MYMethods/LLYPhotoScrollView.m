//
//  LLYPhotoScrollView.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/27.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "LLYPhotoScrollView.h"

@implementation LLYPhotoScrollView
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.scrollEnabled = YES;
        self.pagingEnabled = NO;
        self.clipsToBounds = NO;
        self.maximumZoomScale = 3.0f;
        self.minimumZoomScale = 1.0f;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.alwaysBounceVertical = NO;
        self.alwaysBounceHorizontal = NO;
        self.bouncesZoom = YES;
        self.bounces = YES;
        self.scrollsToTop = NO;
        self.backgroundColor = [UIColor blackColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.canZoom = YES;
    }
    return self;
}

- (void)setCanZoom:(BOOL)canZoom
{
    _canZoom = canZoom;
    if (_canZoom) {
        self.maximumZoomScale = 3.0f;
        self.minimumZoomScale = 1.0;
    } else {
        self.maximumZoomScale = 1.0f;
        self.minimumZoomScale = 1.0;
    }
}

- (void)zoomToRectWithCenter:(CGPoint)center
{
//    if (self.zoomScale > 1.0f) {
//        []
//    }
}

- (void)toggleBars
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"LLYPhotoScrllViewToggleBars" object:nil];
}
#pragma mark -
#pragma mark Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    if (touch.tapCount == 1) {
        [self performSelector:@selector(toggleBars) withObject:nil afterDelay:.2];
    } else if (touch.tapCount == 2){
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(toggleBars) object:nil];
        if (_canZoom) {
//            [self ]
        }
    }
}























@end
