//
//  SharpLabel.m
//  Tadpole

//  Created by ss-iOS-LLY on 16/5/19.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.



#import "SharpLabel.h"
#define ORC_RADIUS  8


@implementation SharpLabel
@synthesize label;

- (id)init:(CGPoint) p str:(NSString *)str
{
    if (self = [super init]) {
        path = [[UIBezierPath alloc]init];
        [path setLineWidth:1.f];
        self.label = [[UILabel alloc]init];
        self.label.numberOfLines = 0;
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.label setBackgroundColor: [UIColor clearColor]];
        font = [UIFont systemFontOfSize:18.f];
        self.label.font = font;
        self.label.textColor = [UIColor redColor];
        [self setBackgroundColor:[UIColor clearColor]];
        self.alpha = 0.8;
        [self addSubview:self.label];
        [self set_point:p];
        [self set_title:str];
        
    }
    return self;
}

- (void)reloadData
{
    [self setNeedsDisplay];
}

- (void)set_point:(CGPoint)p{
    point = p;
}
- (void)set_title:(NSString *)str
{
   
    self.label.text = str;
    size = CGSizeMake(80, 30);
    self.label.frame = CGRectMake(ORC_RADIUS, ORC_RADIUS/2, size.width, size.height);
    size.height += ORC_RADIUS *2;
    size.width +=ORC_RADIUS * 2;
    double x = point.x - size.width / 2;
    double y = point.y - size.height;
    origin.x = x;
    origin.y = y;
    self.frame = CGRectMake(origin.x, origin.y, size.width, size.height);

    
    [self set_path];
}

-(void)drawRect:(CGRect)rect
{
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    [[UIColor redColor] setStroke];
    [path stroke];
}
- (void)set_path
{
     CGPoint p = CGPointMake(1, 1);
    double h = (size.width - 2)/ 2 - ORC_RADIUS/2;
   
    
    [path moveToPoint:p];
    p.y = (size.height - ORC_RADIUS *1  + 1);
    [path addLineToPoint:p];
    
    p.x += h;
    [path addLineToPoint:p];
 
    p.y += (ORC_RADIUS ) ;
    p.x += 4; //指向的长度4
    [path addLineToPoint:p];

    p.y -= (ORC_RADIUS );
    p.x +=4;
    [path addLineToPoint: p];

    p.x += h;
    [path addLineToPoint: p];
    p.y -= (size.height -ORC_RADIUS  );
    [path addLineToPoint: p];
    
    p.x -= size.width - 1;
    //[path addLineToPoint: p];
    
    [path closePath];
}





























@end
