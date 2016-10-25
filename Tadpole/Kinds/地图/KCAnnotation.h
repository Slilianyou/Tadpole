//
//  KCAnnotation.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/3.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface KCAnnotation : NSObject<MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

#pragma mark 自定义一个图片属性在创建大头针视图时使用
@property (nonatomic, strong) UIImage *image;

#pragma mark 大头针左侧图标
@property (nonatomic, strong) UIImage *icon;
#pragma mark 大头针详情描述
@property (nonatomic, strong) NSString *detail;
#pragma mark 大头针右下方星级评价
@property (nonatomic, strong) UIImage  *rate;






















@end
