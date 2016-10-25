//
//  MIFooterTableViewCell.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/1/14.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "MIFooterTableViewCell.h"

@implementation MIFooterTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // custom...
        
        // UIImageView
        self.smallLogo = [[UIImageView alloc]init];
        self.smallLogo.userInteractionEnabled = YES;
        self.smallLogo.image = [UIImage imageNamed:@"placeholder.png"];
        [self.contentView addSubview: self.smallLogo];
        
        // 按钮
        self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.playBtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        self.playBtn.userInteractionEnabled = NO;
        self.playBtn.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.playBtn];
        
        // UILabel
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.font = [UIFont systemFontOfSize: 15.f];
        [self.contentView addSubview: self.titleLabel];
        
        // UILabel
        self.nickNameLabel = [[UILabel alloc]init];
        self.nickNameLabel.backgroundColor = [UIColor clearColor];
        self.nickNameLabel.textColor = [UIColor lightGrayColor];
        self.nickNameLabel.font = [UIFont systemFontOfSize:13.f];
        self.nickNameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview: self.nickNameLabel];
       }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.smallLogo.frame = CGRectMake(15, 8,64, 64);
    self.smallLogo.layer.cornerRadius = 32.f;
    self.smallLogo.layer.masksToBounds = YES;
    self.playBtn.frame = CGRectMake(0, 0, 16, 16);
    self.playBtn.center = self.smallLogo.center;
    self.playBtn.layer.cornerRadius = 8.f;
    self.playBtn.layer.masksToBounds = YES;

    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.smallLogo.frame)+ 5, 8, 200, 60);
    [self.titleLabel sizeToFit];
    self.nickNameLabel.frame = CGRectMake(CGRectGetMaxX(self.smallLogo.frame)+ 5, CGRectGetMaxY(self.titleLabel.frame), 200, 30);
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
