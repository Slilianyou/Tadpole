//
//  DataTableViewCell.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/27.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "DataTableViewCell.h"
#import "MovieRMTPCreator.h"
#import "UIImageView+WebCache.h"

@implementation DataTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.contentView.backgroundColor = [UIColor redColor];
        _icon_img = [[UIImageView alloc]init];
        [self.contentView addSubview:_icon_img];
        
        _name = [[UILabel alloc]init];
        [self.contentView addSubview:_name];
        
        _city = [[UILabel alloc]init];
        [self.contentView addSubview:_city];
        
        _Online_num = [[UILabel alloc]init];
        _Online_num.font = [UIFont systemFontOfSize:13.f];
        _Online_num.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_Online_num];
        
        _cover_img = [[UIImageView alloc]init];
        [self.contentView addSubview:_cover_img];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _icon_img.frame = CGRectMake(5, 10, 45, 45);
    _icon_img.layer.cornerRadius = 45 / 2.0;
    _icon_img.layer.masksToBounds = YES;
    _icon_img.clipsToBounds = YES;
    
    _name.frame =CGRectMake(_icon_img.right + 8, 10, self.contentView.bounds.size.width - 5 - 8 - _icon_img.right, 20);
    _city.frame = CGRectMake(_icon_img.right + 8, _name.bottom + 5, 120, 20);
    _Online_num.frame = CGRectMake(self.contentView.bounds.size.width - 5 -120, _name.bottom + 5, 120, 20);
    _cover_img.frame = CGRectMake(0, _icon_img.bottom + 10, self.contentView.bounds.size.width, 235);
    _cover_img.contentMode = UIViewContentModeScaleAspectFill;
    _cover_img.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _cover_img.clipsToBounds = YES;
}
- (void)setModelWithData:(MovieRMTPLives *)data
{

    [_icon_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",data.creator.portrait]]];
    [_cover_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",data.creator.portrait]] placeholderImage:[UIImage imageNamed:@"first-figure"]];
    _name.text = data.creator.nick;
    if ([data.city isEqualToString:@""]) {
        _city.text = @"难道在火星?";
    }else{
        _city.text = data.city;
    }
    
    
    _Online_num.text = [NSString stringWithFormat:@"%.f人正在观看",data.onlineUsers];

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
