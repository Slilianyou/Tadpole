//
//  CountDownView.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/5/6.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownView : UIView
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *hourLabel;
@property (nonatomic, strong) UILabel *minLabel;
@property (nonatomic, strong) UILabel *secondLabel;
//@property (nonatomic, strong) UILabel *
//@property (nonatomic, strong) UILabel *

#pragma mark--
- (void)setDataWithNSDic:(NSDictionary *)dic;
@end
