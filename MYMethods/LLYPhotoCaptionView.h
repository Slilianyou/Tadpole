//
//  LLYPhotoCaptionView.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/27.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLYPhotoCaptionView : UIView
{
    @private
    UILabel *_textLabel;
    BOOL _hidden;
}
- (void)setCaptionText:(NSString *)text hidden:(BOOL)val;
- (void)setCaptionHidden:(BOOL)hidden;

























@end
