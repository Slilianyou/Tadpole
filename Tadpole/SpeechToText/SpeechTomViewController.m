//
//  SpeechTomViewController.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/7.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "SpeechTomViewController.h"

@interface SpeechTomViewController ()

@end

@implementation SpeechTomViewController
#pragma  mark -- Method
- (void)addBtnItem
{
    self.title = @"首页";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Left" style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(presentRightMenuViewController:)];
    self.view.backgroundColor = [UIColor orangeColor];
    
}
- (void)presentLeftMenuViewController:(id)sender
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (void)presentRightMenuViewController:(id)sender
{
    [self.sideMenuViewController presentRightMenuViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBtnItem];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

















@end
