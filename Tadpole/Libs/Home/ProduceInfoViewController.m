//
//  ProduceInfoViewController.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/1/8.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "ProduceInfoViewController.h"
#import "ShopViewController.h"

@interface ProduceInfoViewController ()

@end

@implementation ProduceInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  
    // 按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 89;
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(0 , 0, 100,  40);
    btn.center = CGPointMake(kScreenWidth / 2.0, 140);
    [self.view addSubview:btn];
   
}
-(void)buttonClicked:(UIButton *)sender
{
      ShopViewController *shopVC = [[ShopViewController alloc]init];
    shopVC.transitioningDelegate = self;
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0) {
        shopVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }else {
        shopVC.modalPresentationStyle  =UIModalTransitionStyleCrossDissolve;
        self.tabBarController.modalPresentationStyle = UIModalPresentationCurrentContext;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tabBarController presentViewController:shopVC animated:YES completion:nil];
        self.tabBarController.modalPresentationStyle = UIModalPresentationNone;
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



























@end
