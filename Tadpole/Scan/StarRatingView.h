//
//  StarRatingView.h
//  StarRating
//
//  Created by apple on 14-4-17.
//  Copyright (c) 2014年 SIXIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StarRatingView;

@protocol StarRatingViewDelegate <NSObject>

- (void)starRatingView:(StarRatingView *)view score:(float)score;

@end




@interface StarRatingView : UIView

@property (nonatomic, weak) id <StarRatingViewDelegate> delegate;

@property (nonatomic, strong) NSString *minImgName;
@property (nonatomic, strong) NSString *maxImgName;
@property (nonatomic, assign) CGFloat  gapValue;

@property (nonatomic, assign, readonly) CGFloat curRatingValue;
//@property (nonatomic,assign) BOOL isSmallImg ;
//@property (nonatomic, assign) CGFloat

- (id)initWithFrame:(CGRect)frame numberOfStar:(NSInteger)number touchEnable:(BOOL)touchEnable;

- (void)setCustomStarSize:(CGSize)size;

/* After assigned min,max image name */
- (void)makeRatingView;

- (void)setDefaultRatingValue:(float)score;


@end
