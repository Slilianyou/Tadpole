//
//  HistoryTableViewCell.m
//  EZhuiSu
//
//  Created by ss-iOS-LLY on 16/9/22.
//  Copyright © 2016年 Paiwogou@syscanit.com. All rights reserved.
//

#import "HistoryTableViewCell.h"


#define kMargin  10
#define kLabelHeight (25/ 667.f *kScreenHeight)
@interface HistoryTableViewCell ()
{
    UIImageView *_imagV;
    UILabel * _numTraceTitleLabel;
    UILabel * _nameLabel;
    UILabel * _numTrace;
    UILabel * _infoLabel;
    UILabel * _numSeacher;
    UILabel * _timeLabel;
    
}
@end
@implementation HistoryTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        self.backgroundColor = [UIColor clearColor];
        
        _imagV = [[UIImageView alloc]init];
        _imagV.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_imagV];
        
        _nameLabel = [self setUpLabelWithAttribute];
        
        _numTraceTitleLabel = [self setUpLabelWithAttribute];
        _numTraceTitleLabel.text = @"追溯编号：";
        
        _numTrace = [self setUpLabelWithAttribute];
        _numTrace.adjustsFontSizeToFitWidth = YES;
        _numTrace.minimumScaleFactor = 10.f /14.f;
        
        _infoLabel = [self setUpLabelWithAttribute];
        
        _numSeacher = [self setUpLabelWithAttribute];
        
        _timeLabel = [self setUpLabelWithAttribute];
        
    }
    return self;
}

- (UILabel *)setUpLabelWithAttribute
{
    UILabel * label = [[UILabel alloc]init];
    label.numberOfLines = 1;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor darkTextColor];
    label.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:label];
    return label;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    _imagV.frame = CGRectMake(kMargin, kMargin, CGRectGetHeight(self.frame) - 2 *kMargin, CGRectGetHeight(self.frame) - 2 *kMargin);
    
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_imagV.frame) + 5, kMargin + 2, CGRectGetWidth(self.contentView.frame) - CGRectGetMaxX(_imagV.frame) - kMargin, kLabelHeight);
     _numTraceTitleLabel.frame = CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_nameLabel.frame) + 2, 70 , kLabelHeight);
    _numTrace.frame = CGRectMake(CGRectGetMaxX(_numTraceTitleLabel.frame), CGRectGetMaxY(_nameLabel.frame) + 2, CGRectGetWidth(self.contentView.frame) - CGRectGetMaxX(_numTraceTitleLabel.frame) - kMargin , kLabelHeight);
    _infoLabel.frame = CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_numTrace.frame) + 2, CGRectGetWidth(_nameLabel.frame), kLabelHeight);
    _numSeacher.frame = CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_infoLabel.frame) + 2, CGRectGetWidth(_nameLabel.frame), kLabelHeight);
    _timeLabel.frame = CGRectMake(CGRectGetMinX(_nameLabel.frame), CGRectGetMaxY(_numSeacher.frame) + 2, CGRectGetWidth(_nameLabel.frame), kLabelHeight);
    
}


- (void)setDataForCellWIthDictionary:(NSDictionary *)dic
{
    [_imagV sd_setImageWithURL:[NSURL URLWithString:@"11"] placeholderImage:[UIImage imageNamed:@"HuangGua.png"]];
    _nameLabel.text =[NSString stringWithFormat:@"商品名称：%@",@"土豆不是马铃薯"];
    _numTrace.text  = [NSString stringWithFormat:@"%@",@"012345678901234567"];
    _infoLabel.text = [NSString stringWithFormat:@"商家信息：%@",@"京客隆春秀路店"];
    _numSeacher.text = [NSString stringWithFormat:@"查询人数：%@",@"89990"];
    _timeLabel.text = [NSString stringWithFormat:@"更新日期：%@",@"2016-08-01"];
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
