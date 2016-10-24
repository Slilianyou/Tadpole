//
//  AppDelegate.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/3.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LeftMenuViewController.h"
#import "MicroViewController.h"
#import "LotteryViewController.h"
#import <iflyMSC/iflyMSC.h>
#import "ADViewController.h"

#import "MusicInfoViewController.h"

// 版本更新
#import "AYCheckManager.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

- (id)getCurNavController
{
    UINavigationController *navController = (UINavigationController *)self.tbc.selectedViewController;
    return navController;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // 科大讯飞语音
    [self addIFSetting];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self addTabbar];
    self.window.rootViewController = self.tbc;
    [self.window makeKeyAndVisible];
    AYCheckManager *manager = [AYCheckManager sharedCheckManager];
    manager.countryAbbreviation = @"cn";
    manager.openAPPStoreInSideAPP = YES;
    [manager checkVersionWithAlertTitle:@"发现新版本" nextTimeTitle:@"下次提示" confimTitle:@"前往更新" skipVersionTitle:@"跳过当前版本"];

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    ADViewController *adVC = [[ADViewController alloc]init];
//    RESideMenu * vierC = [self.tbc.viewControllers objectAtIndex:0];
//    [vierC.contentViewController presentViewController:adVC animated:YES completion:nil];
     return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - UITabbar
- (void)addTabbar
{
    // 首页
    UINavigationController *mainNavi = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
//    LeftMenuViewController *leftMenuViewController = [[LeftMenuViewController alloc] init];
//  
//    
//    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
//                                                                    leftMenuViewController:leftMenuViewController
//                                                                   rightMenuViewController:nil];
//    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
//    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
//    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
//    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
//    sideMenuViewController.contentViewShadowOpacity = 0.6;
//    sideMenuViewController.contentViewShadowRadius = 12;
//    sideMenuViewController.contentViewShadowEnabled = YES;
    //    self.window.rootViewController = sideMenuViewController;
    
    UITabBarItem *homeBarItem = [[UITabBarItem alloc]initWithTitle:@"主页" image:[[UIImage imageNamed:@"Home_moren"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [homeBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:GetColor(149, 149, 149, 1)} forState:UIControlStateNormal];
    [homeBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateSelected];
    mainNavi.tabBarItem = homeBarItem;
    
    
    // Microphone
    UINavigationController *microNav = [[UINavigationController alloc]initWithRootViewController:[[MicroViewController alloc]init]];
    UITabBarItem *microBarItem = [[UITabBarItem alloc]initWithTitle:@"语音" image:[[UIImage imageNamed:@"Microphone_moren"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Microphone"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [microBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:GetColor(149, 149, 149, 1)} forState:UIControlStateNormal];
    [microBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateSelected];
    microNav.tabBarItem = microBarItem;
    
    // luck
    UINavigationController *luckNav = [[UINavigationController alloc]initWithRootViewController:[[LotteryViewController alloc]init]];
    UITabBarItem *luckBarItem = [[UITabBarItem alloc]initWithTitle:@"幸运" image:[[UIImage imageNamed:@"Luck_moren"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Luck"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [luckBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:GetColor(149, 149, 149, 1)} forState:UIControlStateNormal];
    [luckBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateSelected];
    luckNav.tabBarItem = luckBarItem;
    
    // luck
    UINavigationController *musciNai = [[UINavigationController alloc]initWithRootViewController:[[MusicInfoViewController alloc]init]];
    UITabBarItem *musciItem = [[UITabBarItem alloc]initWithTitle:@"歌曲" image:[[UIImage imageNamed:@"Luck_moren"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"Luck"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [musciItem setTitleTextAttributes:@{NSForegroundColorAttributeName:GetColor(149, 149, 149, 1)} forState:UIControlStateNormal];
    [musciItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateSelected];
    musciNai.tabBarItem = musciItem;
    
   
    NSArray *array = [NSArray arrayWithObjects:mainNavi,microNav,luckNav,musciNai, nil];
    self.tbc = [[UITabBarController alloc]init];
    self.tbc.tabBar.backgroundColor = [UIColor whiteColor];
    self.tbc.viewControllers = array;
}

#pragma mark - IFlySetting
- (void)addIFSetting
{
  //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc]initWithFormat:@"appid=%@",iFSettingValue];
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
}

@end
