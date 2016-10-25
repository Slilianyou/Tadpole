//
//  CUShowView.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/17.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CUShowView : UIView
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIActivityIndicatorView  *aiv;
@property (nonatomic, strong) UIView *ParentView;
@property (nonatomic, assign) int queueCount;
@property (nonatomic, strong) UIImageView *imageViewGif;
@property (nonatomic, strong) NSMutableArray *arr;

-(instancetype)initWithFrame:(CGRect)frame;

- (void)setText:(NSString *) text;

- (void)show;

- (void)hide;























@end
