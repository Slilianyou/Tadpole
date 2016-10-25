//
//  SignVC.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/5/31.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "SignVC.h"
#import "SignView.h"
#import "Configure.h"


@interface SignVC ()<SignViewDelegate>
{
    SignView *_signView;
    NSDate *_today;
    NSArray *_plistDataArr;
    NSString *_filePath;
    NSString *_todayStr;
    
    UIButton *_addBtn;
    UIButton *_goldBtn;
    UIButton *_chargeBtn;
}
@end

@implementation SignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self change];
    
}
- (void)change
{
     _today = [[Configure sharedInstance]today];
    _plistDataArr = [[Configure sharedInstance]getPlistDataWithFileName:@"DaySign.plist"];
    _filePath = [[Configure sharedInstance]creatFilePathWithFileName:@"DaySign.plist"];
    _todayStr = [NSString stringWithFormat:@"%d-%02d-%d",_today.getYear,_today.getMonth,_today.getDay];
    static dispatch_once_t dayData;
        dispatch_once(&dayData, ^{
    
            [self currentMonthSignDetailForPerToday];
        });
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.title = @"日历签到";
    _signView = [[SignView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth)];
    _signView.delegate = self;
    _signView.currentDate = _today;
    [self.view addSubview:_signView];
    [_signView reloadView];
    
    
    
    // 补签
    // 按钮
    _addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    _addBtn.tag = 1000;
    [_addBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _addBtn.backgroundColor = [UIColor blueColor];
    _addBtn.alpha = 0.5;
    _addBtn.frame = CGRectMake(20 , _signView.bottom + 25 + 60, 40,  40);
    _addBtn.layer.cornerRadius = 20.0 / 2.0;
    _addBtn.layer.masksToBounds = YES;
    [self.view addSubview:_addBtn];
    
    // UILabel
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, _addBtn.bottom + 5, 100,20 )];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"补签";
    [self.view addSubview:label];
    _addBtn.center = CGPointMake(label.center.x, label.center.y - 15-20-5);
    
    // 金币
    _goldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _goldBtn.tag = 1001;
    [_goldBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_goldBtn setBackgroundImage:[UIImage imageNamed:@"Gold.png"] forState:UIControlStateNormal];
    _goldBtn.frame = CGRectMake(label.right + 30 , _signView.bottom + 25 + 60, 40,  40);
    _goldBtn.layer.cornerRadius = 20.0 / 2.0;
    _goldBtn.layer.masksToBounds = YES;
    [self.view addSubview:_goldBtn];
    
    // UILabel
    UILabel *goldMoney = [[UILabel alloc]initWithFrame:CGRectMake(label.right + 30, _goldBtn.bottom + 5, 100,20 )];
    goldMoney.backgroundColor = [UIColor whiteColor];
    goldMoney.textColor = [UIColor blackColor];
    goldMoney.textAlignment = NSTextAlignmentCenter;
    goldMoney.text = @"金币 ¥ 50";
    [self.view addSubview:goldMoney];
    _goldBtn.center = CGPointMake(goldMoney.center.x, goldMoney.center.y - 15-20-5);
    
    
    // 充值
    _chargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _chargeBtn.tag = 1002;
    [_chargeBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_chargeBtn setBackgroundImage:[UIImage imageNamed:@"charge.png"] forState:UIControlStateNormal];
    _chargeBtn.frame = CGRectMake(label.right + 30 , _signView.bottom + 25 + 60, 40,  40);
    _chargeBtn.backgroundColor = [UIColor cyanColor];
    _chargeBtn.layer.cornerRadius = 20.0 / 2.0;
    _chargeBtn.layer.masksToBounds = YES;
    [self.view addSubview:_chargeBtn];
    
    // UILabel
    UILabel *chargeLabel = [[UILabel alloc]initWithFrame:CGRectMake(goldMoney.right + 30, _chargeBtn.bottom + 5, 100,20 )];
    chargeLabel.backgroundColor = [UIColor whiteColor];
    chargeLabel.textColor = [UIColor blackColor];
    chargeLabel.textAlignment = NSTextAlignmentCenter;
    chargeLabel.text = @"更换背景图";
    [self.view addSubview:chargeLabel];
    _chargeBtn.center = CGPointMake(chargeLabel.center.x, chargeLabel.center.y - 15-20-5);
}
- (void)buttonClicked:(UIButton *)sender
{
    if (sender.tag == 1000) {
        //
    }
}
#pragma mark -- SignView的代理方法
- (void)SignViewSelectAtDateModel:(RLBaseDateModel *)dataModel
{
    NSLog(@"%@",NSHomeDirectory());
    _plistDataArr = [[Configure sharedInstance]getPlistDataWithFileName:@"DaySign.plist"];
    NSMutableArray *plistArr = [NSMutableArray arrayWithCapacity:0];
    if ([dataModel.year intValue] == _today.getYear &&[dataModel.month intValue] == _today.getMonth && [dataModel.day  intValue]== _today.getDay) {
        if (_plistDataArr.count) {
        for (NSDictionary * dict in _plistDataArr) {
            NSString *keyStr = [[dict allKeys]objectAtIndex:0];
            if ([keyStr isEqualToString:_todayStr]) {
                if ([[dict objectForKey:_todayStr] isEqualToString:@"NO"]) {
                    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",_todayStr, nil];
                    [plistArr addObject:dic];
                    continue;
                    
                }else if([[dict objectForKey:_todayStr] isEqualToString:@"YES"] ){
                    NSLog(@"今天已经签到过了！");
                    return;
                }

            }
            [plistArr addObject:dict];
        }
        } else {
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES",_todayStr, nil];
            [plistArr addObject:dic];
        }
        
        [plistArr writeToFile:_filePath atomically:YES];
        
        
    } 
    
//    static dispatch_once_t dayData;
//    dispatch_once(&dayData, ^{
//        
//        [self currentMonthSignDetailForPerToday];
//    });
    
    
}
- (void)SignViewScrollEndToDate:(RLBaseDateModel *)dataModel
{
}

#pragma mark ---CustomMethod
/**
 *  本月到今日为止的签到详情
 */
- (void)currentMonthSignDetailForPerToday
{
    NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:0];
    int theDay = [_today getDay];
    NSArray *arr = [[Configure sharedInstance]getPlistDataWithFileName:@"DaySign.plist"];
    if (arr.count) {
 
    for (int i = 1; i < theDay + 1; i++) {
        NSString *keyStr = [NSString stringWithFormat:@"%d-%02d-%d",[_today getYear],[_today getMonth],i];
        BOOL iskeySame = NO;
  
            for (NSDictionary *dic in arr) {
                iskeySame= [[[dic allKeys]objectAtIndex:0] isEqualToString:keyStr];
                if (iskeySame) {
                    break;
                }
            }
     
        
        if (iskeySame) {
            continue;
        }
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",keyStr, nil];
        [dataArr addObject:dict];
        
    }
        
    } else {
        for (int i = 1; i < theDay + 1; i++) {
            NSString *keyStr = [NSString stringWithFormat:@"%d-%02d-%d",[_today getYear],[_today getMonth],i];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",keyStr, nil];
            [dataArr addObject:dict];
            
        }

    }
   [dataArr addObjectsFromArray:arr];
   [dataArr writeToFile:_filePath atomically:YES];
     NSLog(@"%@",NSHomeDirectory());
 
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
