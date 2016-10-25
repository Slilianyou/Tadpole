//
//  CityTableViewCell.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/5/18.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *line;
@property (nonatomic, strong) UIImageView *lineFirst;

#pragma mark --Method
- (void)setContentWithData:(NSArray *)arr withSection:(NSInteger) section;

@end
