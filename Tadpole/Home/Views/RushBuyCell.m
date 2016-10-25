//
//  RushBuyCell.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/5/5.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "RushBuyCell.h"
#import "CountDownView.h"



@interface RushBuyCell ()
@property (nonatomic, strong) UILabel *selTopLabel;
@property (nonatomic, strong) CountDownView  *timeView;
@property (nonatomic, strong) UILabel *produceNameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *iconImgV;

@end

@implementation RushBuyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
        _selectedView = [[UIView alloc]init];
        [self addSubview:_selectedView];
        
        
        _selTopLabel = [[UILabel alloc]init];
        _selTopLabel.backgroundColor = [UIColor clearColor];
        _selTopLabel.textColor = [UIColor redColor];
        _selTopLabel.text = @"精选抢购";
        _selTopLabel.font = [UIFont boldSystemFontOfSize:18.f];
        _selTopLabel.textAlignment = NSTextAlignmentCenter;
        [_selectedView addSubview:_selTopLabel];
        
        //时间
        _timeView = [[CountDownView alloc]init];
        _timeView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:_timeView];
        
        
       _produceNameLabel= [[UILabel alloc]init];
        _produceNameLabel.backgroundColor = [UIColor whiteColor];
        _produceNameLabel.textColor = [UIColor blackColor];
        _produceNameLabel.font = FONT(13.f);
        _produceNameLabel.text = @"烤鸭";
        _produceNameLabel.textAlignment = NSTextAlignmentCenter;
        [_selectedView addSubview:_produceNameLabel];
        
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.backgroundColor = [UIColor whiteColor];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = [UIFont systemFontOfSize:14.f];
        _priceLabel.text = [NSString stringWithFormat:@"￥%@",@"49.0"];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        [_selectedView addSubview:_priceLabel];
        
        _iconImgV = [[UIImageView alloc]init];
        _iconImgV.image = [UIImage imageNamed:@"特价"];
        [_selectedView addSubview:_iconImgV];
        
        _payForBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payForBtn.backgroundColor = [UIColor redColor];
        [self addSubview:_payForBtn];
        
        
        _youHuiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _youHuiBtn.backgroundColor = [UIColor grayColor];
        [self addSubview:_youHuiBtn];
    }
    return self;
}

- (void)setContentWithDict:(NSDictionary *)dic
{
    CGFloat w = kScreenWidth / 3.0;
    _selectedView.frame = CGRectMake(0, 0, w, w );
    _selTopLabel.frame = CGRectMake(10, 5, w - 20 , 25);
    
    
    _timeView.frame = CGRectMake(6, _selTopLabel.bottom + 2, w - 12 , 26);
    [_timeView setDataWithNSDic:dic];
    
    _produceNameLabel.frame =  CGRectMake(10, _timeView.bottom + 2, w - 20 , 15);
    _priceLabel.frame =  CGRectMake(10, _produceNameLabel.bottom + 2, w - 50 , 20);
    _iconImgV.frame = CGRectMake(_priceLabel.right, _priceLabel.top + 3, 20, 14);
    
     _payForBtn.frame = CGRectMake(_selectedView.right, 0, w, w );
    [_payForBtn setBackgroundImage:[UIImage imageNamed:@"payFor"] forState:UIControlStateNormal];
    
     _youHuiBtn.frame = CGRectMake(_payForBtn.right, 0, w, w);
    [_youHuiBtn setBackgroundImage:[UIImage imageNamed:@"youHui"] forState:UIControlStateNormal];
    
 
}

@end
