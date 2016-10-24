//
//  CUSViewController.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/10.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "CUSViewController.h"

@interface CUSViewController ()

@end

@implementation CUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // 编译环境判断，判断当前开发时使用的sdk的版本 ,
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
      // 所使用的sdk为7.0以上的版本，在此的代码在编译时不会保存，但是允许在低版本ios系统的设备上运行就会崩溃的
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
//            // 从导航栏下边算起
//            self.edgesForExtendedLayout = UIRectEdgeNone;
//        }
        self.extendedLayoutIncludesOpaqueBars = NO;
        
        /* 其中 extendedLayoutIncludesOpaqueBars 属性指定了当Bar使用了不透明图片时，视图是否延伸至Bar所在区域，默认值时NO。
         
        而edgesForExtendedLayout则是表示视图是否覆盖到四周的区域，默认是UIRectEdgeAll，即上下左右四个方向都会覆盖 */
        self.modalPresentationCapturesStatusBarAppearance = NO;
       // self.tabBarController.tabBar.barTintColor = [UIColor redColor];
        self.navigationController.navigationBar.translucent = NO;
//        self.tabBarController.tabBar.translucent = NO;
//        self.tabBarController.tabBar.backgroundColor = [UIColor redColor];
    }
#endif
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
