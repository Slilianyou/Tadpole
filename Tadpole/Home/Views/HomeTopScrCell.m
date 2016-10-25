//
//  HomeTopScrCell.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/4/29.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "HomeTopScrCell.h"


#define pageConWith  80
#define pageHeight   30

@implementation HomeTopScrCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.myScroll = [[UIScrollView alloc]init];
        self.myScroll.backgroundColor = kGetColor(32, 178, 170);
        self.myScroll.showsHorizontalScrollIndicator = NO;
        self.myScroll.showsVerticalScrollIndicator = NO;
        [self.myScroll setContentOffset:CGPointMake(kScreenWidth, 0) animated:NO];
        self.myScroll.bounces = NO;
        self.myScroll.pagingEnabled = YES;
        [self addSubview:self.myScroll];
        
        // UIPageControll
        self.pageControl = [[UIPageControl alloc]init];
        self.pageControl.backgroundColor = [UIColor clearColor];
        self.pageControl.alpha = 0.7;
        self.pageControl.pageIndicatorTintColor =[UIColor colorWithWhite:0.f alpha:0.3];
        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:self.pageControl];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.myScroll.frame = CGRectMake(0, 0, kScreenWidth, 130);
    self.pageControl.frame = CGRectMake((kScreenWidth - pageConWith) / 2.f, 130 - pageHeight, pageConWith, pageHeight);
}
@end
