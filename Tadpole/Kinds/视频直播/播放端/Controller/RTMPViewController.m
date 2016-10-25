//
//  RTMPViewController.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/27.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "RTMPViewController.h"
#import "MJRefresh.h"
#import "TableViewDelegate.h"
#import "TableViewDataSource.h"
#import "MovieRMTPCreator.h"
#import "MovieRMTPLives.h"
#import "MovieRMTPMovieRMTP.h"
#import "DataTableViewCell.h"
#import "RTMPNetTool.h"
#import "LiveViewController.h"
















@interface RTMPViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *dataTableView;
@property (nonatomic, strong) NSMutableArray *totalSource;
@property (nonatomic, strong) TableViewDataSource *tableViewDataSource;
@property (nonatomic, strong) TableViewDelegate *tableViewDalegate;
@property (nonatomic, strong) MovieRMTPMovieRMTP *movieRmtp;
@property (nonatomic, assign) NSInteger page;
@end

@implementation RTMPViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    
    
}

-(void)dealloc
{
    [_dataTableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
}

- (void)createTableView
{
    _page = 1;
    _totalSource = [NSMutableArray array];
    self.navigationItem.title = @"RTMP 直播";
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    _dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    // 告诉tableView所有cell的估计行高
    _dataTableView.estimatedRowHeight = 270.f;
    // 告诉tableView的真实高度是自动计算的，根据你的约束来计算
    _dataTableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_dataTableView];
    

    [_dataTableView registerClass:[DataTableViewCell class] forCellReuseIdentifier:@"dataCell"];
    _tableViewDataSource = [[TableViewDataSource alloc]init];
    _tableViewDalegate = [[TableViewDelegate alloc]init];
    _dataTableView.delegate = _tableViewDalegate;
    _dataTableView.dataSource = _tableViewDataSource;
    
    [_dataTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _dataTableView.mj_header = header;
    [_dataTableView.mj_header beginRefreshing];
    
}
// KVO监听屏幕滚动
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    UIPanGestureRecognizer *pan = _dataTableView.panGestureRecognizer;
     //获取到拖拽的速度 >0 向下拖动 <0 向上拖动
    CGFloat velocity = [pan velocityInView:_dataTableView].y;
    NSLog(@"获取到拖拽的速度------------------------%f",velocity);
    if (velocity < -5) {
        //向上拖动，隐藏导航栏
        [self.navigationController setNavigationBarHidden:true animated:true];
    }
    else if (velocity>5) {
        //向下拖动，显示导航栏
        [self.navigationController setNavigationBarHidden:false animated:true];
    }
    else if(velocity==0){
        //停止拖拽
    }

}
- (void)loadNewData
{
    [self getDataWithHead:YES];
}

- (void)getDataWithHead:(BOOL)isHead
{
    if (isHead) {
        _page = 1;
    }else{
        if (_page < 2) {
            _page = 2;
        }
    }
    
    
    
    [RTMPNetTool get:RTMPGetData progress:^(NSProgress * _Nonnull progress) {
        //
    } success:^(id  _Nonnull responseObject) {
        _movieRmtp = [[MovieRMTPMovieRMTP alloc]initWithDictionary:responseObject];
        if (_movieRmtp.dmError != 0) {
            SHOW_ERROR
        } else {
            if (_movieRmtp.lives) {
                if ((isHead)) {
                    [_totalSource removeAllObjects];
                } else {
                    _page ++;
                }
                _totalSource = [_movieRmtp.lives mutableCopy];
                _tableViewDataSource.array = _totalSource;
                _tableViewDalegate.array = _totalSource;
                WS
                _tableViewDalegate.cellSelectedBlock = ^(id obj){
                    SS
                    [strongSelf cellSelectedWithObj:(id)obj];
                };
                
            }
            [_dataTableView reloadData];
        }
        if (isHead) {
            [_dataTableView.mj_header endRefreshing];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [_dataTableView.mj_footer endRefreshing];
                
            });
        }
    } failure:^(NSString * _Nonnull errorLD) {
        SHOW_NTERROR
        if (isHead) {
            [_dataTableView.mj_header endRefreshing];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [_dataTableView.mj_footer endRefreshing];
                
            });
        }
    }];
}

- (void)cellSelectedWithObj:(id)obj
{
    NSIndexPath *indexPath = obj;
    LiveViewController *LiveVC = [[LiveViewController alloc]init];
    MovieRMTPLives *rmtpLiveModel =_totalSource[indexPath.row];
    LiveVC.liveUrl = rmtpLiveModel.streamAddr;
    LiveVC.imageUrl = rmtpLiveModel.creator.portrait;
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:LiveVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
