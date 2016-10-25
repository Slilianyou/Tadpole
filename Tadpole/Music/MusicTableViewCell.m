//
//  MusicTableViewCell.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/1/12.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "MusicTableViewCell.h"

@implementation MusicTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // custom...
        // UIImageView
        self.coverSmallImage = [[UIImageView alloc]init];
        self.coverSmallImage.image = [UIImage imageNamed:@"placeholder.png"];
        [self.contentView addSubview: self.coverSmallImage];
        
        // UILabel
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview: self.titleLabel];
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.coverSmallImage.frame = CGRectMake(10, 5, 80, 80);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.coverSmallImage.frame) + 8, self.contentView.frame.size.height/ 2 - 20, (kScreenWidth - CGRectGetMaxX(self.coverSmallImage.frame) - 5) , 40);
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
