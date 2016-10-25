//
//  LoadingView.m
//  EZhuiSu
//
//  Created by ss-iOS-LLY on 16/10/17.
//  Copyright © 2016年 Paiwogou@syscanit.com. All rights reserved.
//

#import "LoadingView.h"
#import <QuartzCore/CABase.h>


CGFloat const UNIT_RADIUS = 5;  // 单位半径
CGFloat const SPOT_DELAY_RATIO = 0.08f;                         //污点弹出延迟系数
CGFloat const PROCESS_DURING = 3.6f;                            //动画时间
CGFloat const SPOT_MAGNIFY_ANIM_DURATION_RATIO = 0.03f;//污点变大间隔时间单位
NSString *const EFFECT_TOKEN_LEFT = @"EFFECT_TOKEN_LEFT"; // 可对左边污点造成影响
NSString *const EFFECT_TOKEN_RIGHT = @"EFFECT_TOKEN_RIGHT"; // 可对右边污点造成影响
CGFloat const COORDINATE_CORRECTION_OFFSET = 2.2f;              //修正path超出图形的情况
CGFloat const OCCUR_STICKY_DISTANCE = 20.0f;                    //触发粘连的距离

@interface LoadingView ()
@property (nonatomic, strong) CADisplayLink *mainDisPlayLink;
@property (nonatomic, strong) UIColor *spotColor;
@property (nonatomic, strong) UIView *stickyView;
@property (strong, nonatomic) NSMutableArray *movingSpots;

@property (nonatomic, strong) CAShapeLayer *stickyShapeLayer;
@property (nonatomic, strong) CAShapeLayer *stickyShapeLayerRight;
@property (nonatomic, strong) CAShapeLayer *stickyShapeLayerLeftRear; // rear 后方的
@property (nonatomic, strong) CAShapeLayer *stickyShapeLayerRightRear;
@property (nonatomic, strong) Spot *leftFixedSpot;
@property (nonatomic, strong) Spot *rightFixedSpot;

@end
@implementation LoadingView
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor
{
    self =[super init];
    if (self) {
        [self setFrame: frame];
        [self configureLoaderWithColor:color];
        self.backgroundColor = backgroundColor;
    }
    return self;
}

- (void)configureLoaderWithColor:(UIColor *)spotColor
{
    self.spotColor = spotColor;
    [self addStickyView];
    
    CGFloat margin = self.bounds.size.width / 4;
    CGFloat originX = margin;
    CGFloat finalX = self.bounds.size.width - margin;
    CGFloat originRearX = originX - 4 *UNIT_RADIUS;
    CGFloat finalRearX = finalX + 4*UNIT_RADIUS;
    
    // Fixed Spot  固定点
    self.leftFixedSpot = [[Spot alloc]initWithFrame:CGRectMake(originX - UNIT_RADIUS, self.bounds.size.height / 2 - UNIT_RADIUS, 2*UNIT_RADIUS, 2*UNIT_RADIUS) color:spotColor];
    self.rightFixedSpot = [[Spot alloc] initWithFrame:CGRectMake(self.bounds.size.width - margin - UNIT_RADIUS, self.bounds.size.height / 2 -UNIT_RADIUS, 2 *UNIT_RADIUS, 2 *UNIT_RADIUS) color:spotColor];
    NSValue *firstVal = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0)];
     NSValue *secondVal = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.0, 2.0, 0)];
     NSValue *thirdVal = [NSValue valueWithCATransform3D:CATransform3DMakeScale(3.0, 3.0, 0)];
     NSValue *fourthVal = [NSValue valueWithCATransform3D:CATransform3DMakeScale(4.0, 4.0, 0)];
    self.leftFixedSpot.layer.transform = CATransform3DMakeScale(4.f, 4.f, 0);
    
    //
    CAKeyframeAnimation *leftFixedSpotAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    leftFixedSpotAnim.values = @[thirdVal,fourthVal,fourthVal,thirdVal,thirdVal,secondVal,secondVal, firstVal,firstVal,secondVal,secondVal,thirdVal,thirdVal];
    
    CGFloat ti = SPOT_MAGNIFY_ANIM_DURATION_RATIO;
    leftFixedSpotAnim.keyTimes = @[@(0.0),@(0.0+ti),@(0.25),@(0.25 +ti), @(0.33),@(0.33 +ti), @(0.41),@(0.41 + ti),//sleep
          @(0.84),@(0.84 +ti),@(0.92),@(0.92 +ti),@(1.0)                         ];
    leftFixedSpotAnim.duration = PROCESS_DURING;
    leftFixedSpotAnim.repeatCount = HUGE_VALF;
    [self.leftFixedSpot.layer addAnimation:leftFixedSpotAnim forKey:@"fixedSpotScaleAnim"];
    
    
    // right
    CAKeyframeAnimation *rightFixedSpotAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    rightFixedSpotAnim.values = @[firstVal,firstVal,secondVal,secondVal,thirdVal,thirdVal,fourthVal,fourthVal,thirdVal,thirdVal,secondVal,secondVal,firstVal,firstVal];
    rightFixedSpotAnim.keyTimes = @[@(0.0),@(0.25),@(0.25 +ti),@(0.33),@(0.33 + ti),@(0.41),@(0.41 + ti),@(0.65),@(0.65 + ti),@(0.73),@(0.73 + ti),@(0.81),@(0.81 + ti),@(1.0)];
    rightFixedSpotAnim.duration = PROCESS_DURING;
    rightFixedSpotAnim.repeatCount = HUGE_VALF;
    rightFixedSpotAnim.beginTime = CACurrentMediaTime() + PROCESS_DURING *0.1;
    [self.rightFixedSpot.layer addAnimation:rightFixedSpotAnim forKey:@"FixedSpotScaleAnim"];
    
    [self addSubview:self.leftFixedSpot];
    [self addSubview:self.rightFixedSpot];
    
    //moving Spot
    for (int i = 0; i < 3; i++) {
        Spot *movingSpot = [[Spot alloc]initWithFrame:CGRectMake(originX -UNIT_RADIUS, self.bounds.size.height/ 2 - UNIT_RADIUS, 2*UNIT_RADIUS, 2*UNIT_RADIUS) color:spotColor];
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
        anim.values = @[@(originX),@(originX),@(finalX),@(finalRearX), @(finalX),
                        @(finalX), @(originX),    @(originRearX), @(originX), @(originX)];
        anim.keyTimes = @[@(0.0),@(0.25),@(0.35),@(0.38), @(0.41),
                           @(0.75), @(0.85),    @(0.88), @(0.91), @(1.0)];
        anim.duration = PROCESS_DURING;
        anim.repeatCount = HUGE_VALF;
        anim.beginTime = CACurrentMediaTime() + i * SPOT_DELAY_RATIO *PROCESS_DURING;
        [movingSpot.layer addAnimation:anim forKey:@"movingAnim"];
        movingSpot.tag = i;
        [self.movingSpots addObject:movingSpot];
        [self addSubview:movingSpot];
        
        
        [CATransaction begin];
       // 设置变化动画过程是否显示，默认为YES不显示
        [CATransaction setDisableActions:YES];
        [CATransaction commit];

    }
    
    [self configureDisplayLink];
}
//油污View
- (void)addStickyView
{
    self.stickyView = [[UIView alloc]initWithFrame:self.bounds];
    [self configureStickyShapelayer];
    [self addSubview: self.stickyView];
}

- (void)configureStickyShapelayer
{
    self.stickyShapeLayer = [[CAShapeLayer alloc]init];
    self.stickyShapeLayerRight = [[CAShapeLayer alloc]init];
    self.stickyShapeLayerLeftRear= [[CAShapeLayer alloc]init];
    self.stickyShapeLayerRightRear = [[CAShapeLayer alloc]init];
    [_stickyView.layer insertSublayer:_stickyShapeLayer above:_stickyView.layer];
    [_stickyView.layer insertSublayer:_stickyShapeLayerRight above:_stickyView.layer];
    [_stickyView.layer insertSublayer:_stickyShapeLayerLeftRear above:_stickyView.layer];
    [_stickyView.layer insertSublayer:_stickyShapeLayerRight above:_stickyView.layer];
}

- (void)configureDisplayLink
{
    if (_mainDisPlayLink == nil) {
        _mainDisPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction:)];
        [_mainDisPlayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }

}

- (void)displayLinkAction:(CADisplayLink *)displayLink
{
    CALayer *leftFixSpotPreLayer = _leftFixedSpot.layer.presentationLayer;
    CALayer *rightFixSpotPreLayer = _rightFixedSpot.layer.presentationLayer;
    
    CGPoint leftFixSpotPosition = leftFixSpotPreLayer.position;
    CGPoint rightFixSpotPosition = rightFixSpotPreLayer.position;
    
    CGPoint pointLeftU = CGPointMake(leftFixSpotPosition.x, leftFixSpotPosition.y - (leftFixSpotPreLayer.frame.size.height/2 -COORDINATE_CORRECTION_OFFSET));
    CGPoint pointLeftD = CGPointMake(leftFixSpotPosition.x, leftFixSpotPosition.y + leftFixSpotPreLayer.frame.size.height/2 - COORDINATE_CORRECTION_OFFSET);
    CGPoint pointRightU = CGPointMake(rightFixSpotPosition.x, rightFixSpotPosition.y - rightFixSpotPreLayer.frame.size.height/2 + COORDINATE_CORRECTION_OFFSET);
    CGPoint pointRightD = CGPointMake(rightFixSpotPosition.x, rightFixSpotPosition.y + rightFixSpotPreLayer.frame.size.height/2 - COORDINATE_CORRECTION_OFFSET);
    
    //圆心距(left)
    for (Spot *movingSpot in self.movingSpots) {
        CALayer *movingSpotPreLayer = movingSpot.layer.presentationLayer;
        if ([self circleIncirclingWithBigOne:leftFixSpotPreLayer smallOne:movingSpotPreLayer] ||
            [self circleIncirclingWithBigOne:rightFixSpotPreLayer smallOne:movingSpotPreLayer]) {
            if (movingSpot.isFirstTimeToBlend) {
                [self cleanResiduePath:movingSpot];
            } else if (movingSpot.isFirstTimeToSpringBack) {
                [self cleanRearResidePath:movingSpot];
            }
            continue;
        }
        
        CGFloat fdLeft = [self faceDistanceWithCircleLayer:leftFixSpotPreLayer another:movingSpotPreLayer];
        CGFloat fdRight = [self faceDistanceWithCircleLayer:rightFixSpotPreLayer another:movingSpotPreLayer];
        
        
        if (movingSpot.effectToken == EFFECT_TOKEN_LEFT) {
            //排除内切圆 和 圆心距大于30 的情况
            if (fdLeft < OCCUR_STICKY_DISTANCE) {
                CGPoint movingSpotPosition = movingSpotPreLayer.position;
                
                CGPoint pointMovingU = CGPointMake(movingSpotPosition.x, movingSpotPosition.y - movingSpotPreLayer.frame.size.height/2);
                CGPoint pointMovingD = CGPointMake(movingSpotPosition.x, movingSpotPosition.y + movingSpotPreLayer.frame.size.height/2);
                
                CGFloat controlPointX = (leftFixSpotPosition.x - movingSpotPosition.x)/2 + movingSpotPosition.x;
                CGFloat controlPointUpY = pointMovingU.y;
                CGFloat controlPointDownY = pointMovingD.y;
                
                CGPoint controlPointUp = CGPointMake(controlPointX, controlPointUpY);
                CGPoint controlPointDown = CGPointMake(controlPointX, controlPointDownY);
                
                //这里可以动态根据fixSpot的scale来改变MovingPoint的值(专门虚拟一个来做回弹).
                if (movingSpotPosition.x < leftFixSpotPosition.x) {
                    //隐藏真实movingSpot
                    movingSpot.alpha = 0.f;
                    CGFloat scale = leftFixSpotPreLayer.frame.size.width / _rightFixedSpot.frame.size.width;
                    CGFloat virtualExcursion = scale * -UNIT_RADIUS;
                    int basicScale = 2;
                    if (2 == scale) {
                        virtualExcursion = scale * -0.6 * UNIT_RADIUS;
                    } else if (3 == scale) {
                        virtualExcursion = 0;
                    } else if (4 == scale) {
                        virtualExcursion = (scale - basicScale) * 0.4 * UNIT_RADIUS;
                    }
                    
                    
                    CGPoint virtualCenter = CGPointMake(movingSpotPosition.x - virtualExcursion, movingSpotPosition.y);
                    
                    CGFloat moving45degreesX = UNIT_RADIUS * sinf(35/180.f * M_PI);
                    CGFloat moving45degreesY = UNIT_RADIUS * cosf(35/180.f * M_PI);
                    CGPoint moving45degreesU = CGPointMake(movingSpotPosition.x - virtualExcursion - moving45degreesX, movingSpotPosition.y - moving45degreesY);
                    CGPoint moving45degreesD = CGPointMake(movingSpotPosition.x - virtualExcursion - moving45degreesX, movingSpotPosition.y + moving45degreesY);
                    
                    UIBezierPath *stickyPath = [UIBezierPath bezierPath];
                    [stickyPath moveToPoint:pointLeftU];
                    [stickyPath addLineToPoint:moving45degreesU];
                    [stickyPath addArcWithCenter:virtualCenter radius:movingSpotPreLayer.frame.size.width/2 startAngle:-M_PI/2 endAngle:M_PI/2 clockwise:NO];
                    [stickyPath addLineToPoint:moving45degreesD];
                    [stickyPath addLineToPoint:pointLeftD];
                    [stickyPath closePath];
                    
                    self.stickyShapeLayerLeftRear.path = stickyPath.CGPath;
                    _stickyShapeLayerLeftRear.fillColor = self.spotColor.CGColor;
                    [self.stickyShapeLayerLeftRear removeAllAnimations];
                    movingSpot.isFirstTimeToSpringBack = YES;
                } else {
                    //恢复真实movingSpot
                    movingSpot.alpha = 1.f;
                    UIBezierPath *stickyPath = [UIBezierPath bezierPath];
                    [stickyPath moveToPoint:pointLeftU];
                    [stickyPath addQuadCurveToPoint:pointMovingU controlPoint:controlPointUp];
                    [stickyPath addArcWithCenter:movingSpotPreLayer.position radius:movingSpotPreLayer.frame.size.width/2 startAngle:-M_PI/2 endAngle:M_PI/2 clockwise:YES];
                    [stickyPath addQuadCurveToPoint:pointLeftD controlPoint:controlPointDown];
                    [stickyPath closePath];
                    
                    self.stickyShapeLayer.path = stickyPath.CGPath;
                    _stickyShapeLayer.fillColor = self.spotColor.CGColor;
                    [self.stickyShapeLayer removeAllAnimations];
                    //处理过，允许换令牌
                    movingSpot.allowChangeEffectToken = YES;
                    movingSpot.isFirstTimeToBlend = YES;
                }
            } else {
                _stickyShapeLayer.fillColor = self.backgroundColor.CGColor;
                [self.stickyShapeLayer removeAllAnimations];
                if (movingSpot.allowChangeEffectToken) {
                    //失去令牌,不会再进此 if else
                    movingSpot.effectToken = EFFECT_TOKEN_RIGHT;
                    movingSpot.allowChangeEffectToken = NO;
                }
            }
        } else if (movingSpot.effectToken == EFFECT_TOKEN_RIGHT) {
            if (fdRight < OCCUR_STICKY_DISTANCE) {
                CGPoint movingSpotPosition = movingSpotPreLayer.position;
                
                CGPoint pointMovingU = CGPointMake(movingSpotPosition.x, movingSpotPosition.y - movingSpotPreLayer.frame.size.height/2);
                CGPoint pointMovingD = CGPointMake(movingSpotPosition.x, movingSpotPosition.y + movingSpotPreLayer.frame.size.height/2);
                
                
                CGFloat controlPointX = (rightFixSpotPosition.x - movingSpotPosition.x)/2 + movingSpotPosition.x;
                CGFloat controlPointUpY = pointMovingU.y;
                CGFloat controlPointDownY = pointMovingD.y;
                
                CGPoint controlPointUp = CGPointMake(controlPointX, controlPointUpY);
                CGPoint controlPointDown = CGPointMake(controlPointX, controlPointDownY);
                
                if (movingSpotPosition.x > rightFixSpotPosition.x) {
                    //隐藏真实movingSpot
                    movingSpot.alpha = 0.f;
                    CGFloat scale = rightFixSpotPreLayer.frame.size.width / _rightFixedSpot.frame.size.width;
                    CGFloat virtualExcursion = scale * -UNIT_RADIUS;
                    int basicScale = 2;
                    if (2 == scale) {
                        virtualExcursion = scale * -0.6 * UNIT_RADIUS;
                    } else if (3 == scale) {
                        virtualExcursion = 0;
                    } else if (4 == scale) {
                        virtualExcursion = (scale - basicScale) * 0.4 * UNIT_RADIUS;
                    }
                    
                    
                    CGPoint virtualCenter = CGPointMake(movingSpotPosition.x + virtualExcursion, movingSpotPosition.y);
                    
                    CGFloat moving45degreesXY = UNIT_RADIUS * sinf(35/180.f * M_PI);
                    CGFloat moving45degreesY = UNIT_RADIUS * cosf(35/180.f * M_PI);
                    CGPoint moving45degreesU = CGPointMake(movingSpotPosition.x + virtualExcursion + moving45degreesXY, movingSpotPosition.y - moving45degreesY);
                    CGPoint moving45degreesD = CGPointMake(movingSpotPosition.x + virtualExcursion + moving45degreesXY, movingSpotPosition.y + moving45degreesY);
                    
                    UIBezierPath *stickyPath = [UIBezierPath bezierPath];
                    [stickyPath moveToPoint:pointRightU];
                    [stickyPath addLineToPoint:moving45degreesU];
                    [stickyPath addArcWithCenter:virtualCenter radius:movingSpotPreLayer.frame.size.width/2 startAngle:-M_PI/2 endAngle:M_PI/2 clockwise:YES];
                    [stickyPath addLineToPoint:moving45degreesD];
                    [stickyPath addLineToPoint:pointRightD];
                    [stickyPath closePath];
                    self.stickyShapeLayerRightRear.path = stickyPath.CGPath;
                    _stickyShapeLayerRightRear.fillColor = self.spotColor.CGColor;
                    [self.stickyShapeLayerRightRear removeAllAnimations];
                    movingSpot.isFirstTimeToSpringBack = YES;
                } else {
                    //恢复真实movingSpot
                    movingSpot.alpha = 1.f;
                    UIBezierPath *stickyPath = [UIBezierPath bezierPath];
                    [stickyPath moveToPoint:pointRightU];
                    [stickyPath addQuadCurveToPoint:pointMovingU controlPoint:controlPointUp];
                    [stickyPath addArcWithCenter:movingSpotPreLayer.position radius:movingSpotPreLayer.frame.size.width/2 startAngle:-M_PI/2 endAngle:M_PI/2 clockwise:NO];
                    [stickyPath addQuadCurveToPoint:pointRightD controlPoint:controlPointDown];
                    [stickyPath closePath];
                    self.stickyShapeLayerRight.path = stickyPath.CGPath;
                    _stickyShapeLayerRight.fillColor = self.spotColor.CGColor;
                    [self.stickyShapeLayerRight removeAllAnimations];
                    //处理过，允许换令牌
                    movingSpot.allowChangeEffectToken = YES;
                    movingSpot.isFirstTimeToBlend = YES;
                }
            } else {
                _stickyShapeLayerRight.fillColor = self.backgroundColor.CGColor;
                [self.stickyShapeLayerRight removeAllAnimations];
                if (movingSpot.allowChangeEffectToken) {
                    //失去令牌,不会再进此 if else
                    movingSpot.effectToken = EFFECT_TOKEN_LEFT;
                    movingSpot.allowChangeEffectToken = NO;
                }
            }
        }
    }
}

- (void)cleanResiduePath:(Spot *)spot {
    CAShapeLayer *handleLayer;
    if (spot.effectToken == EFFECT_TOKEN_LEFT) {
        handleLayer = _stickyShapeLayer;
    } else {
        handleLayer = _stickyShapeLayerRight;
    }
    handleLayer.fillColor = self.backgroundColor.CGColor;
    [handleLayer removeAllAnimations];
    spot.isFirstTimeToBlend = NO;
}

- (void)cleanRearResidePath:(Spot *)spot {
    CAShapeLayer *handleLayer;
    if (spot.effectToken == EFFECT_TOKEN_LEFT) {
        handleLayer = _stickyShapeLayerLeftRear;
    } else {
        handleLayer = _stickyShapeLayerRightRear;
    }
    handleLayer.fillColor = self.backgroundColor.CGColor;
    [handleLayer removeAllAnimations];
    spot.isFirstTimeToSpringBack = NO;
}

- (void)spotChangeEffectToken:(Spot *)spot {
    if (spot.allowChangeEffectToken) {
        spot.effectToken = spot.effectToken == EFFECT_TOKEN_LEFT ? EFFECT_TOKEN_RIGHT : EFFECT_TOKEN_LEFT;
        spot.allowChangeEffectToken = NO;
    }
}

- (CGFloat)centerDistanceWithPoint:(CGPoint)point another:(CGPoint)another {
    CGFloat x1 = point.x;
    CGFloat y1 = point.y;
    CGFloat x2 = another.x;
    CGFloat y2 = another.y;
    return sqrtf((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
}

- (CGFloat)faceDistanceWithCircleLayer:(CALayer *)layer another:(CALayer *)another {
    CGFloat cd = [self centerDistanceWithPoint:layer.position another:another.position];
    return cd - (layer.frame.size.width + another.frame.size.width)/2;
}

- (BOOL)circleIncirclingWithBigOne:(CALayer *)bigOne smallOne:(CALayer *)smallOne {
    CGFloat cd = [self centerDistanceWithPoint:bigOne.position another:smallOne.position];
    return (cd < (bigOne.frame.size.width - smallOne.frame.size.width)/2);
}


//lazy
- (NSMutableArray *)movingSpots {
    if (nil == _movingSpots) {
        _movingSpots = [NSMutableArray array];
    }
    return _movingSpots;
}












@end

#pragma CLASS - Spot

@implementation Spot
-(instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        [self assignEffectToken];
        [self drawLittleSpotWithColor:color];
    }
    return self;
}
- (void)assignEffectToken
{
    self.effectToken = EFFECT_TOKEN_LEFT;
}
- (void)drawLittleSpotWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 3*[UIScreen mainScreen].scale);
    CGContextSetShouldAntialias(UIGraphicsGetCurrentContext(), YES);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, 0.5, 0.5)];
    [color setFill];
    [path fill];
    self.layer.contents = (__bridge id _Nullable)((UIGraphicsGetImageFromCurrentImageContext().CGImage));
    UIGraphicsEndImageContext();
}
@end
































