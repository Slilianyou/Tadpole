//
//  ADViewController.m
//  PaiWoGou
//
//  Created by ss-iOS-LLY on 15/12/29.
//  Copyright © 2015年 Shanghai Easyka Technology Ltd. All rights reserved.
//

#import "ADViewController.h"
#import "SlotViewController.h"



@interface ADViewController (){
    NSInteger _secondsCountDown;
    NSTimer *_countDownTimer;
}

@end

@implementation ADViewController
-(CALayer *)createLayer{
    return [[CUSSenderGoldLayer alloc]init];
}

-(NSString *)getBackgroundImageName{
    if(kScreenHeight == 480) {
        return @"EmitterCS480.jpg";
    }
    return @"EmitterCS568.jpg";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.rootLayer = [self createLayer];
    [self.view.layer addSublayer:self.rootLayer];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.rootLayer) {
        [self.rootLayer removeFromSuperlayer];
    }
}

- (void)addEmitter
{
    if ([self getBackgroundImageName]) {
        
        UIImage *image = [UIImage imageNamed:[self getBackgroundImageName]];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        CGFloat rate = kScreenWidth / image.size.width;
        
        imageView.frame = CGRectMake(0, self.view.frame.size.height - image.size.height*rate, image.size.width*rate, image.size.height*rate);
        
        imageView.tag = 12345;
        [self.view addSubview:imageView];
    }
    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if ([self getBackgroundImageName]) {
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:12345];
        UIImage *image = imageView.image;
        
        CGFloat rate = kScreenWidth / image.size.width;
        imageView.frame = CGRectMake(0, 64, image.size.width*rate, image.size.height*rate);
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addEmitter];
    [self addBtn];
    [self getSecondMethod];
   

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addBtn
{
    self.secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.secondBtn.backgroundColor = [UIColor magentaColor];
    self.secondBtn.layer.cornerRadius = 25.f;
    self.secondBtn.layer.masksToBounds = YES;
    [self.secondBtn  addTarget:self action:@selector(ACTION) forControlEvents:UIControlEventTouchUpInside];
    self.secondBtn .backgroundColor = [UIColor whiteColor];
    self.secondBtn .frame = CGRectMake(kScreenWidth -60, 70, 50,  50);
    [self.view addSubview:self.secondBtn ];
}
- (void)ACTION
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)getSecondMethod
{
    _secondsCountDown = 1;
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

- (void)timeFireMethod
{
      _secondsCountDown--;
    [self.secondBtn setTitle:[NSString stringWithFormat:@"%ld秒",_secondsCountDown] forState:UIControlStateNormal];
    [self.secondBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    if (_secondsCountDown == 0) {
        [_countDownTimer invalidate];
        [self ACTION];
        self.secondBtn.userInteractionEnabled = YES;
    }
    
}
@end
