//
//  LLYMapViewController.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/3.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "LLYMapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "KCAnnotation.h"
#import "KCCalloutAnnotation.h"
#import "KCCalloutAnnotationView.h"


@interface LLYMapViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
{
    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
    MKMapView *_mapView;
}

@end

@implementation LLYMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initGUI];
    // 编码
    _geocoder = [[CLGeocoder alloc]init];
    //[self getCoordinateByAddress:@"上海"];
    [self getAddressByLatitude:39.54 longitude:116.28];
    
// 苹果手机自带地图功能
// [self location];
// [self setPresenBackBtn];

}
#pragma mark 添加地图控件
- (void)initGUI
{
    _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_mapView];
    
    //设置代理
    _mapView.delegate = self;
    
    // 定位
    [self setupCLLocationManager];
    
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    //设置地图类型
    _mapView.mapType = MKMapTypeStandard;
    
   //添加大头针
    [self addAnnotation];
}
#pragma mark 添加大头针
- (void)addAnnotation
{
    CLLocationCoordinate2D location1 = CLLocationCoordinate2DMake(31.224635, 121.631051);
    KCAnnotation *annotation1 = [[KCAnnotation alloc]init];
    annotation1.title = @"大头针标题";
    annotation1.subtitle = @"打头针副标题";
    annotation1.coordinate = location1;
    annotation1.image = [UIImage imageNamed:@"icon_pin_floating"];
    annotation1.icon = [UIImage imageNamed:@"icon_mark1"];
    annotation1.detail = @"自定义大头针视图first";
    annotation1.rate = [UIImage imageNamed:@"icon_Movie_Star_rating"];
    [_mapView addAnnotation:annotation1];
    
    
    CLLocationCoordinate2D location2 = CLLocationCoordinate2DMake(31.204630, 121.620090 );
    KCAnnotation *annotation2 = [[KCAnnotation alloc]init];
    annotation2.title = @"2大头针标题";
    annotation2.subtitle = @"2打头针副标题";
    annotation2.coordinate = location2;
    annotation2.image = [UIImage imageNamed:@"icon_paopao_waterdrop_streetscape"];
    annotation2.icon = [UIImage imageNamed:@"icon_mark2"];
    annotation2.detail =@ "自定义大头针视图second";
    annotation2.rate = [UIImage imageNamed:@"icon_Movie_Star_rating"];
    [_mapView addAnnotation:annotation2];
    
}

#pragma mark - 地图控件代理方法
#pragma mark 显示大头针时调用，注意方法中的annotation参数是即将显示的大头针对象
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
     //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
    if ([annotation isKindOfClass:[KCAnnotation class]]) {
        static NSString *key1 = @"Annotationkey1";
        MKAnnotationView *annotationView = [_mapView dequeueReusableAnnotationViewWithIdentifier:key1];
        //如果缓存池中不存在则新建
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:key1];
            //annotationView.canShowCallout = YES;//允许交互点击
            annotationView.calloutOffset =CGPointMake(0, 1);
            //定义详情视图偏移量
            annotationView.leftCalloutAccessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_classify_cafe"]];//定义详情左侧视图
        }
        //修改大头针视图
        //重新设置此类大头针视图的大头针模型(因为有可能是从缓存池中取出来的，位置是放到缓存池时的位置)
        annotationView.annotation =annotation;
        annotationView.image = ((KCAnnotation *)annotation).image;//设置大头针视图的图片
        return annotationView;
    } else if ([annotation isKindOfClass:[KCCalloutAnnotation class]]){
  //对于作为弹出详情视图的自定义大头针视图无弹出交互功能（canShowCallout=false，这是默认值），在其中可以自由添加其他视图（因为它本身继承于UIView）
        KCCalloutAnnotationView *calloutView = [KCCalloutAnnotationView calloutViewWithMapView:mapView];
        calloutView.annotation = annotation;
        return calloutView;
    } else {
        return nil;
    }
}
#pragma mark 选中大头针时触发
//点击一般的大头针KCAnnotation时添加一个大头针作为所点大头针的弹出详情视图
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    KCAnnotation *annotation = view.annotation;
    if ([view.annotation isKindOfClass:[KCAnnotation class]]) {
        //点击一个大头针时移除其他弹出详情视图
        [self removeCustomAnnotation];
        //添加详情大头针，渲染此大头针视图时将此模型对象赋值给自定义大头针视图完成自动布局
        KCCalloutAnnotation *annotation1 = [[KCCalloutAnnotation alloc]init];
        annotation1.icon = annotation.icon;
        annotation1.detail = annotation.detail;
        annotation1.rate = annotation.rate;
        annotation1.coordinate = annotation.coordinate;
        [mapView addAnnotation:annotation1];
        
   
        
    }
}
#pragma mark 取消选中时触发
-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    [self removeCustomAnnotation];
}
- (void)removeCustomAnnotation
{
    [_mapView.annotations enumerateObjectsUsingBlock:^(id<MKAnnotation>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[KCCalloutAnnotation class]]) {
            [_mapView removeAnnotation:obj];
        }
    }];
}
#pragma mark --定位管理器
- (void)setupCLLocationManager
{
    //定位管理器
    _locationManager = [[CLLocationManager alloc]init];
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    
   // 如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestWhenInUseAuthorization];
    } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        //设置代理
        _locationManager.delegate = self;
        //设置定位精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //定位频率，每隔多少米定位一次
        CLLocationDistance distance = 1.0;
        _locationManager.distanceFilter = distance;
        //启动定位跟踪
        [_locationManager startUpdatingLocation];
        
    }
    
}
#pragma mark - 地图控件代理方法
#pragma mark 更新用户位置，只要用户改变则调用此方法（包括第一次定位到用户位置）
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
   // 设置地图显示范围(如果不进行区域设置会自动显示区域范围并指定当前用户位置为地图中心点)
        MKCoordinateSpan span=MKCoordinateSpanMake(0.005, 0.005);
        MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.location.coordinate, span);
        [_mapView setRegion:region animated:true];
    
}
#pragma mark --CoreLocation  代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations firstObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"经度：%f ,纬度：%f,海拔：%f航向：%f行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    
   
    // 如果不需要实时定位，使用完毕即可关闭定位服务
   // [_locationManager stopUpdatingLocation];
}

#pragma mark ----编码
#pragma mark 根据地名确定地理坐标
- (void)getCoordinateByAddress:(NSString *)address
{
    //地理编码
    [_geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        // 取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
        //CLPlacemark *placeMark = [placemarks firstObject];
        
//        CLLocation *location = placeMark.location;//位置
//        CLRegion *region = placeMark.region;//区域
//        NSDictionary *addressDic = placeMark.addressDictionary;//详细地址信息字典,包含以下部分信息
//        NSString *name = placeMark.name;  //地名
//        NSString *thoroughfare = placeMark.thoroughfare; //街道
//        NSString *subThoroughfare = placeMark.subThoroughfare;//街道相关信息，例如门牌等
//        NSString *locality = placeMark.locality;// 城市
//        NSString *sunlocality = placeMark.subLocality;// 城市相关信息，例如标志性建筑
//        NSString *administrativeArea = placeMark.administrativeArea; // 州
//        NSString *subAdministrativeArea = placeMark.subAdministrativeArea;//其他行政区域信息
//        NSString *postalCode = placeMark.postalCode; //邮编
//        NSString *ISOcountruCode = placeMark.ISOcountryCode;//国家编码
//        NSString *country = placeMark.country; //国家
//        NSString *inlandWater = placeMark.inlandWater;//水源、湖泊
//        NSString *ocean = placeMark.ocean;// 海洋
//        NSArray *areasOfInterest = placeMark.areasOfInterest;//关联的或利益相关的地标
     
    }];
}

#pragma mark 根据坐标取得地名
- (void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude
{
    //反地理编码
    CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = [placemarks firstObject];
        NSLog(@"6666666666666666666详细信息：%@",placemark.addressDictionary);
    }];
}

#pragma mark --苹果自带的地图应用
- (void)location
{
    // 根据“上海”进行地理编码
    [_geocoder geocodeAddressString:@"上海市" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *clPlacemark1 = [placemarks firstObject];//获取第一个地标
        MKPlacemark *mkplacemark1 = [[MKPlacemark alloc]initWithPlacemark:clPlacemark1];//定位地标转化为地图的地标
         //注意地理编码一次只能定位到一个位置，不能同时定位，所在放到第一个位置定位完成回调函数中再次定位
        [_geocoder geocodeAddressString:@"营口" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *clPlacemark2 = [placemarks firstObject];
            MKPlacemark *mkPlacemark2 = [[MKPlacemark alloc]initWithPlacemark:clPlacemark2];
            
          //  NSDictionary *options = @{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard)};
            NSDictionary *options = @{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard),MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving};
            MKMapItem *mapItem1 = [[MKMapItem alloc]initWithPlacemark:mkplacemark1];
            MKMapItem *mapItem2 = [[MKMapItem alloc]initWithPlacemark:mkPlacemark2];
            [MKMapItem openMapsWithItems:@[mapItem1,mapItem2] launchOptions:options];
        }];
       
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backBtnClicked:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
