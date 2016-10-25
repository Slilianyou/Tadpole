//
//  HomekindCell.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/4/29.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomekindCell : UITableViewCell
@property (nonatomic, strong) UIButton *kImageBtn;
//@property (nonatomic, strong) UIScrollView *myScroll;
//@property (nonatomic, strong) UIPageControl *pageControl;

#pragma mark --Method
- (void)setContentWithDic:(NSDictionary *)dict;
@end
