//
//  MYPictureView.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/30.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "MYPictureView.h"

@implementation MYPictureView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //
        self.tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAddToImageView:)];
        [self addGestureRecognizer:self.tapGesture];
        //
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
        self.myImageView.userInteractionEnabled = YES;
        self.myImageView.image = [UIImage imageNamed:@"hou.png"];
        [self addSubview:self.myImageView];
        
        //
        self.infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myImageView.frame), self.frame.size.width, 60)];
        self.infoLabel.text = @"啊回复哈感觉哈结核杆菌喀什更健康哈骨灰盒个 i";
        [self addSubview:self.infoLabel];
        
        //
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.infoLabel.frame), 100, 60)];
        self.moneyLabel.textAlignment = NSTextAlignmentLeft;
        self.moneyLabel.text = @"💰 50.00";
        [self addSubview:self.moneyLabel];
        
        //
        self.markLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.infoLabel.frame), 100, 60)];
        self.markLabel.textAlignment = NSTextAlignmentRight;
        self.markLabel.text = @"Hot";
        [self addSubview:self.markLabel];
    }
    return self;
}
- (void)tapAddToImageView:(UITapGestureRecognizer *)sender
{
    [self.delegate tapAddToImageView:sender];
}

@end
