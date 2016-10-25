//
//  KCCalloutAnnotation.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/3.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

@interface KCCalloutAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *subtitle;

#pragma mark 大头针左侧图标
@property (nonatomic, strong) UIImage *icon;
#pragma mark 大头针详情描述
@property (nonatomic, strong) NSString *detail;
#pragma mark 大头针右下方星级评价
@property (nonatomic, strong) UIImage  *rate;
@end
