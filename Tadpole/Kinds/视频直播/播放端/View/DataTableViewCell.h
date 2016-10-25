//
//  DataTableViewCell.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/27.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieRMTPLives.h"


@interface DataTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *icon_img;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *city;
@property (strong, nonatomic) UILabel *Online_num;
@property (strong, nonatomic) UIImageView *cover_img;

#pragma -mark ---
- (void)setModelWithData:(MovieRMTPLives *)data;

@end
