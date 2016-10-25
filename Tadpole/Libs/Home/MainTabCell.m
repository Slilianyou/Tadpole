//
//  MainTabCell.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/31.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "MainTabCell.h"
#import "MYPictureView.h"

@implementation MainTabCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
        MYPictureView * leftPicView = [[MYPictureView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width / 2.0, self.frame.size.height)];
        [self.contentView addSubview:leftPicView];
        
        //
        MYPictureView * rightPicView = [[MYPictureView alloc]initWithFrame:CGRectMake(self.frame.size.width / 2.0, 0, self.frame.size.width / 2.0, self.frame.size.height)];
        [self.contentView addSubview:rightPicView];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
