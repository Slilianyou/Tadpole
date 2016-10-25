//
//  MyInfoTableViewCell.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/1/11.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "MyInfoTableViewCell.h"

@implementation MyInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // UILabel
       self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.backgroundColor = [UIColor whiteColor];
        self.nameLabel.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
        self.nameLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.nameLabel];
        
        // UIImageView
        self.protraitImage = [[UIImageView alloc]init];
        self.protraitImage.hidden = YES;
        self.protraitImage.backgroundColor  = [UIColor greenColor];
        self.protraitImage.userInteractionEnabled = YES;
        self.protraitImage.image = [UIImage imageNamed:@"100.png"];
        [self.contentView addSubview:self.protraitImage];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.nameLabel.frame =CGRectMake(kScreenWidth - 150, 3, 150,40 );
    self.protraitImage.frame = CGRectMake((kScreenWidth - self.contentView.bounds.size.height  - 25) , 5, self.contentView.bounds.size.height - 10,  self.contentView.bounds.size.height - 10);
    self.protraitImage.layer.cornerRadius = self.protraitImage.bounds.size.height /2.0;
    self.protraitImage.layer.masksToBounds = YES;
}
- (void)awakeFromNib {
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
