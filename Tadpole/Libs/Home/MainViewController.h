//
//  MainViewController.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/3.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "RESideMenu.h"
#import "CUSViewController.h"

@interface MainViewController : CUSViewController<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIScrollView *myScroll;
@property (nonatomic, strong) NSMutableArray *scrollImageArr;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) UIScrollView *headScroll;
@property (nonatomic, strong)UITableView *myTableView;



































































@end
