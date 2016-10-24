//
//  TPDefine.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/8.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//



#define kGetColor(a,b,c) [UIColor colorWithRed:(a)/255.f green:(b)/255.f blue:(c)/255.f alpha:1.0]
//方正黑体简体字体定义
#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]

#define IOSversion [[UIDevice currentDevice]systemVersion].floatValue

#define GetColor(a,b,c,d) [UIColor colorWithRed:(a)/255.f green:(b)/255.f blue:(c)/255.f alpha:(d)]

#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define imageNamed(name) ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]])


#define iFSettingValue  @"5670f757"

#define APPDELEGATE  ((AppDelegate *)[UIApplication sharedApplication].delegate)


#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
#define kCGImageAlphaPremultipliedLast  (kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast)
#else
#define kCGImageAlphaPremultipliedLast  kCGImageAlphaPremultipliedLast
#endif


#if __has_feature(objc_instancetype)

#undef  AS_SINGLETON
#define AS_SINGLETON( ... ) \
- (instancetype)sharedInstance; \
+ (instancetype)sharedInstance;
#undef  DEF_SINGLETON
#define DEF_SINGLETON( ... ) \
- (instancetype)sharedInstance \
{ \
return [[self class] sharedInstance]; \
} \
+(instancetype)sharedInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init];});\
return __singleton__;\
} \





// Data
#define kKindDefaults  @"KindDataDefaults"
#define kKindList      @"KindDataLists"
#define kHeadList      @"headlist"
#define kCountDown     @"HomeCountDown"

// 直播
// RTMP直播
#define RTMPNetworkServer   @"http://service.ingkee.com/api"
#define RTMPGetData    @"/live/gettop?"

#define SHOW_ERROR [SVProgressHUD showErrorWithStatus:@"出错了"];
#define SHOW_NTERROR [SVProgressHUD showErrorWithStatus:@"网络在开小差哦~\(≧▽≦)/~"];
#define SHOW_STATUS [SVProgressHUD showWithStatus:@"请稍等..." maskType:SVProgressHUDMaskTypeGradient];
#define SHOW_HIDDEN [SVProgressHUD dismiss];

#define WS __weak typeof(self) weakSelf = self;
#define SS __strong typeof(self) strongSelf = weakSelf;

#endif /* TPDefine_h */
