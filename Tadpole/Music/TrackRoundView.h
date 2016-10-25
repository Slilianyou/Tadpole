//
//  TrackRoundView.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/1/23.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TrackRoundViewDelegate <NSObject>

- (void)playStatuUpdate:(BOOL)playState;

@end
@interface TrackRoundView : UIView

@property (nonatomic, assign)id<TrackRoundViewDelegate>delegate;

@property (nonatomic, strong) UIImage *roundImage;
@property (nonatomic, assign) BOOL isPlay;
@property (nonatomic, assign) float rotationDuration;


- (void)play;
- (void)pause;

@end
