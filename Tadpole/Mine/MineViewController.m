//
//  MineViewController.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/10/25.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "MineViewController.h"
#import "UserImageCell.h"
#import "OutLoginTableViewCell.h"
#import "LoginViewController.h"

//#import "AboutViewController.h"
//#import "HistoryViewController.h"
//#import "CollectionViewController.h"
//#import "SettingViewController.h"



@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImage * _protraitImg;
    NSString * _name;
}

@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation MineViewController

static NSString *userImageCell =@"UserImageCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    
}
- (void)setUpUI
{
    self.title = @"个人";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsHorizontalScrollIndicator = NO;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.opaque = NO;
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.backgroundView = nil;
    self.myTableView.separatorColor = UITableViewCellSeparatorStyleNone;
    //    self.myTableView.separatorStyle = UITableViewCellSelectionStyleNone;
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


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 5;
        case 1:
            return 10;
        default:
            return 10;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 3;
        case 2:
            return 1;
        default:
            return 1;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  indexPath.section ? 60.f : 140.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        UserImageCell *cell = [tableView dequeueReusableCellWithIdentifier:userImageCell];
        if (!cell) {
            cell = [[UserImageCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:userImageCell];
            cell.imageView.layer.cornerRadius = 5.f;
            cell.imageView.layer.masksToBounds = YES;
            
        }
        
        cell.imageView.image = (_protraitImg ? _protraitImg :[UIImage imageNamed:@"user_protrait_default@2x.png"]);
        cell.textLabel.text = @"立即登陆";
        cell.detailTextLabel.text = @"执法必严，违法必纠";
        if (_name) {
            cell.textLabel.text = _name;
        }
       
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 1) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CountCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CountCell"];
        }
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"about"];
            cell.textLabel.text = @"关于E追溯";
            
        } else if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"history.png"];
            cell.textLabel.text = @"历史记录";
        } else if (indexPath.row == 2){
            cell.imageView.image = [UIImage imageNamed:@"collect.png"];
            cell.textLabel.text = @"我的收藏";
        }
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else  if (indexPath.section == 2){
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"settingCell"];
        }
        
        cell.imageView.image = [UIImage imageNamed:@"setting.png"];
        cell.textLabel.text = @"设置";
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        OutLoginTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OutLoginTableViewCell"];
        if (!cell) {
            cell = [[OutLoginTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OutLoginTableViewCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        LoginViewController *loginVc = [[LoginViewController alloc]init];
        UINavigationController *loginNai = [[UINavigationController alloc]initWithRootViewController:loginVc];
        [loginNai setNavigationBarHidden:YES animated:YES];
        [self.navigationController presentViewController:loginNai animated:YES completion:nil];
    }
//    if (indexPath.section == 1) {
//        switch (indexPath.row) {
//            case 0:{
//                AboutViewController *aboutVC = [[AboutViewController alloc]init];
//                aboutVC.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:aboutVC animated:YES];
//            }
//                break;
//            case 1:{
//                HistoryViewController *historyVC = [[HistoryViewController alloc]init];
//                historyVC.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:historyVC animated:YES];
//            }
//                break;
//            case 2:{
//                CollectionViewController *collectionVC = [[CollectionViewController alloc]init];
//                collectionVC.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:collectionVC animated:YES];
//            }
//                break;
//            default:
//                break;
//        }
//    } else if (indexPath.section == 2){
//        SettingViewController *settingVc = [[SettingViewController alloc]init];
//        settingVc.delegate = self;
//        settingVc.hidesBottomBarWhenPushed = YES;
//        
//        
//        [self.navigationController pushViewController:settingVc animated:YES];
//    }
}

- (void)tapUserImageForChange
{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
