//
//  KCCalloutAnnotationView.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/3.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "KCCalloutAnnotation.h"
#import <Mapkit/MapKit.h>

@interface KCCalloutAnnotationView : MKAnnotationView
@property (nonatomic, strong) KCCalloutAnnotation *annotation;

#pragma mark 从缓存取出标注视图
+(instancetype)calloutViewWithMapView:(MKMapView *)mapView;

@end
