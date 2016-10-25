////
////  MusicViewController.m
////  Tadpole
////
////  Created by ss-iOS-LLY on 16/1/12.
////  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
////
//
//#import "MusicViewController.h"
//#import "MusicTableViewCell.h"
//#import "MJRefresh.h"
//#import "MusicInfoViewController.h"
//
//@interface MusicViewController ()<UITableViewDelegate,UITableViewDataSource>
//{
//     NSInteger _page;
//}
//@property (nonatomic, strong)UITableView *myTableView;
//@property (nonatomic, strong)NSMutableArray *arrData;
//@end
//
//@implementation MusicViewController
//
//#pragma mark - UITableViewDelegate
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.arrData.count;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 90;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    MusicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MusicCell"];
//    if (!cell) {
//        cell = [[MusicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MusicCell"];
//    }
//    
////        cell.coverSmallImage.image = [UIImage ima[[self.arrData objectAtIndex:indexPath.row]objectForKey:@"coverSmall"]];
//    [cell.coverSmallImage sd_setImageWithURL:[NSURL URLWithString:[[self.arrData objectAtIndex:indexPath.row]objectForKey:@"coverSmall"]]placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//        cell.coverSmallImage.contentMode = UIViewContentModeScaleAspectFit;
//        cell.titleLabel.text = [[self.arrData objectAtIndex:indexPath.row]objectForKey:@"title"];
//
//    
//    return cell;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    MusicInfoViewController *musicInfoVC = [[MusicInfoViewController alloc]init];
//    NSLog(@"%@",[self.arrData objectAtIndex:indexPath.row]);
//    musicInfoVC.title = [[self.arrData objectAtIndex:indexPath.row]objectForKey:@"title"];
//    musicInfoVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:musicInfoVC animated:YES];
//    
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.arrData = [[NSMutableArray alloc]init];
//    [self addItem];
//    [self addCustom];
//
//    // 集成刷新控件
//    [self setupRefresh];
//}
//- (void)setupRefresh
//{
//   // 1.下拉刷新(进入刷新状态就会调用self 的 headerRereshing)
//    [self.myTableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
//    [self.myTableView headerBeginRefreshing];
//    
//   // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
//    [self.myTableView addFooterWithTarget:self action:@selector(footerRereshing)];
//    // 设置文字
//    self.myTableView.headerPullToRefreshText = @"下拉刷新";
//    self.myTableView.headerReleaseToRefreshText = @"松开马上刷新了";
//    self.myTableView.headerRefreshingText = @"正在刷新...";
//    
//    self.myTableView.footerPullToRefreshText = @"上拉加载";
//    self.myTableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
//    self.myTableView.footerRefreshingText = @"正在加载...";
//}
//#pragma mark 开始进入刷新状态
//- (void)headerRefreshing
//{
//  
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        _page = 1;
//        [self sendRequest];
//        [self.myTableView headerEndRefreshing];
//    });
//}
//- (void)footerRereshing
//{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        _page ++;
//        [self sendRequest];
//        [self.myTableView footerEndRefreshing];
//    });
//}
//- (void)addCustom
//{
//    // addTableView
//    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
//    self.myTableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleWidth;
//    self.myTableView.delegate = self;
//    self.myTableView.dataSource = self;
////    self.myTableView.opaque = NO;
//    self.myTableView.backgroundColor = [UIColor greenColor];
////    self.myTableView.backgroundView = nil;
//    self.myTableView.separatorColor = UITableViewCellSeparatorStyleNone;
//    self.myTableView.bounces = YES;
//    [self.view addSubview:self.myTableView];
//    
//    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.myTableView setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if ([self.myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.myTableView setLayoutMargins:UIEdgeInsetsZero];
//    }
//    
//    UIView *view = [[UIView alloc]init];
//    view.backgroundColor = [UIColor redColor];
//    [self.myTableView setTableFooterView:view];
//    NSLog(@"%@",NSStringFromCGSize(self.myTableView.frame.size));
//    [self.myTableView setContentInset:UIEdgeInsetsMake(0, 0, -49, 0)];
//
//}
//#pragma mark -AddNavigationItem
//- (void)addItem
//{
//    self.title = @"听音乐";
//    // 按钮
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.tag = 100;
//    [btn setBackgroundImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    btn.backgroundColor = [UIColor redColor];
//    btn.frame = CGRectMake(0 , 0, 30,  30);
//    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    self.navigationItem.leftBarButtonItem = barBtn;
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}
//
//#pragma mark - ButtonClicked
//- (void)buttonClicked:(UIButton *)sender
//{
//    if (sender.tag == 100) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}
//#pragma mark - RequestMethod
//- (void)sendRequest
//{
////    NSString *str = @"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=iPhone&pageId=1&pageSize=20&status=0&tagName=%E7%94%B5%E5%BD%B1%7C%E5%8E%9F%E5%A3%B0";
//    NSLog(@"%d",_page);
//    NSString *str = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=2&device=iPhone&pageId=%d&pageSize=20&status=0&tagName=电影|原声",_page];
//     //  "albumId": 3183879,
////    http://mobile.ximalaya.com/mobile/others/ca/album/track/3183879/true/1/20?device=iPhone
//    
//    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"%@",str);
//       [MyAFNetWork getGetResponeWithParameters:nil andUrlStr:str andBlock:^(id myAfNetBlockResponeDic) {
//        //
//        if ([[myAfNetBlockResponeDic objectForKey:@"msg"] isEqualToString:@"成功"]) {
//            NSArray *arr = [myAfNetBlockResponeDic objectForKey:@"list"];
//            [self.arrData addObjectsFromArray:arr];
//            [self.myTableView reloadData];
//            if (arr.count < 20) {
//                [self.myTableView footerEndRefreshing];
//                return;
//            }
//        }
//    }];
//}
//@end
