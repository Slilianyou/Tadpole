//
//  UserImageCell.m
//  CrazyDiary
//
//  Created by ss-iOS-LLY on 16/9/12.
//  Copyright © 2016年 lilianyou. All rights reserved.
//

#import "UserImageCell.h"
#import "UIView+Frame.h"

@interface UserImageCell ()
{
    UIImageView *_indicatorView;
}
@end

@implementation UserImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:20.f];
         self.detailTextLabel.font = [UIFont systemFontOfSize:14.f];
          self.detailTextLabel.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        self.imageView.userInteractionEnabled = NO;
        [self.imageView addGestureRecognizer:tapGes];
        _indicatorView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"User_portrait_Indicator@2x.png"]];
        _indicatorView.backgroundColor = [UIColor clearColor];
        self.accessoryView = _indicatorView;
        }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect = self.imageView.frame;
    CGRect cusRect = CGRectMake(rect.origin.x, 10, self.height -20, self.height - 20);
    self.imageView.frame = cusRect;
    
    CGRect textLabelRect = self.textLabel.frame;
    textLabelRect.origin.x = CGRectGetMaxX(self.imageView.frame) + 20;
    textLabelRect.origin.y -= 5;
    self.textLabel.frame = textLabelRect;
    
    CGRect detailtextLabelRect = self.detailTextLabel.frame;
    detailtextLabelRect.origin.x = CGRectGetMaxX(self.imageView.frame) + 20;
    self.detailTextLabel.frame = detailtextLabelRect;
    
    _indicatorView.frame = CGRectMake(CGRectGetMaxX(self.detailTextLabel.frame) + 5, CGRectGetMinY(self.detailTextLabel.frame) + 1, 48, 13);

}
- (void)tapAction
{
    if ([self.delegate respondsToSelector:@selector(tapUserImageForChange)]) {
        [self.delegate tapUserImageForChange];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
