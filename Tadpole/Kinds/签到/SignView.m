//
//  SignView.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/5/31.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "SignView.h"
#import "Configure.h"

CATransform3D CATransform3DMakePerspective (CGPoint center,float disZ){
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}
@interface SignView ()<UIScrollViewDelegate>
{
    // 星期
    UIView *_headView;
    // 日历的展示
    UIView *_bodyViewL;
    UIView *_bodyViewM;
    UIView *_bodyViewR;
    
    // 滑动功能的支持
    UIScrollView *_scrollView;
    NSDate *_today;
    RLBaseDateModel *_selectModel;
    
    // 日期
    UILabel *_titleLabel;
    NSString *_selectModelStr;
}
@end


@implementation SignView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


- (void)reloadView
{
    self.backgroundColor = [UIColor whiteColor];
    _today = [[Configure sharedInstance]today];
    _currentDate = [[Configure sharedInstance]today];
    
    _selectModel = [[RLBaseDateModel alloc]init];
    _selectModel.year = [NSString stringWithFormat:@"%d",[_today getYear]];
    _selectModel.month = [NSString stringWithFormat:@"%d",[_today getMonth]];
    _selectModel.day = [NSString stringWithFormat:@"%d",[_today getDay]];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    _titleLabel.textColor = [UIColor orangeColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = [[NSString stringWithFormat:@"%@",_today ] substringToIndex:19];
    [self addSubview:_titleLabel];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30*2, self.frame.size.width, self.frame.size.height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(3 *self.frame.size.width, 0);
    _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    _bodyViewL = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    [_scrollView addSubview:_bodyViewL];
    
    _bodyViewM = [[UIView alloc]initWithFrame:CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    _bodyViewM.backgroundColor = [UIColor clearColor];
    _bodyViewM.layer.contents = (id)[UIImage imageNamed:@"Calender"].CGImage;
    _bodyViewM.layer.contentsGravity = kCAGravityResizeAspectFill;
    [_scrollView addSubview:_bodyViewM];
    
    _bodyViewR = [[UIView alloc]initWithFrame:CGRectMake(_scrollView.frame.size.width *2, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    [_scrollView addSubview:_bodyViewR];
    
    // 展示星期
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0,30, self.frame.size.width, 30)];
    _headView.backgroundColor = [UIColor redColor];
    NSArray *weekArray = @[@"SUN",@"MON",@"TUES",@"WED",@"THUR",@"FRI",@"SAT"];
    
    for (int i = 0; i < 7; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 7.0 * i, 0, self.frame.size.width / 7.0, 30)];
        if (i!=0 &&i!= 6) {
            label.backgroundColor = [UIColor redColor];
        }else {
            label.backgroundColor = [UIColor purpleColor];
        }
        label.text = weekArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.borderWidth = 1;
        label.layer.borderColor = [UIColor grayColor].CGColor;
        label.textColor = [UIColor whiteColor];
        [_headView addSubview:label];
    }
    
    [self addSubview:_headView];
    
    _filePath = [[Configure sharedInstance]creatFilePathWithFileName:@"DaySign.plist"];
     _markArray = [NSArray arrayWithContentsOfFile:_filePath];
    _plistArr = [[Configure sharedInstance]getPlistDataWithFileName:@"DaySign.plist"];

    [self creatViewWithData:_currentDate onView:_bodyViewM];
    [self creatViewWithData:[RLBaseDateTools getPreviousMonthframDate:_currentDate] onView:_bodyViewL];
    [self creatViewWithData:[RLBaseDateTools getNextMonthframDate:_currentDate] onView:_bodyViewR];
    
}

// 核心的构造方法
- (void)creatViewWithData:(id)data onView:(UIView *)bodyView
{
    
    NSDate *currentDate = (NSDate *)data;
    int monthNum = [currentDate YHBaseNumberOfDaysInCurrentMonth];
    //本月第一天
    NSDate *firstDate = [currentDate YHBaseFirstDayOfCurrentMonth];
    //周几？？
    int weekday = [firstDate YHBaseWeekly];
    //    int weekRow = [self createCalenderRowWithMonths:monthNum with:weekday];
    
#warning 可以优化_________这里的逻辑是有问题的，应该设计成cell的复用机制，而不应该重复耗性能的创建 有时间在优化
    NSArray *array = [bodyView subviews];
    for (UIView * v in array) {
        [v removeFromSuperview];
    }
    int nextDate = 1;
    for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 7; j++) {
            // 先进行上个月余天的创建
            UIButton *btn;
            if (weekday != 1 && (i *7 + j) < weekday - 1) {
                // 获取上个月有多少天
                // 上个月的最后一天
                @autoreleasepool {
                    
                    NSTimeInterval oneDay = 24*60*60*1; // 1天的长度
                    NSDate * preDate = [firstDate dateByAddingTimeInterval:-oneDay];
                    int preDays = [preDate YHBaseNumberOfDaysInCurrentMonth];
                    
                    btn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/7.0 *j, self.frame.size.width/7.0 *i, self.frame.size.width /7.0, self.frame.size.width/7.0)];
                    [btn setTitle:[NSString stringWithFormat:@"%d",preDays - weekday + j + 1 + 1 ] forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                    [btn setBackgroundColor:[UIColor clearColor]];
                    [bodyView addSubview:btn];
                    
                }
            }
            else if ((i *7 +j + 1 + 1 - (weekday == 1 ? 1 :weekday))<= monthNum ) {
                @autoreleasepool {
                    
                    btn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/7*j, self.frame.size.width/7*i, self.frame.size.width/7, self.frame.size.width/7)];
                    [btn setTitle:[NSString stringWithFormat:@"%d",(i*7+j+1 + 1 -(weekday==1?1:weekday))] forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [btn setBackgroundColor:[UIColor clearColor]];
                    [bodyView addSubview:btn];
                }
            }  else {
                @autoreleasepool {
                    
                    btn =[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/7*j, self.frame.size.width/7*i, self.frame.size.width/7, self.frame.size.width/7)];
                    [btn setTitle:[NSString stringWithFormat:@"%d",nextDate++] forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                    [btn setBackgroundColor:[UIColor clearColor]];
                    [bodyView addSubview:btn];
                }
            }
            
            //将今天的日期标出
            if ([currentDate getYear]==[_today getYear]&&[currentDate getMonth]==[_today getMonth]&&[btn.titleLabel.text intValue]==[_today getDay]&&!CGColorEqualToColor([btn.titleLabel.textColor CGColor], [[UIColor grayColor] CGColor])) {
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                NSLog(@"%d-----------%d",[_today getDay],[btn.titleLabel.text intValue]);
            }
         
            
            
            //  是否进行自定义标记__if中的颜色比较 是为了让上月与下月的余日不产生bug
            static NSInteger a =0;
            if (_markArray!=nil) {
                for (int i=0; i<_markArray.count; i++) {
                    
                    a ++;
                    NSLog(@"ahkghajk++++++++++%d",a);
                    @autoreleasepool {
                        
                        NSDictionary *dict =_markArray[i];
                        NSString *keyStr = [[dict allKeys]objectAtIndex:0];
                        NSArray *components = [keyStr componentsSeparatedByString:@"-"];
                        RLBaseDateModel * model = [[RLBaseDateModel alloc]init];
                        model.year = [components firstObject];
                        model.month = [components objectAtIndex:1];
                        model.day = [components lastObject];
                        
                        if ([_currentDate getYear]  ==[model.year intValue]&&[_currentDate getMonth]==[model.month intValue]&& [model.day intValue] ==[btn.titleLabel.text intValue]&&!CGColorEqualToColor([btn.titleLabel.textColor CGColor], [[UIColor grayColor] CGColor])){
                            if ([[dict objectForKey:keyStr] isEqualToString:@"YES"]) {
                                
                                if ([_today getDay] == [btn.titleLabel.text intValue]) {
                                  //[self configCellForSign:YES atSender:btn];
                                    [btn setBackgroundImage:[UIImage imageNamed:@"dailysign_bk_sign"] forState:UIControlStateNormal];
                                } else {
                                    [btn setBackgroundImage:[UIImage imageNamed:@"dailysign_bk_sign"] forState:UIControlStateNormal];
                                }
                                
                               
                            } else if ([[dict objectForKey:keyStr] isEqualToString:@"NO"]){
                                [btn setBackgroundImage:[UIImage imageNamed:@"dailysign_bk_no_sign"] forState:UIControlStateNormal];
                                btn.backgroundColor = [UIColor redColor];
                            }
                            
                            btn.layer.borderColor = [[UIColor grayColor]CGColor];
                            btn.layer.borderWidth=1;
                           // btn.userInteractionEnabled = NO;
                        }
                    }
                }
            }
            
           
            if ([_selectModel.year intValue]==[currentDate getYear]&&[_selectModel.month intValue]==[currentDate getMonth]&&[_selectModel.day intValue]==[btn.titleLabel.text intValue]&&!CGColorEqualToColor([btn.titleLabel.textColor CGColor], [[UIColor grayColor] CGColor])) {
               
                if ([_selectModel.day intValue] > [_today getDay]) {
                    btn.backgroundColor = [UIColor cyanColor];
                } else {
                    for (NSDictionary * dic  in _plistArr) {
                         NSString *keyStr = [[dic allKeys]objectAtIndex:0];
                        if ([keyStr isEqualToString:_selectModelStr]) {
                            if ([[dic objectForKey:keyStr] isEqualToString:@"YES"]) {
                                [self configCellForSign:YES atSender:btn];
                            }else if ([[dic objectForKey:keyStr] isEqualToString:@"NO"]){
                                NSLog(@"agjkhhfjkdstgjhioejthiosdhjieos");
                                [self configCellForSign:NO atSender:btn];
                                
                            }

                        }
                    }
                    

                }
                
            }
            
            //添加点击事件
            if (!CGColorEqualToColor([btn.titleLabel.textColor CGColor], [[UIColor grayColor] CGColor])) {
                
                [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            
        }
    }
    
}

- (void)configCellForSign:(BOOL)sign atSender:(UIButton *)sender
{
    if (sign)
    {
        // 配置正面
        // 首先复制一个完全一样的UIButton，然后作为前景
        NSData *viewData =  [NSKeyedArchiver archivedDataWithRootObject:sender];
        UIButton *noSign = [NSKeyedUnarchiver unarchiveObjectWithData:viewData];
        // 以上两句作用是完全复制一个现有的view
        
        // 设置未签到时候的颜色状态，背景等
        [noSign setBackgroundImage:[UIImage imageNamed:@"dailysign_bk_no_sign"] forState:UIControlStateNormal];
        //        UILabel *label = (UILabel*)[noSign viewWithTag:kScoreLableTagBegin + index];
        //        label.textColor = HEXCOLOR(0xefefef);
        //        label.shadowColor = HEXCOLOR(0xcccccc);
        //        label.shadowOffset = CGSizeMake(1, 1);
        //        [self.contentView addSubview:noSign];
        
        CATransform3D transloate = CATransform3DMakeTranslation(0, 0, 0);
        CATransform3D rotate0 = CATransform3DMakeRotation(0, 0, 1, 0);
        CATransform3D mat0 = CATransform3DConcat(rotate0, transloate);
        noSign.layer.transform = CATransform3DPerspect(mat0, CGPointMake(0, 0), 500);
        noSign.layer.doubleSided = NO;//不需要显示背面，这个注意
        
        //        // 开始配置背面
        //        label = [self getScoreLableAtIndex:index];
        //        label.textColor = HEXCOLOR(0xffaf00);
        //        label.shadowColor = nil;
        [sender setBackgroundImage:[UIImage imageNamed:@"dailysign_bk_sign"] forState:UIControlStateNormal];//背景
        
        CATransform3D transloate1 = CATransform3DMakeTranslation(0, 0, 0);
        CATransform3D rotate1 = CATransform3DMakeRotation(M_PI, 0, 1, 0);// 绕Y轴旋转180度，就是已签到的图变成反面然后和未签到的图合成为一张，分别作为特效图的正面和反面
        CATransform3D mat1 = CATransform3DConcat(rotate1, transloate1);
        sender.layer.transform = CATransform3DPerspect(mat1, CGPointMake(0, 0), 500);
        sender.layer.doubleSided = NO; // 不需要显示背面，这个注意
        
        
        [UIView animateWithDuration:0.8f animations:^{
            
            CATransform3D transloate0 = CATransform3DMakeTranslation(0, 0, 0);
            CATransform3D rotate0 = CATransform3DMakeRotation(M_PI, 0, 1, 0); //旋转180度将正面的未签到图转到背面
            CATransform3D mat0 = CATransform3DConcat(rotate0, transloate0);
            noSign.layer.transform = CATransform3DPerspect(mat0, CGPointMake(0, 0), 500);
            
            CATransform3D transloate1 = CATransform3DMakeTranslation(0, 0, 0);
            CATransform3D rotate1 = CATransform3DMakeRotation(M_PI*2, 0, 1, 0); //旋转到360度，也就是背面的已签到图转到正面
            CATransform3D mat1 = CATransform3DConcat(rotate1, transloate1);
            sender.layer.transform = CATransform3DPerspect(mat1, CGPointMake(0, 0), 500);
        } completion:^(BOOL finished) {
            [noSign removeFromSuperview]; // 临时复制出来的view销毁
        }];
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"dailysign_bk_no_sign"] forState:UIControlStateNormal];
        // UILabel *label = [self getScoreLableAtIndex:index];
        //        label.textColor = HEXCOLOR(0xefefef);
        //        label.shadowColor = HEXCOLOR(0xcccccc);
        //        label.shadowOffset = CGSizeMake(1, 1);
    }
    
}

//点击事件
-(void)clickBtn:(UIButton *)btn{
    _selectModel.year = [NSString stringWithFormat:@"%d",[_currentDate getYear]];
    _selectModel.month = [NSString stringWithFormat:@"%d",[_currentDate getMonth]];
    _selectModel.day = btn.titleLabel.text;
    
    if ([self.delegate respondsToSelector:@selector(SignViewSelectAtDateModel:)]) {
        [self.delegate SignViewSelectAtDateModel:_selectModel];
         _selectModelStr = [NSString stringWithFormat:@"%d-%02d-%d",[_selectModel.year intValue],[_selectModel.month intValue],[_selectModel.day intValue]];
      
     
        [self handleData];
    }
    
    [self creatViewWithData:_currentDate onView:_bodyViewM];
    [self creatViewWithData:[RLBaseDateTools getPreviousMonthframDate:_currentDate] onView:_bodyViewL];
    [self creatViewWithData:[RLBaseDateTools getNextMonthframDate:_currentDate] onView:_bodyViewR];
    
}

//这个方法中进行重构
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 0) {
        _currentDate = [RLBaseDateTools getPreviousMonthframDate:_currentDate];
        _scrollView.contentOffset = CGPointMake(scrollView.width, 0);
        [self creatViewWithData:_currentDate onView:_bodyViewM];
        [self creatViewWithData:[RLBaseDateTools getPreviousMonthframDate:_currentDate] onView:_bodyViewL];
        [self creatViewWithData:[RLBaseDateTools getNextMonthframDate:_currentDate] onView:_bodyViewR];
    } else if (_scrollView.contentOffset.x == scrollView.frame.size.width){
        
    }else if (_scrollView.contentOffset.x == scrollView.frame.size.width *2){
        _currentDate = [RLBaseDateTools getNextMonthframDate:_currentDate];
        _scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
        
        [self creatViewWithData:_currentDate onView:_bodyViewM];
        [self creatViewWithData:[RLBaseDateTools getPreviousMonthframDate:_currentDate] onView:_bodyViewL];
        [self creatViewWithData:[RLBaseDateTools getNextMonthframDate:_currentDate] onView:_bodyViewR];
        
    }
    
    scrollView.userInteractionEnabled = YES;
    
    if ([self.delegate respondsToSelector:@selector(SignViewScrollEndToDate:)]) {
        RLBaseDateModel *model = [[RLBaseDateModel alloc]init];
        model.year = [NSString stringWithFormat:@"%d",[_today getYear]];
        model.month = [NSString stringWithFormat:@"%d",[_today getMonth]];
        model.day = [NSString stringWithFormat:@"%d",[_today getDay]];
        [self.delegate SignViewScrollEndToDate:model];
    }
    
    _titleLabel.text = [NSString stringWithFormat:@"%@",_currentDate];
}

- (void)handleData
{
   
    if (!_todayStr) {
        _todayStr = [NSString stringWithFormat:@"%d-%02d-%d",_today.getYear,_today.getMonth,_today.getDay];
    }
    _markArray = [NSArray arrayWithContentsOfFile:_filePath];
    _plistArr = [[Configure sharedInstance]getPlistDataWithFileName:@"DaySign.plist"];
    
   
}

// 确定创建多少行
- (int)createCalenderRowWithMonths:(int)monthNum with:(int)weekday
{
    int weekRow = 0;
    int tmp = monthNum;
    if (weekday != 1) {
        weekRow ++;
        tmp = monthNum - (7 - weekday);
    }
    weekRow += tmp /7;
    weekRow += (tmp % 7)? 1 : 0;
    weekRow = 6;
    return weekRow;
    
}










@end
