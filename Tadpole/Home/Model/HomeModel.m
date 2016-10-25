//
//  HomeModel.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/4/28.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "HomeModel.h"

#define imagesCount 

@implementation HomeModel
DEF_SINGLETON(HomeModel)

- (NSMutableArray *)getImageArrForScr
{
    _imageArr = [NSMutableArray arrayWithCapacity:5];
    for (int i = 1; i < 6 ; i++) {
    
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"img%d",i]];
        
        [_imageArr addObject:image];
    }
    
    [_imageArr insertObject:[_imageArr lastObject] atIndex:0];
    [_imageArr addObject:[_imageArr objectAtIndex:1]];
    
    return _imageArr;
}

- (NSMutableDictionary *)getDataForKind
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    //[dict setObject:@"homeKind01" forKey:kKindDefaults];
    [dict setObject:@"" forKey:kKindDefaults];
    
    //
    NSMutableArray *kindLists = [NSMutableArray arrayWithCapacity:0];
    NSArray * icons = [NSArray arrayWithObjects:
                     @"丽人",@"自助餐",@"上门服务",@"购物商场",@"品牌购物",
                       @"生活服务",@"演出赛事",@"代金劵",@"二手车",@"更多分类",
                       @"Tom猫",@"签到",@"视频直播",@"地图",@"视频采集",
                       @"手机充值",@"KTV",@"旅游", @"直播播放",@"储值卡",
                       @"丽人",@"自助餐",@"上门服务",@"购物商场",@"品牌购物",
                       @"生活服务",@"演出赛事",@"代金劵",@"二手车",@"更多分类",
                       @"Tom猫",@"签到",@"视频直播",@"地图",@"视频采集",
                       @"手机充值",@"KTV",@"旅游", @"直播播放",@"储值卡",
                       nil];
    for (int i = 0 ; i < 40; i++) {
         NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:icons[i],@"icon",icons[i],@"title",nil];
        [kindLists addObject:dic];
    }
    
    [dict setObject:kindLists forKey:kKindList];
    
    //头条
    NSMutableArray *headlist = [NSMutableArray arrayWithObjects:@"［游遍世界］海外景点门票超低价",@"［美车宝典］入夏换新5折起",@"［游遍世界］海外景点门票超低价",@"［美车宝典］入夏换新5折起", nil];
    
    [dict setObject:headlist forKey:kHeadList];
    
    [dict setObject:@"20160511161500" forKey:kCountDown];
    
       return dict;
}


//城市列表
- (NSDictionary *)getCityData
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"City" ofType:@"json"];
    
    NSString *jsonStr = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dic);
    
    return dic;
}
























@end
