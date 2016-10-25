//
//  MainViewController.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/3.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "MainViewController.h"
#import "MyTextField.h"
#import "HomeModel.h"
#import "HomeTopScrCell.h"
#import "CollectionViewCell.h"
#import "RushBuyCell.h"

// 自定义的刷新header
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
#import "MJChiBaoZiFooter2.h"
#import "MJDIYHeader.h"
#import "MJDIYAutoFooter.h"
#import "MJDIYBackFooter.h"
//
#import "HistoryTableViewCell.h"

//
#import "AddressViewController.h"
//
#import "ProduceSearchVC.h"
//
#import "VoiceViewController.h"
//
#import "ScanViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "TomMainVC.h"

//直播
#import "RTMPViewController.h"
//签到
#import "SignVC.h"
//地图
#import "LLYMapViewController.h"

#define pageConWith  80
#define pageHeight   30
#define kHeadLogoHeight 90
#define NAVBAR_CHANGE_POINT 32

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
{
    NSTimer *_timer;
    UIPageControl *_kindPageControl;
    UIButton *_activeBtn;
    UIScrollView *_headScr;
    CGFloat _headScrollHeight;
    CGFloat _headScrollWidth;
    
    // titleView
    UIButton *_leftBtn;
    MyTextField *_scoText;
    UIButton *_shoppingBtn;
    UIButton *_scanBtn;
    UIButton *_leftIconBtn;
    
    //
    UIButton *_leftItemBtn;
    //
    UIImageView * _showREMenuIcon;
}
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *upBannerArray;
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *kindlist;
//
@property (nonatomic, strong) UIScrollView *myScroll;
@property (nonatomic, strong) NSMutableArray *scrollImageArr;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation MainViewController
//TODO:navigationBar展示效果 1
#pragma mark -- NavigationBarAppearOne
- (void)setUpMainTitleView
{
    // 按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 3000;
    btn.frame = CGRectMake( 0 , 0, 40,  40);
    btn.backgroundColor = [UIColor clearColor];
    btn.showsTouchWhenHighlighted = YES;
    [btn setImage:[UIImage imageNamed:@"Main_TitleView_Tadpole@2x.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;
}
- (void)addNaviLeftBarItem
{
    _leftItemBtn = [[UIButton alloc]init];
    [_leftItemBtn setFrame:CGRectMake(0, 0, 32,32)];
    [_leftItemBtn setBackgroundColor:[UIColor clearColor]];
    _leftItemBtn.tag = 3001;
    [_leftItemBtn setImage:[UIImage imageNamed:@"Main_NaviLeftBarItem_ToRight@2x.png"] forState:UIControlStateNormal];
    [_leftItemBtn addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:_leftItemBtn];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if (IOSversion >= 7.0) space.width = -10;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:space,leftBtnItem, nil];
}
- (void)addNaviRightBarItem
{
    UIButton *rightBtn = [[UIButton alloc]init];
    [rightBtn setFrame:CGRectMake(0, 0, 32,32)];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    rightBtn.tag = 3002;
    [rightBtn setImage:[UIImage imageNamed:@"Main_NaviRightBarItem_List@2x.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setNavigationAppearceOne
{
    [self setUpMainTitleView];
    [self addNaviLeftBarItem];
    [self addNaviRightBarItem];
}
//TODO:navigationBar展示效果 2
#pragma mark -- ShoppingForNavigationBarAppearTwo
- (void)addNaviTabBarItem
{
    // 1.
    _leftBtn = [[UIButton alloc]init];
    _leftBtn.tag = 3003;
    [_leftBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_leftBtn setBackgroundColor:[UIColor clearColor]];
    [_leftBtn setTitle:@"上海"];
    [_leftBtn setTitleFont:[UIFont systemFontOfSize:15.f]];
    [_leftBtn setFrame:CGRectMake(0, 0, 40,40)];
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:_leftBtn];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if (IOSversion >= 7.0) space.width = -10;
    
    _leftIconBtn = [[UIButton alloc]init];
    _leftIconBtn.backgroundColor = [UIColor blackColor];
    _leftIconBtn.tag = 40000;
    [_leftIconBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_leftIconBtn setImage:[UIImage imageNamed:@"jiantouBottomBai"] forState:UIControlStateNormal];
    [_leftIconBtn setFrame:CGRectMake(0, 0, 12,12)];
    _leftIconBtn.imageEdgeInsets = UIEdgeInsetsMake(1, -18, 0, 0);
    _leftIconBtn.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *leftIconBtnItem = [[UIBarButtonItem alloc]initWithCustomView:_leftIconBtn];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:space,leftBtnItem,leftIconBtnItem, nil];
    
    //titleView
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth - 140, 30)];
    titleView.backgroundColor = [UIColor clearColor];
    
    //scop_leftView
    _scoText = [[MyTextField alloc]init];
    _scoText.delegate = self;
    _scoText.frame = CGRectMake(-10, 0, titleView.width, titleView.height);
    _scoText.layer.borderWidth = 0.5;
    _scoText.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _scoText.backgroundColor = [UIColor colorWithWhite:1.f alpha:0.6];
    
    _scoText.placeholder = @"  搜索商家或地点";
    _scoText.font = [UIFont systemFontOfSize:15.f];
    UIImageView *leftImage =[[UIImageView  alloc]initWithImage:[UIImage imageNamed:@"search"]];
    leftImage.frame = CGRectMake(0, 0, 15, 15);
    _scoText.leftView = leftImage;
    
    // speakBtn_rightView;
    UIButton *speakBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    speakBtn.tag = 3004;
    [speakBtn setImage:[UIImage imageNamed:@"speak"] forState:UIControlStateNormal];
    [speakBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    speakBtn.backgroundColor = [UIColor clearColor];
    speakBtn.frame = CGRectMake(0 , 0, 20,  20);
    _scoText.rightView = speakBtn;
    
    _scoText.leftViewMode  = UITextFieldViewModeAlways;
    _scoText.rightViewMode = UITextFieldViewModeAlways;
    [titleView addSubview:_scoText];
    self.navigationItem.titleView = titleView;
    
    
    // rightBarItem
    _shoppingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shoppingBtn.frame = CGRectMake(0, 0, 30, 30);
    _shoppingBtn.tag = 3005;
    // shoppingBtn.backgroundColor = [UIColor redColor];
    [_shoppingBtn setImage:[UIImage imageNamed:@"gouwucheBai"] forState:UIControlStateNormal];
    [_shoppingBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightShopping = [[UIBarButtonItem alloc]initWithCustomView:_shoppingBtn];
    //
    _scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _scanBtn.frame = CGRectMake(0, 0, 30, 30);
    _scanBtn.tag = 3006;
    [_scanBtn setImage:[UIImage imageNamed:@"saomiaoBai"] forState:UIControlStateNormal];
    [_scanBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightScan = [[UIBarButtonItem alloc]initWithCustomView:_scanBtn];
    UIBarButtonItem *rightspace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if (IOSversion >= 7.0) rightspace.width = -10;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightspace,rightScan,rightShopping,nil];
    
    /*
     _showREMenuIcon= [[UIImageView alloc]initWithFrame:CGRectMake(10, 0,50,25                                 )];
     _showREMenuIcon.backgroundColor = [UIColor clearColor];
     _showREMenuIcon.image = [UIImage imageNamed:@"showREMenu"];
     [self.navigationController.navigationBar addSubview:_showREMenuIcon];
     */
}

//TODO:btn点击方法
#pragma mark -- SEL  Action
- (void)buttonClicked:(UIButton *)sender
{
    switch (sender.tag) {
        case 3000:{
            [self refreshBoard];
            sender.userInteractionEnabled = NO;
        }
            break;
        case 3002:{
            //改变Main的navigation样式
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            [def setBool:YES forKey:@"addNaviTabBarItem"];
            [def synchronize];
            for (UIView *view  in self.view.subviews) {
                [view removeFromSuperview];
            }
            [self viewDidLoad];
        }
            break;
        case 3003:{
            AddressViewController *addressVC = [[AddressViewController alloc]init];
            addressVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:addressVC animated:YES];
        }
            break;
        case 3004:{
            // 语音
            //            self.sideMenuViewController.tabBarController.tabBar.hidden = YES;
            VoiceViewController *voiceVC = [[VoiceViewController alloc]init];
            voiceVC.hidesBottomBarWhenPushed = YES;
            [self presentViewController:voiceVC animated:YES completion:^{
            }];
        }
            break;
        case 3005:{
            // 购物车
            //            VoiceViewController *voiceVC = [[VoiceViewController alloc]init];
            //            [self presentViewController:voiceVC animated:YES completion:^{
            //
            //            }];
        }
            break;
        case 3006:{
            // 扫描
            //            self.sideMenuViewController.tabBarController.tabBar.hidden = YES;
            ScanViewController *scanVC = [[ScanViewController alloc]init];
            scanVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:scanVC animated:NO];
        }
            break;
        default:
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //登录判断
    [self handleData];
    //    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //    if ([[def objectForKey:@"addNaviTabBarItem"] boolValue]) {
    if([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //        self.navigationController.navigationBar.translucent = YES;
    [[self.navigationController.navigationBar subviews]objectAtIndex:0].alpha = 1;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self addNaviTabBarItem];
    
    //    } else {
    //        self.automaticallyAdjustsScrollViewInsets = YES;
    //         self.extendedLayoutIncludesOpaqueBars = NO;
    //
    //        [self setNavigationAppearceOne];
    //    }
    [self cleanBlackLineForNavigationBar];
    [self setupTableView];
    [self refreshBoard];
    [self addTimer];
    
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}
#pragma mark -- handleData
- (void)handleData
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setBool:NO forKey:@"isFinishedLogin"];
    [def synchronize];
}
#pragma mark ----UITableView
- (void)setupTableView
{
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.showsHorizontalScrollIndicator = NO;
    self.myTableView.opaque = NO;
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.backgroundView = nil;
    self.myTableView.separatorColor = UITableViewCellSeparatorStyleNone;
    self.myTableView.bounces = YES;
    [self.view addSubview:self.myTableView];
    
    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.myTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.myTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.myTableView setTableFooterView:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//#pragma mark - HeadScroll
//- (void)addCustomHeadView
//{
//    // backgroundView;
//    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionV.frame), kScreenWidth, 60)];
//    backView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:backView];
//
//    // TopLine
//    UIImageView *topLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
//    topLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [backView addSubview:topLine];
//
//    // left UIImageView
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0.5, 60,59.5)];
//    imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    imageView.image = [UIImage imageNamed:@"headTitle.png"];
//    [backView addSubview:imageView];
//
//    // rightLine
//    UIImageView *rightLine = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) ,4, 0.5, imageView.frame.size.height - 8)];
//    rightLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [backView addSubview:rightLine];
//
//    // headScroll
//    NSMutableArray * strArr = [[NSMutableArray alloc]initWithObjects:@"🐂🐂🐂🐂1月3日冬",@"🐑🐑🐑🐑12月30日春",@"🐷🐷🐷🐷1月1日夏",@"🐒🐒🐒🐒1月2日秋",@"🐂🐂🐂🐂1月3日冬" ,@"🐑🐑🐑🐑12月30日春",nil];
//
//    _headScrollHeight = backView.frame.size.height - 1;
//    _headScrollWidth  = kScreenWidth - CGRectGetMaxX(rightLine.frame);
//    self.headScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(rightLine.frame), 0.5,_headScrollWidth,_headScrollHeight)];
//    self.headScroll.contentSize = CGSizeMake(_headScrollWidth, _headScrollHeight * 6);
//    self.headScroll.showsHorizontalScrollIndicator = NO;
//    self.headScroll.showsVerticalScrollIndicator = NO;
//    self.headScroll.pagingEnabled = YES;
//    self.headScroll.bounces = NO;
//    self.headScroll.delegate = self;
//    for (int i = 0; i < 6; i++) {
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, i * _headScrollHeight, _headScrollWidth - 10, _headScrollHeight)];
//        label.textAlignment = NSTextAlignmentLeft;
//        label.textColor = [UIColor purpleColor];
//        label.text = [strArr objectAtIndex:i];
//        [self.headScroll addSubview:label];
//    }
//    [backView addSubview:self.headScroll];
//    self.headScroll.contentOffset = CGPointMake(0, _headScrollHeight);
//}
//#pragma mark - BottomScroll
//- (void)addMyTableView
//{
//    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionV.frame) + 60 , kScreenWidth,(kScreenHeight - CGRectGetMaxY(self.collectionV.frame)- 60)) style:UITableViewStylePlain];
//    self.myTableView.dataSource = self;
//    self.myTableView.delegate = self;
//    [self.view addSubview:self.myTableView];
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//    UIView *backView = [[UIView alloc]init];
//    backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//
//    return backView;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 15;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 1;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 200;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    MainTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainTabCell"];
//    if (cell == nil) {
//        cell = [[MainTabCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mainTabCell"];
//    }
//    return cell;
//}
//










//
//
////定义展示的UICollectionCell的数量
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return 5;
//}
//// 定义展示的Section的个数
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 2;
//}
// 每个UICollectionVie展示的内容
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CUSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionLLY" forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[CUSCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, 60, 80)];
//    }
//    cell.imageView.image = [UIImage imageNamed:@"hou.png"];
//    cell.titleLabel.text = @"猴年大吉";
//    cell.backgroundColor = [UIColor lightGrayColor];
//    return cell;
//}
//#pragma mark -- UICollectionViewDelegate
//// UICollectionView被选中时调用的方法
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = (UICollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blueColor];
//    ProduceInfoViewController *proInfo = [[ProduceInfoViewController alloc]init];
//    [self.navigationController pushViewController:proInfo animated:YES];
//
//}
//#pragma mark - UICollectionViewDelegateFlowLayout
//// 定义每个UICollection的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
//{
//    return CGSizeMake(60, 80);
//}
//// 定义每个UICollectionView的边距）
//- (UIEdgeInsets )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//};
//
//- (void)scrollViewAutoScroll:(UIScrollView *)scrollView
//{
//    CGPoint point = self.myScroll.contentOffset;
//    point.x += kScreenWidth;
//    [self.myScroll setContentOffset:point animated:YES];
//    CGPoint headPoint = self.headScroll.contentOffset;
//    headPoint.y += _headScrollHeight;
//    [self.headScroll setContentOffset:headPoint animated:YES];
//}
- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.f target:self selector:@selector(scrollViewAutoScroll:) userInfo:nil repeats:YES];
}
#pragma mark --- 侧边栏代理方法
- (void)presentLeftMenuViewController:(id)sender
{
    [_leftItemBtn setImage:[UIImage imageNamed:@"Main_NaviLeftBarItem_ToLeft@2x.png"] forState:UIControlStateNormal];
    [self.sideMenuViewController presentLeftMenuViewController];
    if (!self.sideMenuViewController.delegate) {
        self.sideMenuViewController.delegate =self;
    }
    
}
- (void)presentRightMenuViewController:(id)sender
{
    [self.sideMenuViewController presentLeftMenuViewController];
}
- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    [_leftItemBtn setImage:[UIImage imageNamed:@"Main_NaviLeftBarItem_ToRight@2x.png"] forState:UIControlStateNormal];
    if (self.sideMenuViewController.delegate) {
        self.sideMenuViewController.delegate =nil;
    }
    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
    
}

static NSString *const cellId = @"CellId";


#pragma mark -- DELEGATE
#pragma mark --- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 40;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [self.myCollectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[CollectionViewCell alloc]init];
    }
    NSDictionary *dic = [self.kindlist objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[dic objectForKey:@"icon"]];
    cell.textLabel.text = [dic objectForKey:@"title"];
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.selectedBackgroundView = view;
    return cell;
}
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (collectionView == self.myCollectionView) {
//        CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//        cell.backgroundColor = [UIColor redColor];
//    }
//}

#pragma mark -UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth / 5 ), (kScreenWidth / 5 ) + 20);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 5;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"%ld",(long)indexPath.item);
    switch (indexPath.item) {
        case 10:{
            TomMainVC *TomVC = [[TomMainVC alloc]init];
            [self presentViewController:TomVC animated:YES completion:nil];
        }
            
            break;
        case 11:{
            SignVC *calendarSign = [[SignVC alloc]init];
            calendarSign.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:calendarSign animated:YES];
                }
            break;
        case 12:{
            //             LearnForijkPlayerVC *learnPlayer = [[LearnForijkPlayerVC alloc]init];
            RTMPViewController *rtmpVC = [[RTMPViewController alloc]init];
            rtmpVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:rtmpVC animated:YES];
        }
            break;
        case 13:{
            LLYMapViewController *mapVC = [[LLYMapViewController alloc]init];
            UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc]initWithTitle:@"走路不用图" style:UIBarButtonItemStylePlain target:nil action:nil];
            backBarBtn.title = @"走路不用图";
            [self.navigationItem setBackBarButtonItem:backBarBtn];
            [self presentViewController:mapVC animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    
    //    if (indexPath.item == 11){
    //
    //
    //    }
    //    if (indexPath.item == 12) {
    //        // LearnForijkPlayerVC *learnPlayer = [[LearnForijkPlayerVC alloc]init];
    //        RTMPViewController *rtmpVC = [[RTMPViewController alloc]init];
    //        [self.navigationController pushViewController:rtmpVC animated:YES];
    //    }
    //    if (indexPath.item == 13) {
    //        LLYMapViewController *mapVC = [[LLYMapViewController alloc]init];
    //        [self presentViewController:mapVC animated:YES completion:nil];
    //    }
    //    if (indexPath.item == 14) {
    //        //        CollectionVideoVC *collectionVC = [[CollectionVideoVC alloc]init];
    //        //        [self presentViewController:collectionVC animated:YES completion:nil];
    //    }
    //
    //    if (indexPath.item == 15){
    //
    //        AnimationViewController *voiceVC = [[AnimationViewController alloc]init];
    //        [self.navigationController pushViewController:voiceVC animated:YES];
    //    }
    //    if (indexPath.item == 18){
    //
    //        LearnForijkPlayerVC *voiceVC1 = [[LearnForijkPlayerVC alloc]init];
    //        [self.navigationController pushViewController:voiceVC1 animated:YES];
    //    }
    //
    //    if (indexPath.item == 17){
    //
    //        ThreeDSphereVC *sphereVC = [[ThreeDSphereVC alloc]init];
    //        [self.navigationController pushViewController:sphereVC animated:YES];
    //    }
    //
    //    if (indexPath.item == 16){
    //
    //        PreViewController *preVC = [[PreViewController alloc]init];
    //        [self.navigationController pushViewController:preVC animated:YES];
    //    }
    //
    
    
    
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        NSMutableDictionary *dict = [[HomeModel sharedInstance]getDataForKind];
        NSString *activePic = [dict objectForKey:kKindDefaults];
        
        return (kScreenWidth / 5 + 20) * 2 + 5 + 40 +  (![self isBlankString:activePic]  ? 100 : 0)  + 30;
        
    } else if ( section == 2){
        return 10;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 0;
    }
    
    //
    if (section == 2) {
        return 10;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 128;
    } else if (indexPath.section == 1)
    {
        return 0;
    } else if (indexPath.section == 2) {
        // CGFloat a = kScreenWidth / 3.0;
        return 165.f ;
    }
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
        UIView *view = [[UIView alloc]init];
        view.frame = CGRectMake(0, 0, kScreenWidth, (kScreenWidth / 5 + 20) * 2 + 5 + 100 + 30);
        view.backgroundColor = [UIColor whiteColor];
        
        _activeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _activeBtn.backgroundColor = [UIColor whiteColor];
        _activeBtn.tag = 1004;
        [_activeBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _activeBtn.frame = CGRectMake(0 , 0, kScreenWidth,  100);
        
        
        //Data
        NSMutableDictionary *dict = [[HomeModel sharedInstance]getDataForKind];
        NSString *activePic = [dict objectForKey:kKindDefaults];
        
        if (![self isBlankString:activePic]) {
            [_activeBtn setImage:[UIImage imageNamed:activePic] forState:UIControlStateNormal];
        } else {
            _activeBtn.frame = CGRectMake(0, 0, 0, 0);
        }
        
        [self setupCollectionView];
        [view addSubview:_activeBtn];
        [view addSubview:self.myCollectionView];
        self.kindlist =[NSMutableArray arrayWithArray:[dict objectForKey:kKindList]];
        [self.myCollectionView reloadData];
        
        
        _kindPageControl = [[UIPageControl alloc]init];
        _kindPageControl.frame = CGRectMake((kScreenWidth - 100) / 2.0, self.myCollectionView.bottom ,100, 30);
        _kindPageControl.hidesForSinglePage = YES;
        _kindPageControl.backgroundColor = [UIColor clearColor];
        _kindPageControl.numberOfPages = 2;
        _kindPageControl.alpha = 0.7;
        _kindPageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.f alpha:0.3];
        _kindPageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [view addSubview:_kindPageControl];
        
        
        //
        [self.myCollectionView setContentSize:CGSizeMake(kScreenWidth *4, (kScreenWidth / 5 + 20) * 2 + 5 )];
        [self.myCollectionView setContentOffset:CGPointMake(kScreenWidth, 0)];
        
        // 头条
        //  TopLine
        UIImageView *  kHeadLine = [[UIImageView alloc]init                                               ];
        kHeadLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [view addSubview:kHeadLine];
        kHeadLine.frame = CGRectMake(0, _kindPageControl.bottom, kScreenWidth, 1);
        
        // 头条图标
        UIImageView *headerLineLogo = [[UIImageView alloc]init];
        headerLineLogo.backgroundColor = [UIColor whiteColor];
        headerLineLogo.image = [UIImage imageNamed:@"headLogo"];
        headerLineLogo.contentMode = UIViewContentModeScaleAspectFit;
        headerLineLogo.frame = CGRectMake(0, kHeadLine.bottom + 5, kHeadLogoHeight, 30);
        [view addSubview:headerLineLogo];
        
        
        // ScrollView;
        _headScr = [[UIScrollView alloc]init];
        _headScr.showsHorizontalScrollIndicator = NO;
        _headScr.bounces = NO;
        _headScr.pagingEnabled = YES;
        _headScr.userInteractionEnabled = NO;
        _headScr.delegate = self;
        [view addSubview:_headScr];
        
        
        NSArray *headlist = [dict objectForKey:kHeadList];
        _headScrollHeight = 40 ;
        _headScrollWidth  = kScreenWidth - kHeadLogoHeight;
        _headScr.frame = CGRectMake(headerLineLogo.right, kHeadLine.bottom, _headScrollWidth, 40 );
        
        //_headScr.backgroundColor = [UIColor redColor];
        
        for (UILabel * label in _headScr.subviews) {
            if (label) {
                [label removeFromSuperview];
            }
        }
        _headScr.contentOffset = CGPointMake(0, 40);
        for (int i = 0; i < headlist.count ; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, i * _headScrollHeight, _headScrollWidth - 10, _headScrollHeight)];
            label.tag = i + 100;
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor blackColor];
            label.text = [headlist objectAtIndex:i];
            [_headScr addSubview:label];
        }
        
        
        _headScr.contentSize = CGSizeMake(_headScrollWidth, _headScrollHeight * headlist.count);
        
        
        return view;
    } else if (section == 2) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return view;
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HomeTopScrCell * cell = [tableView dequeueReusableCellWithIdentifier:@"scrImage"];
        if (!cell) {
            cell = [[HomeTopScrCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"scrImage"];
        }
        [self addUpScrollWithArr:self.scrollImageArr andCell:cell];
        
        return cell;
        
    } else if (indexPath.section == 2) {
        HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryTableViewCell"];
        if (cell == nil) {
            cell = [[HistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HistoryTableViewCell"];
        }
        cell.backgroundColor = [UIColor whiteColor];
        [cell setDataForCellWIthDictionary:nil];
        //        cell.payForBtn.tag = 1005;
        //        cell.youHuiBtn.tag = 1006;
        //        [cell.payForBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        //        [cell.youHuiBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        //        NSDictionary *dict = [[HomeModel sharedInstance]getDataForKind];
        //        [cell setContentWithDict:dict];
        return cell;
    }
    
    return nil;
    
}

-(void)addUpScrollWithArr:(NSMutableArray*)sendA andCell:(HomeTopScrCell*)send
{
    [_upBannerArray removeAllObjects];
    [_upBannerArray addObjectsFromArray:sendA];
    for (UIImageView *subImage in send.myScroll.subviews) {
        [subImage removeFromSuperview];
    }
    
    send.pageControl.numberOfPages = _upBannerArray.count-2;
    
    for (int i = 0; i < _upBannerArray.count ; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(i*kScreenWidth, 0, kScreenWidth, 130);
        imageView.image = [_upBannerArray objectAtIndex:i];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [send.myScroll addSubview:imageView];
    }
    
    send.myScroll.delegate = self;
    send.myScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*_upBannerArray.count, 0);
    [send.myScroll setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0)];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark -- UISCROLLVIEWDELEGATE
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 透明导航栏
    // NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if (scrollView == self.myTableView /*&&[[def objectForKey:@"addNaviTabBarItem"]boolValue]*/ ) {
        
        CGFloat offsetY = scrollView.contentOffset.y;
        NSLog(@"------%f",offsetY);
        
        if (offsetY >=0){
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64))*2;
            [[self.navigationController.navigationBar subviews]objectAtIndex:0].alpha = alpha;
            [_leftBtn setTitleColor:[UIColor colorWithRed:255.0/255.0 green:255.0/225.0 blue:255.0/255.0 alpha:alpha]];
            
            CGFloat r = (237.f - 225.f) *alpha;
            CGFloat g = (225.f - 95.f) *alpha;
            CGFloat b = (225.f - 85.f) *alpha;
            
            UIColor *color = [UIColor colorWithRed:(r + 225)/255.0 green:(225 - g)/225.0 blue:(225.f  - b)/255.0 alpha:1 ];
            UIImage *imageForGou = [self imageWithColor:color withImage:[UIImage imageNamed:@"gouwucheBai"]];
            UIImage *scan = [self imageWithColor:color withImage:[UIImage imageNamed:@"saomiaoBai"]];
            UIImage *leftIconBtn = [self imageWithColor:color withImage:[UIImage imageNamed:@"jiantouBottomBai"]];
            [_shoppingBtn setImage:imageForGou forState:UIControlStateNormal];
            [_scanBtn setImage:scan forState:UIControlStateNormal];
            [_leftIconBtn setImage:leftIconBtn forState:UIControlStateNormal];
            [_leftBtn setTitleColor:color forState:UIControlStateNormal];
            
        } else  {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }
    }
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    HomeTopScrCell *cell =(HomeTopScrCell *) [self.myTableView cellForRowAtIndexPath:path];
    if (scrollView == cell.myScroll) {
        
        CGPoint point = scrollView.contentOffset;
        if (point.x ==0) {
            point.x = (_upBannerArray.count - 2) *kScreenWidth ;
            [cell.myScroll setContentOffset: point animated:NO];
        }else if (point.x == (_upBannerArray.count - 1) *kScreenWidth){
            point.x = kScreenWidth;
            [cell.myScroll setContentOffset:point animated:NO];
        }
        
        NSInteger page = scrollView.contentOffset.x  / kScreenWidth - 1;
        cell.pageControl.currentPage = page;
        
    }else if (scrollView == self.myCollectionView) {
        CGPoint point = self.myCollectionView.contentOffset;
        if (point.x == 0) {
            point.x = 2 *kScreenWidth;
            [self.myCollectionView setContentOffset:point];
            
        }else if (point.x == 3 *kScreenWidth){
            point.x= kScreenWidth;
            [self.myCollectionView setContentOffset:point];
        }
        NSInteger page = self.myCollectionView.contentOffset.x / kScreenWidth -1;
        _kindPageControl.currentPage = page;
    }
    else if (scrollView == _headScr)
    {
        CGPoint point = _headScr.contentOffset;
        if (point.y == 0) {
            point.y = 2 * 40;
            [_headScr setContentOffset:point ];
        } else if (point.y == 3*40){
            point.y = 40;
            [_headScr setContentOffset:point ];
        }
        
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    HomeTopScrCell *cell =(HomeTopScrCell *) [self.myTableView cellForRowAtIndexPath:path];
    if (scrollView == cell.myScroll) {
        [_timer pauseTimer];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    HomeTopScrCell *cell =(HomeTopScrCell *) [self.myTableView cellForRowAtIndexPath:path];
    if (scrollView == cell.myScroll) {
        [_timer resumeTimer];
        
    }
}

//改变图片颜色
- (UIImage *)imageWithColor:(UIColor *)color withImage:(UIImage *)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextClipToMask(context, rect, image.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark --  UI
#pragma mark ---UICollectionView
- (void)setupCollectionView
{
    
    UICollectionViewFlowLayout *Flowlayout = [[UICollectionViewFlowLayout alloc]init];
    [Flowlayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //    Flowlayout.headerReferenceSize = CGSizeMake(kScreenWidth, 100);
    CGFloat w =  (kScreenWidth / 5 ) + 20;
    self.myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, (_activeBtn.width ? _activeBtn.bottom : 0), kScreenWidth, w *2 + 5 ) collectionViewLayout:Flowlayout];
    self.myCollectionView.backgroundColor = [UIColor whiteColor];
    self.myCollectionView.pagingEnabled = YES;
    self.myCollectionView.bounces = YES;
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    self.myCollectionView.showsVerticalScrollIndicator = NO;
    self.myCollectionView.showsHorizontalScrollIndicator = NO;
    [self.myCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:cellId];
    
}
- (void)scrollViewAutoScroll:(UIScrollView *)scrollView
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    HomeTopScrCell *cell =(HomeTopScrCell *) [self.myTableView cellForRowAtIndexPath:path];
    
    cell.myScroll.backgroundColor = [UIColor colorWithRed: (CGFloat)arc4random_uniform(256)/256.f green:(CGFloat)arc4random_uniform(256)/256.f blue:(CGFloat)arc4random_uniform(256)/256.f alpha:1];
    
    CGPoint point =cell
    .myScroll.contentOffset;
    point.x += kScreenWidth;
    [cell.myScroll setContentOffset:point animated:YES];
    
    
    //
    CGPoint headPoint = _headScr.contentOffset;
    headPoint.y += _headScrollHeight;
    [_headScr setContentOffset:headPoint animated:YES];
    
    
}
- (BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]length] == 0) {
        return YES;
    }
    return NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    //    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //    if ([[def objectForKey:@"addNaviTabBarItem"] boolValue]) {
    [[self.navigationController.navigationBar subviews]objectAtIndex:0].alpha = 1.f;
    //    }
    //    _showREMenuIcon.hidden = YES;
    [_timer invalidate];
    _timer = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //    if ([[def objectForKey:@"addNaviTabBarItem"] boolValue]) {
    //        [self scrollViewDidScroll:self.myTableView];
    [[self.navigationController.navigationBar subviews]objectAtIndex:0].alpha = 0.f;
    //    }
    //    _showREMenuIcon.hidden = NO;
    [self addTimer];
}
- (void)cleanBlackLineForNavigationBar
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
}
#pragma mark -- 刷新
#pragma refresh
- (void)refreshBoard
{
    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    [header beginRefreshing];
    
    self.myTableView.mj_header = header;
    
}

- (void)loadNewData
{
    [_timer pauseTimer];
    self.upBannerArray = [NSMutableArray arrayWithCapacity:0];
    self.scrollImageArr = [[HomeModel sharedInstance]getImageArrForScr];
    // 模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
        [_timer resumeTimer];
        UIButton *btn = (UIButton *)[self.navigationItem.titleView viewWithTag:3000];
        btn.userInteractionEnabled = YES;
    });
    
}
#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    ProduceSearchVC *produceVC = [[ProduceSearchVC alloc]init];
    [self.navigationController pushViewController:produceVC animated:YES];
    return YES;
}
@end
