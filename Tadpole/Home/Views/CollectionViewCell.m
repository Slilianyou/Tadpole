//
//  CollectionViewCell.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/4/29.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
   
    self.backgroundColor = [UIColor clearColor];
    self.imageView = [[UIImageView alloc]init];
    self.imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.imageView];
    
    self.textLabel = [[UILabel alloc]init];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = [UIFont systemFontOfSize:14.f];
    [self addSubview:self.textLabel];
        
    }
    return self;
  
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.layer.cornerRadius = (self.width - 16) / 2.0;
    self.imageView.layer.masksToBounds = YES;
    
    self.imageView.frame =CGRectMake(8, 5, self.width - 16, self.width - 16);
    
    self.textLabel.frame =CGRectMake(5, self.imageView.bottom + 10, self.width -10, 20);
}
























@end
