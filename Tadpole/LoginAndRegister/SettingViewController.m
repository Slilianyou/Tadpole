//
//  SettingViewController.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/1/12.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "SettingViewController.h"
#import "MusicViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *myTableView;
@end

@implementation SettingViewController
#pragma mark - Delegate
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LoginCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoginCell"];
    }
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"yinyue.png"];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.textLabel.text = @"背景音乐";
    } else if (indexPath.row == 1){
        cell.imageView.image = [UIImage imageNamed:@"dizhi.png"];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.textLabel.text = @"地址";

    } else if (indexPath.row == 2){
        cell.imageView.image = [UIImage imageNamed:@"comiisfariji.png"];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.textLabel.text = @"日记";
    }else if (indexPath.row == 3){
        cell.imageView.image = [UIImage imageNamed:@"hongbao.png"];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.textLabel.text = @"红包";
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
//        MusicViewController *musciVC =  [[MusicViewController alloc]init];
//        musciVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:musciVC animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self addItem];
    [self addCustomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - AddCustomView
- (void)addCustomView
{
    // addTableView
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.myTableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleWidth;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.opaque = NO;
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.backgroundView = nil;
    self.myTableView.separatorColor = UITableViewCellSeparatorStyleNone;
    self.myTableView.bounces = NO;
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
#pragma mark - AddNavigationItem
- (void)addItem
{
    self.title = @"设置";
    // 按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 100;
    [btn setBackgroundImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    btn.frame = CGRectMake(0 , 0, 30,  30);
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barBtn;
}

#pragma mark - ButtonClicked
- (void)buttonClicked:(UIButton *)sender
{
    if (sender.tag == 100) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
