//
//  MyTextField.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/4/29.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "MyTextField.h"

@implementation MyTextField
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        // custom...
    }
    return self;
}

// 控制左视图位置
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
   CGRect inset = CGRectMake(5, (bounds.size.height - 15)/ 2, 15, 15);
    return inset;
}



























@end
