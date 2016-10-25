//
//  MIHeaderTableViewCell.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/1/14.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "MIHeaderTableViewCell.h"

@implementation MIHeaderTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // custom...
        // cusBackView
        self.backView = [[UIView alloc]init];
        self.backView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:self.backView];
        
        // UIImageView
        self.leftImageView = [[UIImageView alloc]init];
        self.leftImageView.image = [UIImage imageNamed:@"placeholder.png"];
        [self.backView addSubview: self.leftImageView];
        
        // 按钮
        self.smallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.smallBtn.backgroundColor = [UIColor redColor];
        [self.backView addSubview:self.smallBtn];
        
        // UILabel
        self.smallLabel = [[UILabel alloc]init];
        self.smallLabel.backgroundColor = [UIColor clearColor];
        self.smallLabel.textColor = [UIColor whiteColor];
        self.smallLabel.textAlignment = NSTextAlignmentLeft;
        [self.backView addSubview: self.smallLabel];
  
        // UILabel
        self.introLabel = [[UILabel alloc]init];
        self.introLabel.backgroundColor = [UIColor clearColor];
        self.introLabel.textColor = [UIColor lightGrayColor];
        self.introLabel.font = [UIFont systemFontOfSize:13.f];
        self.introLabel.textAlignment = NSTextAlignmentLeft;
        [self.backView addSubview: self.introLabel];
        
        // 按钮
        self.tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.tagBtn.tag = 100;
        [self.tagBtn setTitle:@"电影｜原曲" forState:UIControlStateNormal];
        self.tagBtn.backgroundColor = [UIColor clearColor];
        [self.tagBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.tagBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [self.backView addSubview:self.tagBtn];
        
        
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.backView.frame =self.bounds;
    self.leftImageView.frame = CGRectMake(15, 20, 100, 120);
    self.smallBtn.frame = CGRectMake(CGRectGetMaxX(self.leftImageView.frame)+   10, 20, 30, 30);
    self.smallBtn.layer.cornerRadius = 15.f;
    self.smallBtn.layer.masksToBounds = YES;
    self.smallLabel.frame = CGRectMake(CGRectGetMaxX(self.smallBtn.frame)+ 8, 20, 200, 30);
    self.introLabel.frame = CGRectMake(CGRectGetMaxX(self.leftImageView.frame)+ 8, CGRectGetMaxY(self.smallBtn.frame) + 5, 200, 25);

    self.tagBtn.frame = CGRectMake(CGRectGetMaxX(self.leftImageView.frame)+ 8, CGRectGetMaxY(self.introLabel.frame) + 10, 80, 25);
    self.tagBtn.layer.cornerRadius = 5.f;
    self.tagBtn.layer.masksToBounds = YES;
    self.tagBtn.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.tagBtn.layer.borderWidth = 1.f;

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
