//
//  MYPictureView.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/30.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MYPictureViewDelegate <NSObject>

- (void)tapAddToImageView:(UITapGestureRecognizer *)sender;

@end
@interface MYPictureView : UIView
@property (nonatomic, strong) UIImageView *myImageView;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *markLabel;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, assign)id<MYPictureViewDelegate>delegate;
@end
