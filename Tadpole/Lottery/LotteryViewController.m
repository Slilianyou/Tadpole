//
//  LotteryViewController.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/8.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "LotteryViewController.h"
#import "SlotViewController.h"


@implementation LotteryViewController
#pragma  mark -- Method
- (void)addBtnItem
{
    self.title = @"首页";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Left" style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(presentRightMenuViewController:)];
    self.view.backgroundColor = GetColor(233, 233, 233, 0.3);
}

- (void)presentLeftMenuViewController:(id)sender
{
//    [self.sideMenuViewController presentLeftMenuViewController];
}

- (void)presentRightMenuViewController:(id)sender
{
//    [self.sideMenuViewController presentRightMenuViewController];
    [self.navigationController pushViewController:[[SlotViewController alloc]init] animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBtnItem];
    [self addEmitter];
    
}

-(CALayer *)createLayer{
    return [[CUSSenderGoldLayer alloc]init];
}

-(NSString *)getBackgroundImageName{
    return @"EmitterCS.png";
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
        imageView.frame = CGRectMake(0, 0, image.size.width*rate, image.size.height*rate);
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
