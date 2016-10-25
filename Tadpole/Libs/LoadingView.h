//
//  LoadingView.h
//  EZhuiSu
//
//  Created by ss-iOS-LLY on 16/10/17.
//  Copyright © 2016年 Paiwogou@syscanit.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LoadingView : UIView
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor;
@end


#pragma mark - spot

@interface Spot : UIView
@property (nonatomic, copy) NSString *effectToken;
@property (nonatomic, assign) BOOL allowChangeEffectToken;
@property (nonatomic, assign) BOOL isFirstTimeToBlend;
@property (nonatomic, assign) BOOL isFirstTimeToSpringBack;

-(instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color;
 @end





































