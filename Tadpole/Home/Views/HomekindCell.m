//
//  HomekindCell.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/4/29.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "HomekindCell.h"


#define pageConWith  80
#define pageHeight   30

@implementation HomekindCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.kImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.kImageBtn.tag = 1004;
//        [self.kImageBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
      
        self.kImageBtn.backgroundColor = [UIColor redColor];
        self.kImageBtn.frame = CGRectMake(0 , 0, kScreenWidth,  100);
       
        
//        self.myScroll = [[UIScrollView alloc]init];
//        self.myScroll.showsHorizontalScrollIndicator = NO;
//        self.myScroll.showsVerticalScrollIndicator = NO;
//        [self.myScroll setContentOffset:CGPointMake(0, 0) animated:NO];
//        self.myScroll.bounces = NO;
//        self.myScroll.pagingEnabled = YES;
//        [self addSubview:self.myScroll];
//        
//        // UIPageControll
//        self.pageControl = [[UIPageControl alloc]init];
//        self.pageControl.backgroundColor = [UIColor clearColor];
//        self.pageControl.alpha = 0.7;
//        self.pageControl.pageIndicatorTintColor =[UIColor colorWithWhite:0.f alpha:0.3];
//        self.pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
//        [self addSubview:self.pageControl];
    }
    return self;
}
- (void)setContentWithDic:(NSDictionary *)dict
{
    NSString *picStr = [dict objectForKey:kKindDefaults];
    
    if (picStr) {
    [self.kImageBtn setImage:[UIImage imageNamed:picStr] forState:UIControlStateNormal];
    self.kImageBtn.frame = CGRectMake(0, 0, kScreenWidth, 100);
    }else {
        self.kImageBtn.frame = CGRectMake(0, 0, 0, 0);
    }
    
    //
//    self.myScroll.frame = CGRectMake(0, self.kImageBtn.bottom, kScreenWidth, 130);
//  
//    
//    self.pageControl.frame = CGRectMake((kScreenWidth - pageConWith) / 2.f, 130 + pageHeight, pageConWith, pageHeight);
}


@end
