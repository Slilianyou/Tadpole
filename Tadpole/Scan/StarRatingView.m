//
//  StarRatingView.m
//  StarRating
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 SIXIN. All rights reserved.
//

#import "StarRatingView.h"

@interface StarRatingView ()
{
    CGSize unitSize;    
}

@property NSInteger starsNumber;

@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;
@end

@implementation StarRatingView

- (id)initWithFrame:(CGRect)frame numberOfStar:(NSInteger)number touchEnable:(BOOL)touchEnable
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.starsNumber = number;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = touchEnable;
        
        unitSize = CGSizeZero;
    }
    return self;
}

- (void)makeRatingView

{
    NSString *defaultMinImage ;
    NSString *defaultMaxImage ;
//    if(self.isSmallImg){
//        defaultMinImage = @"starselected1.png";
//        defaultMaxImage = @"starnomal1.png";
//
//    }else{
       defaultMinImage = @"xing1";
        defaultMaxImage = @"xingxing";
//    }
   
    if ([self.minImgName length])
    {
        defaultMinImage = self.minImgName;
    }
    if ([self.maxImgName length])
    {
        defaultMaxImage = self.maxImgName;
    }
    self.starBackgroundView = [self buidlStarViewWithImageName:defaultMaxImage];
    self.starForegroundView = [self buidlStarViewWithImageName:defaultMinImage];
    
    [self addSubview:self.starBackgroundView];
    [self addSubview:self.starForegroundView];
}

- (void)setCustomStarSize:(CGSize)size
{
    unitSize = size;
}

- (void)setDefaultRatingValue:(float)score
{
//    [self changeStarForegroundViewWithPoint:CGPointMake(self.frame.size.width /self.starsNumber  *score, self.frame.size.height)];
    CGFloat totalWidth = ((self.starsNumber - 1) * self.gapValue) + unitSize.width * self.starsNumber;
    float marggin = (CGRectGetWidth(self.frame)-self.starsNumber*unitSize.width-(self.starsNumber-1)* self.gapValue)/2 ;
    [self changeStarForegroundViewWithPoint:CGPointMake(marggin+ score * (totalWidth / self.starsNumber), self.frame.size.height)];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if(CGRectContainsPoint(rect,point))
    {
        [self changeStarForegroundViewWithPoint:point];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    __weak StarRatingView * weekSelf = self;
    
    [UIView transitionWithView:self.starForegroundView
                      duration:0.2
                       options:UIViewAnimationOptionCurveEaseInOut
                    animations:^
     {
         [weekSelf changeStarForegroundViewWithPoint:point];
     }
                    completion:^(BOOL finished)
     {
         
     }];
}

- (UIView *)buidlStarViewWithImageName:(NSString *)imageName
{
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc] initWithFrame:frame];
  
    view.clipsToBounds = YES;
    UIImage *img = [UIImage imageNamed:imageName];

   
    if (CGSizeEqualToSize(unitSize, CGSizeZero))
    {
        unitSize = img.size;
    }
    float marggin = (frame.size.width-self.starsNumber*unitSize.width-(self.starsNumber-1)* self.gapValue)/2 ;
    
    for (int i = 0; i < self.starsNumber; i ++)
    {
        CGSize size = unitSize;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
//        imageView.frame = CGRectMake(i * frame.size.width / self.starsNumber, 0, frame.size.width / self.starsNumber, frame.size.height);
        imageView.frame = CGRectMake(marggin+ i * (size.width + self.gapValue), (CGRectGetHeight(view.frame)-size.height)/2, size.width, size.height);

        [view addSubview:imageView];
    }
   
    return view;
}

- (void)changeStarForegroundViewWithPoint:(CGPoint)point
{
    CGPoint p = point;
    float marggin = (CGRectGetWidth(self.frame)-self.starsNumber*unitSize.width-(self.starsNumber-1)* self.gapValue)/2 ;
    CGFloat totalWidth =2*marggin+ ((self.starsNumber - 1) * self.gapValue) + unitSize.width * self.starsNumber;
    
    if (p.x < 0)
    {
        p.x = 0;
    }

    else if (p.x > totalWidth)
    {
        p.x = totalWidth;
    }
    
    int score = ceilf((p.x-marggin) / (self.gapValue + unitSize.width));
    self.starForegroundView.frame = CGRectMake(0, 0,marggin+ (self.gapValue + unitSize.width) * score, self.frame.size.height);
    
    _curRatingValue = score;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(starRatingView: score:)])
    {
        [self.delegate starRatingView:self score:score];
    }
}





@end



