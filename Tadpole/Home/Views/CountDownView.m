//
//  CountDownView.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/5/6.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "CountDownView.h"


@interface CountDownView ()
{
    UILabel *_labelPoint1;
    UILabel *_labelPoint2;
    NSInteger _countDown;
    NSTimer * _timeSch;
}

@end
@implementation CountDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //
        self.textLabel = [[UILabel alloc]init];
        self.textLabel.font = [UIFont systemFontOfSize:10.f];
        self.textLabel.text = @"距结束";
        [self addSubview:self.textLabel];
        
        //
        self.hourLabel = [[UILabel alloc]init];
        self.hourLabel.backgroundColor = [UIColor whiteColor];
        self.hourLabel.textAlignment = NSTextAlignmentCenter;
        self.hourLabel.font = [UIFont systemFontOfSize:8.f];
        self.hourLabel.textColor = [UIColor orangeColor];
        [self addSubview:self.hourLabel];
        
        _labelPoint1 =[[UILabel alloc]init];
        _labelPoint1.font = [UIFont systemFontOfSize:8.f];
        _labelPoint1.textColor = [UIColor blackColor];
        _labelPoint1.textAlignment =NSTextAlignmentCenter;
        _labelPoint1.text = @":";
        _labelPoint1.backgroundColor = [UIColor clearColor];
        [self addSubview:_labelPoint1];
        
        
        self.minLabel = [[UILabel alloc]init];
        self.minLabel.backgroundColor = [UIColor whiteColor];
        self.minLabel.textAlignment = NSTextAlignmentCenter;
        self.minLabel.font = [UIFont systemFontOfSize:8.f];
        self.minLabel.textColor = [UIColor orangeColor];
        [self addSubview:self.minLabel];
        
        _labelPoint2 =[[UILabel alloc]init];
        _labelPoint2.textAlignment =NSTextAlignmentCenter;
        _labelPoint2.font = [UIFont systemFontOfSize:8.f];
        _labelPoint2.textColor = [UIColor blackColor];
        _labelPoint2.text = @":";
        _labelPoint2.backgroundColor = [UIColor clearColor];
        [self addSubview:_labelPoint2];
        
        self.secondLabel = [[UILabel alloc]init];
        self.secondLabel.backgroundColor = [UIColor whiteColor];
        self.secondLabel.textAlignment = NSTextAlignmentCenter;
        self.secondLabel.font = [UIFont systemFontOfSize:8.f];
        self.secondLabel.textColor = [UIColor orangeColor];
        [self addSubview:self.secondLabel];
    }
    return self;
}

- (void)setDataWithNSDic:(NSDictionary *)dic
{
   
    
    self.textLabel.frame = CGRectMake(6, 2, 36, self.height - 4);
    
    CGFloat w = (self.width - 6 - 8 - self.textLabel.right) / 3;
    
    self.hourLabel.text = @"00";
    self.hourLabel.frame = CGRectMake(self.textLabel.right, 5, w, self.height - 10);
    
    _labelPoint1.frame = CGRectMake(self.hourLabel.right, 5, 4, self.height - 10);
    
    self.minLabel.text = @"00";
    self.minLabel.frame = CGRectMake(_labelPoint1.right, 5, w, self.height - 10);
    
    _labelPoint2.frame = CGRectMake(self.minLabel.right, 5, 4, self.height - 10);
    
    self.secondLabel.text = @"00";
    self.secondLabel.frame = CGRectMake(_labelPoint2.right, 5, w, self.height - 10);
    
    self.layer.cornerRadius = 13.f;
    self.layer.masksToBounds = YES;
    
    NSString *countDownStr = [dic objectForKey:kCountDown];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *countDate = [dateFormatter dateFromString:countDownStr];
    
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:countDate];
    NSDate *localDate = [countDate dateByAddingTimeInterval:interval];
    NSTimeInterval timeInterval = [localDate timeIntervalSinceNow];
    //
    
    
    _countDown  = round(timeInterval);
 
    
 
    
  _timeSch =  [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
}

- (void)countDown:(NSInteger)countDown
{
    _countDown --;
    if (_countDown <= 0) {
        [_timeSch invalidate];
        return;
    }
    
    long temp;
    if (_countDown  < 60) {
        _secondLabel.text = [NSString stringWithFormat:@"%02ld",_countDown];
        _minLabel.text = @"00";
        _hourLabel.text = @"00";
    } else if ((temp = _countDown / 60) < 60){
        _secondLabel.text = [NSString stringWithFormat:@"%02ld",(_countDown - _countDown / 60 *60)];
        _minLabel.text = [NSString stringWithFormat:@"%02ld",_countDown / 60];
        _hourLabel.text = @"00";
    }
    else
        if ((temp = _countDown / 3600) < 24){
            _secondLabel.text = [NSString stringWithFormat:@"%02ld",(_countDown - _countDown/60 *60)];
            _minLabel.text = [NSString stringWithFormat:@"%02ld",(_countDown - _countDown / 3600 * 3600 )/ 60];
            _hourLabel.text = [NSString stringWithFormat:@"%02ld",_countDown / 3600];
        }
}





























@end
