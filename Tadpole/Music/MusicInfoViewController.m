////
////  MusicInfoViewController.m
////  Tadpole
////
////  Created by ss-iOS-LLY on 16/1/14.
////  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
////
//
#import "MusicInfoViewController.h"
//#import "MIHeaderTableViewCell.h"
//#import "MIFooterTableViewCell.h"
//#import <AVFoundation/AVFoundation.h>
//#import "FMTracksModel.h"
//#import "TrackRoundVC.h"
//
//@interface MusicInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic, strong)UITableView *myTableView;
//@property (nonatomic, strong)NSDictionary *albumADict;
//@property (nonatomic, strong)NSMutableArray *tracKsArr;
//@end
//
@implementation MusicInfoViewController

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
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 2;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 0.1;
//    } else {
//        return 40;
//    }
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return nil;
//    }
//    // backgroundView;
//    UIView *backView = [[UIView alloc]init];
//    backView.frame = CGRectMake(0, 0, kScreenWidth, 36);
//    backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//
//    // UILabel
//    UILabel *label = [[UILabel alloc]init];
//    label.backgroundColor = [UIColor clearColor];
//    label.frame = CGRectMake(20, 2, 100, 36);
//    label.textColor = [UIColor lightGrayColor];
//    label.font = [UIFont systemFontOfSize:14.f];
//    label.text = [NSString stringWithFormat:@"共%d集",[[self.albumADict objectForKey:@"tracks" ]integerValue]];
//    label.textAlignment = NSTextAlignmentLeft;
//    [backView addSubview:label];
//    
//    // UIBtton
//    // 按钮
//    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
////    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [selectBtn setImage:[UIImage imageNamed:@"selectText.png"] forState:UIControlStateNormal];
//    [selectBtn setTitle:@"选集" forState:UIControlStateNormal];
//    [selectBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    selectBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
//    [selectBtn setImageEdgeInsets:UIEdgeInsetsMake(4, -2, 4, 0)];
//    [selectBtn setTitleEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 0)];
//    selectBtn.backgroundColor = [UIColor clearColor];
//    selectBtn.frame = CGRectMake(kScreenWidth - 150, 7, 70,  26);
//    [backView addSubview:selectBtn];
//    
////
//    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [orderBtn setImage:[UIImage imageNamed:@"order.png"] forState:UIControlStateNormal];
//    [orderBtn setTitle:@"排序" forState:UIControlStateNormal];
//    [orderBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    orderBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
//    [orderBtn setImageEdgeInsets:UIEdgeInsetsMake(4, 50, 4, 0)];
//    [orderBtn setTitleEdgeInsets:UIEdgeInsetsMake(2, -45, 2, 0)];
//    orderBtn.backgroundColor = [UIColor clearColor];
//    orderBtn.frame = CGRectMake(CGRectGetMaxX(selectBtn.frame) + 2, 7, 70,  26);
//    [backView addSubview:orderBtn];
//    
//    
//    return backView;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 1;
//    } else {
//        return [self.tracKsArr count] - 1;
//    }
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 0) {
//        return 160;
//    }else {
//        return 80;
//    }
//    
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section == 0) {
//        MIHeaderTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
//        if (!cell) {
//            cell = [[MIHeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HeaderCell"];
//        }
//        
//        if (self.tracKsArr.count) {
//       
//        [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:[self.albumADict objectForKey:@"coverLarge"]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//        cell.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.albumADict objectForKey:@"avatarPath"]]];
//        [cell.smallBtn setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
//        cell.smallLabel.text = [self.albumADict objectForKey:@"nickname"];
//        cell.introLabel.text = [self.albumADict objectForKey:@"intro"];
//        [cell.tagBtn  setTitle:@"电影｜原曲" forState:UIControlStateNormal];
//        }
//        return cell;
//        
//    } else {
//        
//        MIFooterTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FooderCell"];
//        if (!cell) {
//            cell = [[MIFooterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FooderCell"];
//        }
//        
//        FMTracksModel *fmTracksModel = [self.tracKsArr objectAtIndex:indexPath.row];
//        [cell.smallLogo sd_setImageWithURL:[NSURL URLWithString:fmTracksModel.coverLarge] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//        cell.smallLogo.contentMode = UIViewContentModeScaleAspectFit;
//        cell.titleLabel.text = fmTracksModel.title;
//        
//        [cell.playBtn addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        cell.playBtn.tag = indexPath.row;
//     
//        cell.nickNameLabel.text = [NSString stringWithFormat:@"by %@",fmTracksModel.nickname];
//        
//        return cell;
//        
//    }
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    FMTracksModel *trackModel = [self.tracKsArr objectAtIndex:indexPath.row];
//    TrackRoundVC *roundVC = [[TrackRoundVC alloc]init];
//    roundVC.tracksModel = trackModel;
//    [self.navigationController pushViewController:roundVC animated:YES];
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
//    [self addCustom];
//    self.albumADict = [[NSDictionary alloc]init];
//    self.tracKsArr = [[NSMutableArray alloc]init];
//    [self sendRequest];
}
//#pragma mak - Method
//- (void)addCustom
//{
//    // addTableView
//    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
//    self.myTableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleWidth;
//    self.myTableView.delegate = self;
//    self.myTableView.dataSource = self;
//    self.myTableView.opaque = NO;
//    self.myTableView.backgroundColor = [UIColor blackColor];
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
//    view.backgroundColor = [UIColor clearColor];
//    [self.myTableView setTableFooterView:view];
//    
//    [self.myTableView setContentInset:UIEdgeInsetsMake(0, 0, -49, 0)];
//    
//
//}
//#pragma mark - Method
//- (void)sendRequest
//{
//    NSString *str = @"http://mobile.ximalaya.com/mobile/others/ca/album/track/3183879/true/1/20?device=iPhone";
//    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [MyAFNetWork getGetResponeWithParameters:nil andUrlStr:str andBlock:^(id myAfNetBlockResponeDic) {
//        if ([[myAfNetBlockResponeDic objectForKey:@"msg"]isEqualToString:@"0"]) {
//            
//            self.albumADict = [myAfNetBlockResponeDic objectForKey:@"album"];
//            NSArray *arr = [[myAfNetBlockResponeDic objectForKey:@"tracks"] objectForKey:@"list"];
//            
//            // 对象数组
//            NSArray *arrDic = [FMTracksModel objectArrayWithKeyValuesArray:arr];
//            [self.tracKsArr addObjectsFromArray:arrDic];
//            
//            [self.myTableView reloadData];
//        }
//       
//    }];
//}
//
//- (void)addButtonClicked:(UIButton *)sender
//{
//    // 获取playBtn
//    UIView *view = nil;
//    self.fmTrackModel = [self.tracKsArr objectAtIndex:sender.tag];
//    [self playMusicWithTrackLink:self.fmTrackModel];
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//#pragma mark - PLayMusic
//- (void)playMusicWithTrackLink:(FMTracksModel *)model
//{
//    NSLog(@"%@",model.title);
//    
//    
//}


























@end
