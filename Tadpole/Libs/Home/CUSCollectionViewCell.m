//
//  CUSCollectionViewCell.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/29.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "CUSCollectionViewCell.h"

@implementation CUSCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // UIImageView;
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 50, 50)];
        self.imageView.layer.cornerRadius = 25.f;
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.borderColor = [GetColor(218, 178, 115, 1) CGColor];
        self.imageView.layer.borderWidth = 1.f;
        [self addSubview:self.imageView];
        
        // UILabel;
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 60, 50, 20)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10.f];
        self.titleLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:self.titleLabel];
        
    }
    return self;
}
@end
