//
//  CityTableViewCell.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/5/18.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "CityTableViewCell.h"

#define kMarginWith 30


@implementation CityTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor lightGrayColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14.f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        
        self.line = [[UIImageView alloc]init];
        self.line.backgroundColor = [UIColor lightGrayColor];
        self.line.alpha = 0.3;
        [self addSubview: self.line ];
        
    }
    return self;
}

- (void)setContentWithData:(NSArray *)arr withSection:(NSInteger) section
{
    
    NSString *city;
    if (section == 0) {
        city = @"已定位城市";
        self.lineFirst = [[UIImageView alloc]init];
        self.lineFirst.frame = CGRectMake(0, 4, kScreenWidth, 1);
        self.lineFirst.backgroundColor = [UIColor lightGrayColor];
        self.lineFirst.alpha = 0.3;
        [self addSubview: self.lineFirst ];
        
    } else if (section == 1) {
        city = @"最近访问城市";
    } else if (section == 2) {
        city = @"热门城市";
    }
    
    
    CGSize size = [city sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]}];
    self.titleLabel.frame = CGRectMake(10, 5, size.width, 30);
    self.titleLabel.text = city;
    self.line.frame = CGRectMake(self.titleLabel.right + 8, 20, kScreenWidth - kMarginWith - self.titleLabel.right - 8 , 1.0);
    
    //
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    CGFloat w = (kScreenWidth - 40 - 30) / 3.0;
    for (int i = 0 ; i < arr.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10 + (w + 10)*(i %3)  ,self.titleLabel.bottom + 5 + (30 + 8) *(i / 3), w, 30)];
        NSDictionary *dic = [arr objectAtIndex:i];
        [btn setTitle:[dic objectForKey:@"city_name"]];
        [btn setTitleColor:[UIColor lightGrayColor]];
        btn.layer.cornerRadius = 5.f;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:btn];
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
