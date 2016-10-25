//
//  UITextField+ExtentRange.h
//  EZhuiSu
//
//  Created by ss-iOS-LLY on 16/9/26.
//  Copyright © 2016年 Paiwogou@syscanit.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ExtentRange)
- (NSRange) selectedRange;
- (void) setSelectedRange:(NSRange) range;  
@end
