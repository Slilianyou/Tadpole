//
//  OutLoginTableViewCell.m
//  EZhuiSu
//
//  Created by ss-iOS-LLY on 16/9/21.
//  Copyright © 2016年 Paiwogou@syscanit.com. All rights reserved.
//

#import "OutLoginTableViewCell.h"

@interface OutLoginTableViewCell ()
{
    UILabel *_titleLabel;
    UIView * _backView;
}
@end

@implementation OutLoginTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setBackgroundColor: [UIColor clearColor]];
        
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
        [self setBackgroundView:_backView];
        
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 1;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.text = @"退出登录";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:20.f];
        [_backView addSubview:_titleLabel];
                
    }
    return self;
}
- (void)addSubview:(UIView *)view
{
    NSString *className = NSStringFromClass([view class]);
    
    if (![className isEqualToString:@"UILabel"]) {
        return;
    }
    [super addSubview:view];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _backView.frame = CGRectMake(20, 0, CGRectGetWidth(self.contentView.frame) - 20 *2, CGRectGetHeight(self.contentView.frame));
    _backView.layer.cornerRadius = 12.f;
    _titleLabel.frame = CGRectMake(5, 0, CGRectGetWidth(_backView.frame) - 10, CGRectGetHeight(self.contentView.frame));
    
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
