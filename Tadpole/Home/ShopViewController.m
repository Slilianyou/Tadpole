//
//  ShopViewController.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/1/8.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "ShopViewController.h"

@interface ShopViewController ()
{
    UIImageView *_imageView;
}

@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];

    // 按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = self.view.bounds;
   [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btn];
    
    // UIImageView
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 300, kScreenWidth - 60, kScreenHeight - 94 - 30)];
    _imageView.image = [UIImage imageNamed:@"100.png"];
    [btn addSubview:_imageView];
}
- (void)back
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
