//
//  SharpLabel.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/5/19.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//   创建到指向小尖角的Label


#import <UIKit/UIKit.h>

@interface SharpLabel : UIView
{
    CGPoint origin;  // 构建label的坐标点
    CGPoint point;  // 尖角指向的点
    CGSize size;  // 构建label的大小
    UIFont *font;
    UILabel *label;
    NSString *title;
    UIBezierPath *path;  // 用于绘制图的path
}
@property (nonatomic, strong) UILabel  *label;
- (void)set_path;
- (id)init:(CGPoint) p str:(NSString *)str;
- (void)set_point:(CGPoint)p ;
- (void)set_title:(NSString *)str;
- (void)reloadData;

























@end
