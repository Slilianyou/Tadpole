//
//  MainViewController.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/3.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "MainViewController.h"
#import "CUSCollectionViewCell.h"
#import "MYPictureView.h"
#import  "MainTabCell.h"
#import "ProduceInfoViewController.h"


#define pageConWith  80
#define pageHeight   30

@interface MainViewController ()

@end

@implementation MainViewController
{
    NSTimer *_timer;
    CGFloat _headScrollHeight;
    CGFloat _headScrollWidth;
}
#pragma mark -- DELEGATE
#pragma mark -- UISCROLLVIEWDELEGATE
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.myScroll) {
        
        CGPoint point = scrollView.contentOffset;
        if (point.x ==0) {
            point.x = (self.scrollImageArr.count - 2) *kScreenWidth ;
            [self.myScroll setContentOffset: point animated:NO];
        }else if (point.x == (self.scrollImageArr.count - 1) *kScreenWidth){
            point.x = kScreenWidth;
            [self.myScroll setContentOffset:point animated:NO];
        }
        
        NSInteger page = scrollView.contentOffset.x  / kScreenWidth - 1;
        self.pageControl.currentPage = page;
    } else if (scrollView == self.headScroll) {
        CGPoint point = self.headScroll.contentOffset;
        if (point.y == 0) {
            point.y = 4 *_headScrollHeight;
            [self.headScroll setContentOffset:point];
        }else if (point.y == 5 *_headScrollHeight){
            point.y = _headScrollHeight;
            [self.headScroll setContentOffset:point];
        }
    }
}


#pragma  mark -- Method
- (void)addBtnItem
{
    self.title = @"首页";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Left" style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(presentRightMenuViewController:)];
    
}

- (void)presentLeftMenuViewController:(id)sender
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (void)presentRightMenuViewController:(id)sender
{
    [self.sideMenuViewController presentRightMenuViewController];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addBtnItem];
    self.view.backgroundColor = [UIColor greenColor];
    // NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    [self change];
    [self addTimer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-  UIScrollView
- (void)change
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:@"" forKey:@"isFinishedLogin"];
    [def synchronize];
    // Add UIScrollView
    self.myScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    self.myScroll.backgroundColor = [UIColor redColor];
    // 数据
    self.scrollImageArr = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"loading-1.png"],[UIImage imageNamed:@"loading-2.png"],[UIImage imageNamed:@"loading-3.png"],[UIImage imageNamed:@"loading-4.png"], nil];
    
    [self.scrollImageArr insertObject:[self.scrollImageArr lastObject] atIndex:0];
    
    [self.scrollImageArr addObject:[self.scrollImageArr objectAtIndex:1]];
    self.myScroll.showsHorizontalScrollIndicator = NO;
    self.myScroll.contentSize = CGSizeMake(self.scrollImageArr.count *kScreenWidth, 100);
    [self.myScroll setContentOffset:CGPointMake(kScreenWidth, 0) animated:NO];
    self.myScroll.bounces = NO;
    self.myScroll.delegate = self;
    self.myScroll.pagingEnabled = YES;
    for (int i = 0; i < self.scrollImageArr.count ; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(i*kScreenWidth, 0, kScreenWidth, 100);
        imageView.image = [self.scrollImageArr objectAtIndex:i];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.myScroll addSubview:imageView];
    }
    
    [self.view addSubview:self.myScroll];
    
    // UIPageControll
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(kScreenWidth - pageConWith - 5, 100 - pageHeight, pageConWith, pageHeight)];
    self.pageControl.numberOfPages = self.scrollImageArr.count - 2;
    self.pageControl.backgroundColor = [UIColor clearColor];
    self.pageControl.alpha = 0.7;
    self.pageControl.pageIndicatorTintColor =[UIColor colorWithWhite:0.f alpha:0.3];
    self.pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    [self.view addSubview:self.pageControl];
    
    // UICollectionView
    //先实例化一个层
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    // 创建视图
    self.collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myScroll.frame), kScreenWidth ,180) collectionViewLayout:layout];
    [self.collectionV registerClass:[CUSCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionLLY"];
    self.collectionV.backgroundColor = [UIColor whiteColor];
    
    self.collectionV.dataSource = self;
    self.collectionV.delegate = self;
    [self.view addSubview:self.collectionV];
    
    // headScroll
    [self addCustomHeadView];
    [self addMyTableView];
    
}

#pragma mark - HeadScroll
- (void)addCustomHeadView
{
    // backgroundView;
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionV.frame), kScreenWidth, 60)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    // TopLine
    UIImageView *topLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    topLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [backView addSubview:topLine];
    
    // left UIImageView
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0.5, 60,59.5)];
    imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    imageView.image = [UIImage imageNamed:@"headTitle.png"];
    [backView addSubview:imageView];
    
    // rightLine
    UIImageView *rightLine = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) ,4, 0.5, imageView.frame.size.height - 8)];
    rightLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [backView addSubview:rightLine];
    
    // headScroll
    NSMutableArray * strArr = [[NSMutableArray alloc]initWithObjects:@"🐂🐂🐂🐂1月3日冬",@"🐑🐑🐑🐑12月30日春",@"🐷🐷🐷🐷1月1日夏",@"🐒🐒🐒🐒1月2日秋",@"🐂🐂🐂🐂1月3日冬" ,@"🐑🐑🐑🐑12月30日春",nil];
    
    _headScrollHeight = backView.frame.size.height - 1;
    _headScrollWidth  = kScreenWidth - CGRectGetMaxX(rightLine.frame);
    self.headScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(rightLine.frame), 0.5,_headScrollWidth,_headScrollHeight)];
    self.headScroll.contentSize = CGSizeMake(_headScrollWidth, _headScrollHeight * 6);
    self.headScroll.showsHorizontalScrollIndicator = NO;
    self.headScroll.showsVerticalScrollIndicator = NO;
    self.headScroll.pagingEnabled = YES;
    self.headScroll.bounces = NO;
    self.headScroll.delegate = self;
    for (int i = 0; i < 6; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, i * _headScrollHeight, _headScrollWidth - 10, _headScrollHeight)];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor purpleColor];
        label.text = [strArr objectAtIndex:i];
        [self.headScroll addSubview:label];
    }
    [backView addSubview:self.headScroll];
    self.headScroll.contentOffset = CGPointMake(0, _headScrollHeight);
}
#pragma mark - BottomScroll
- (void)addMyTableView
{
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionV.frame) + 60 , kScreenWidth,(kScreenHeight - CGRectGetMaxY(self.collectionV.frame)- 60)) style:UITableViewStylePlain];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.view addSubview:self.myTableView];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainTabCell"];
    if (cell == nil) {
        cell = [[MainTabCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mainTabCell"];
    }
    return cell;
}













//定义展示的UICollectionCell的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
// 定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
// 每个UICollectionVie展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CUSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionLLY" forIndexPath:indexPath];
    if (!cell) {
        cell = [[CUSCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, 60, 80)];
    }
    cell.imageView.image = [UIImage imageNamed:@"hou.png"];
    cell.titleLabel.text = @"猴年大吉";
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}
#pragma mark -- UICollectionViewDelegate
// UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    ProduceInfoViewController *proInfo = [[ProduceInfoViewController alloc]init];
    [self.navigationController pushViewController:proInfo animated:YES];
    
}
#pragma mark - UICollectionViewDelegateFlowLayout
// 定义每个UICollection的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGSizeMake(60, 80);
}
// 定义每个UICollectionView的边距）
- (UIEdgeInsets )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
};

- (void)scrollViewAutoScroll:(UIScrollView *)scrollView
{
    CGPoint point = self.myScroll.contentOffset;
    point.x += kScreenWidth;
    [self.myScroll setContentOffset:point animated:YES];
    CGPoint headPoint = self.headScroll.contentOffset;
    headPoint.y += _headScrollHeight;
    [self.headScroll setContentOffset:headPoint animated:YES];
}
- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(scrollViewAutoScroll:) userInfo:nil repeats:YES];
}

@end
