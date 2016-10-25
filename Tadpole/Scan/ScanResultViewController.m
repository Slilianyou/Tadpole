//
//  ScanResultViewController.m
//  EZhuiSu
//
//  Created by ss-iOS-LLY on 16/9/21.
//  Copyright © 2016年 Paiwogou@syscanit.com. All rights reserved.
//

#import "ScanResultViewController.h"
#import "StarRatingView.h"


@interface ScanResultViewController ()<StarRatingViewDelegate,UITextViewDelegate,UIWebViewDelegate>
{
    StarRatingView *_startView;
  
}
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UIWebView      *webview;
@property (nonatomic, strong) UILabel      *infoLabel;
@property (nonatomic, strong) UITextView   *textView;
@property (nonatomic, strong) UIButton     *evaluateBtn;
@property (nonatomic, strong) UIButton     *commitBtn;


@end

@implementation ScanResultViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    [self setRightBarItem];
}
- (void)setUpUI
{
    self.view.backgroundColor = [UIColor clearColor];
    self.view.opaque = NO;
    self.title = @"追溯信息";
    
//    self.myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    self.myScrollView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:self.myScrollView];
//    
//    // UILabel
//    self.infoLabel = [[UILabel alloc]init];
//    self.infoLabel.backgroundColor = [UIColor whiteColor];
//    self.infoLabel.textColor = [UIColor blackColor];
//    self.infoLabel.textAlignment = NSTextAlignmentLeft;
//    self.infoLabel.numberOfLines = 0;
//    [self.myScrollView addSubview:self.infoLabel];

    self.webview = [[UIWebView alloc]init] ;
    [self.view addSubview:self.webview] ;
    NSMutableURLRequest*req ;
    if(self.type == 1){
        req = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString: @"http://www.paiwogou.com/index.php"]] ;
        NSString *body = [NSString stringWithFormat:@"app=trace&act=index&str=%@",self.content] ;
        [req setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]] ;
        [req setHTTPMethod:@"POST"] ;
        
    }else if(self.type == 2){
        
        req = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://www.paiwogou.com/gm.php?cid=%@",self.content] ]] ;
        
    }else if(self.type == 3){
        self.title = @"溯源" ;
        req = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://www.paiwogou.com/gm.php?id=%@",self.content] ]] ;
    } else if (self.type == 10){
        self.title = @"QR码";
         req = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:self.content]];
    }
    
    [self.webview loadRequest:req] ;
    self.myScrollView.scrollEnabled = YES;
    self.webview.delegate = self;
    
    
//    //评价
//    _startView = [[StarRatingView alloc]initWithFrame:CGRectMake(0, 0, 125, 30) numberOfStar:5 touchEnable:YES];
//    _startView.delegate = self;
//    [_startView setCustomStarSize:CGSizeMake(25, 25)];
//    [_startView makeRatingView];
//    [self.myScrollView addSubview:_startView];
//    
//    self.evaluateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.evaluateBtn.backgroundColor = [UIColor clearColor];
//    [self.evaluateBtn setTitle:@"重新评价" forState:UIControlStateNormal];
//    [self.evaluateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    self.evaluateBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
//    [self.myScrollView addSubview:self.evaluateBtn];
//    
//    //评论
//    self.textView = [[UITextView alloc]init];
//    self.textView.backgroundColor = [UIColor whiteColor];
//    self.textView.layer.borderWidth = 1.f;
//    self.textView.delegate = self;
//    self.textView.font = [UIFont systemFontOfSize:18.f];
//    self.textView.text = @"对该商品评论或投诉";
//    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.textView.textAlignment =NSTextAlignmentLeft;
//    self.textView.textColor = [UIColor lightGrayColor];
//    [self.myScrollView addSubview:self.textView];
//    
//    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.commitBtn.backgroundColor = [UIColor clearColor];
//    [self.commitBtn setTitle:@"提交评论" forState:UIControlStateNormal];
//    [self.commitBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    self.commitBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
//    [self.myScrollView addSubview:self.commitBtn];
//    
//    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//    [self.myScrollView addGestureRecognizer:tapGes];
//    
//    //键盘通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillAppear) name:UIKeyboardWillShowNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillDisAppear) name:UIKeyboardWillHideNotification object:nil];
}
- (void)setRightBarItem
{
    UIButton *rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];;
    [rightBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(buttionClicked:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setFrame:CGRectMake(0,0,30, 30)];
    
    UIBarButtonItem *rightBtnItem =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    UIBarButtonItem *space =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    NSMutableArray *rightArr =[[NSMutableArray alloc]initWithObjects:space,rightBtnItem, nil];
    
    self.navigationItem.rightBarButtonItems =rightArr;
}

- (void)tapAction:(UITapGestureRecognizer *)sender
{
    [self.textView resignFirstResponder];
}
- (void)keyBoardWillAppear
{
    CGPoint point = self.myScrollView.contentOffset;
    point.y += 200;
    self.myScrollView.contentOffset = point;
    
}
- (void)keyBoardWillDisAppear
{
    self.myScrollView.contentOffset = CGPointZero;
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    NSString *contentStr = @"产品追溯系统如何为企业造福？\n产品追溯系统的品牌保护、防伪打假最有效的解决方案。无论是从对市场反应速度、还是连接零售终端、物流追踪、经销渠道掌控来说，产品追溯都起到了举足轻重的作用。\n1、对市场反应快，问题产品精准召回\n举个例子，一旦产品出现问题，通过产品追溯系统，可精确查找到哪个环节有无窜货、责任人是谁都一清二楚，并可快速精准追溯、召回处理问题产品。\n2、追溯到每个环节，物流全过程追踪、防窜货\n追溯系统赋予产品上一个二维码，一品一码，产品出入库都必须扫描，目前正流向哪个区域、由哪个人负责运输管理、正规流通过程需要多长时间，企业一目了然。\n3、连接零售终端消费者、扫描可追溯\n用户购买时，可以直接微信扫码产品包装上的二维码防伪查询，还可追溯产品一系列详情信息，包括从生产、包装、仓储、经销商全环节的详情，这样的信息透明化，更有利于增强消费者的信任度，让用户百分百相信你的产品就是真品。\n事实上，315防伪一直从事防伪、防窜货、产品追溯事业，上文所提到的产品追溯系统，早在2013年已经推出，目前已经为多个食品商家建设二维码防伪追溯体系。\n产品追溯系统，咨询400-0402-365.\n";
//    CGSize size = [contentStr boundingRectWithSize:CGSizeMake(kScreenWidth - 20, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15.f]} context:nil].size;
//    _infoLabel.frame = CGRectMake(10, 5, size.width,size.height );
//    [_infoLabel sizeToFit];
//    _infoLabel.text = contentStr;
//    _infoLabel.hidden = YES;
//    

//    //
//    _startView.frame = CGRectMake(0, 0, 125, 30);
//    _startView.center = CGPointMake(kScreenWidth /2.0, CGRectGetMaxY( self.webview.frame) + CGRectGetHeight(_startView.frame) / 2.f + 25);
//    
//    self.evaluateBtn.frame = CGRectMake(CGRectGetMaxX(_startView.frame) + 10, CGRectGetMaxY(_startView.frame) - 25, 80, 25);
//    self.evaluateBtn.layer.cornerRadius = 8.f;
//    self.evaluateBtn.layer.masksToBounds = YES;
//    self.evaluateBtn.layer.borderWidth = 1.f;
//    self.evaluateBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    
//    
//    self.textView.frame = CGRectMake(20, CGRectGetMaxY(_startView.frame) + 10, kScreenWidth - 20 *2, 100);
//    
//    
//    self.commitBtn.frame = CGRectMake(0, 0, 200, 30);
//    self.commitBtn.center = CGPointMake(kScreenWidth / 2.0, CGRectGetMaxY(self.textView.frame) + 20);
//    self.commitBtn.layer.cornerRadius = 8.f;
//    self.commitBtn.layer.masksToBounds = YES;
//    self.commitBtn.layer.borderWidth = 1.f;
//    self.commitBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    
//    [self.myScrollView setContentSize:CGSizeMake(kScreenWidth, CGRectGetMaxY(_commitBtn.frame) + 64 + 20)];
        self.webview.frame = CGRectMake(0, 0, kScreenWidth , kScreenHeight);
}
- (void)buttionClicked:(UIButton *)sender
{
    NSLog(@"收藏");
}
-(void)starRatingView:(StarRatingView *)view score:(float)score
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //[self creatHud] ;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
   // [self dissmissHudWithMessage:error.localizedDescription] ;
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[self dissmissHud] ;
}

#pragma mark --TextViewDelegate
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}

@end
