//
//  SignView.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/5/31.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RLBaseDateModel.h"
#import "NSDate+RLBaseCalendar.h"
#import "RLBaseDateTools.h"

@protocol SignViewDelegate <NSObject>

- (void)SignViewSelectAtDateModel:(RLBaseDateModel *)dataModel;
- (void)SignViewScrollEndToDate:(RLBaseDateModel *)dataModel;

@end


@interface SignView : UIView
@property (nonatomic, strong) NSDate *currentDate;
//标记数组 用于标记特殊日期 这个数组中存放的必须是YHBaseDateModel 对象
@property (nonatomic, strong) NSArray *markArray;
@property (nonatomic, assign) id<SignViewDelegate> delegate;
//本地数据数组

@property (nonatomic, strong) NSArray *plistArr ;
@property (nonatomic, strong) NSString *todayStr;
@property (nonatomic, strong) NSString *filePath;


- (void)reloadView;








@end
