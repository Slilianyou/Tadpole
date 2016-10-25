//
//  RushBuyCell.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/5/5.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RushBuyCell : UITableViewCell
@property (nonatomic, strong) UIButton *youHuiBtn;
@property (nonatomic, strong) UIButton *payForBtn;
@property (nonatomic, strong) UIView * selectedView;

#pragma mark --method
- (void)setContentWithDict:(NSDictionary *)dic;
@end
