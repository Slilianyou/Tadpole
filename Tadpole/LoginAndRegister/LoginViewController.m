//
//  LoginViewController.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/1/7.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "LoginViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "AppDelegate.h"
#import "ShowAlertView.h"
#import "KeychainItemWrapper.h"
#import "MyInfoViewController.h"
#import "SettingViewController.h"

//
#import "RegisterViewController.h"
#import "VerticalBtn.h"

#define userName @"lilianyou"

@interface LoginViewController ()<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITextField *_nameField;
    UITextField *_passwordField;
    KeychainItemWrapper *_keychainWrapper;
    UIView * _backView;
   
 
}
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *touchIdBtn;
@property (nonatomic, strong) UIView *userImagebackView;
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation LoginViewController
#pragma mark - UIAlertViewDelegate

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//}
#pragma mark - UITextFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
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
        cell.imageView.image = [UIImage imageNamed:@"shoucang.png"];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        cell.textLabel.text = @"收藏";
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
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [_nameField resignFirstResponder];
    [_passwordField resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.layer.contents = (id)[UIImage imageNamed:@"User_default_LoginBack"].CGImage;
    [self addBtnItem];
    [self setupUI];
//    [self addData];
//    [self addLogin];
   
}

- (void)setupUI
{
    CGFloat kMargin = 10;
    CGFloat w = (kScreenWidth - 2*kMargin*4) / 4.f;
    //模糊视图
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.view.bounds;
    [self.view addSubview:effectView];
    
    // 返回
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.tag = 1000;
    cancleBtn.frame = CGRectMake( 25 , 35, 30,  30);
    cancleBtn.backgroundColor = [UIColor clearColor];
    cancleBtn.showsTouchWhenHighlighted = YES;
    [cancleBtn setImage:[UIImage imageNamed:@"present_back@2x.png"] forState:UIControlStateNormal];
    cancleBtn.layer.cornerRadius =  CGRectGetWidth(cancleBtn.frame) / 2.0;
    cancleBtn.layer.masksToBounds = YES;
    [cancleBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [effectView addSubview:cancleBtn];
    // 注册
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    registerBtn.tag = 1001;
    registerBtn.frame = CGRectMake(kScreenWidth - 75 , 35, 50,  30);
    registerBtn.backgroundColor = [UIColor redColor];
    registerBtn.showsTouchWhenHighlighted = YES;
    registerBtn.layer.shadowOpacity = YES;
    registerBtn.layer.shadowRadius = 4;
    registerBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    registerBtn.layer.shadowOffset = CGSizeMake(0, 0);
    [registerBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [effectView addSubview:registerBtn];

    // 账号
    _nameField = [[UITextField alloc]init];
    _nameField.frame = CGRectMake(0, 100, kScreenWidth , 50);
    _nameField.textAlignment = NSTextAlignmentCenter;
    _nameField.backgroundColor = [UIColor whiteColor];
    _nameField.alpha = 0.6;
    _nameField.placeholder = @"账号/手机号码";
    _nameField.delegate = self;
    [effectView addSubview:_nameField];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor whiteColor];
    line.frame = CGRectMake(0, CGRectGetMaxY(_nameField.frame), kScreenWidth , 1);
    [effectView addSubview:line];
    
    // 密码
    _passwordField = [[UITextField alloc]init];
    _passwordField.frame = CGRectMake(0, CGRectGetMaxY(line.frame), kScreenWidth , 50);
    _passwordField.textAlignment = NSTextAlignmentCenter;
    _passwordField.backgroundColor = [UIColor whiteColor];
    _passwordField.alpha = 0.6;
    _passwordField.placeholder = @"密码";
    _passwordField.secureTextEntry = YES;
    _passwordField.delegate = self;
    [effectView addSubview:_passwordField];
    
    // 登录按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setTitle:@"密码登陆" forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.backgroundColor = [UIColor redColor];
    self.loginBtn.frame = CGRectMake(0 , 0, 100,  40);
    self.loginBtn.center = CGPointMake(kScreenWidth / 3.0, CGRectGetMaxY(_passwordField.frame) + 40);
    [effectView addSubview:self.loginBtn];
    
    // 按钮
    self.touchIdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.touchIdBtn.tag = touchIdBtnTag ;
    [self.touchIdBtn setTitle:@"指纹登录" forState:UIControlStateNormal];
    [self.touchIdBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.touchIdBtn.backgroundColor = [UIColor redColor];
    self.touchIdBtn.frame = CGRectMake(0 , 0, 100,  40);
    self.touchIdBtn.center = CGPointMake(kScreenWidth * 2/ 3.0, CGRectGetMaxY(_passwordField.frame) + 40);
    [effectView addSubview:self.touchIdBtn];
    
    // 忘记密码
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.tag = forgetBtnTag;
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setTitleFont:[UIFont systemFontOfSize:14.f]];
    forgetBtn.backgroundColor = [UIColor redColor];
    
    [forgetBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    forgetBtn.frame = CGRectMake(kScreenWidth - 120 , CGRectGetMaxY(self.loginBtn.frame) + 10, 100,  30);
    [effectView addSubview:forgetBtn];

    // 三方登陆
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(kScreenWidth / 2.f, kScreenHeight - 20 - w - 40);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"第三方登录";
    [effectView addSubview:titleLabel];
    
    // 线
    CGFloat lineWidth = (kScreenWidth - 10 *2 - 10 *3 - CGRectGetWidth(titleLabel.frame)) / 2.f;
    UIView *leftThirdline = [[UIView  alloc]initWithFrame:CGRectMake(10, kScreenHeight - 20 - w - 40, lineWidth , 1)];
      leftThirdline.alpha = 0.6;
    leftThirdline.backgroundColor = [UIColor whiteColor];
    [effectView addSubview:leftThirdline];

    UIView *rightThirdline = [[UIView  alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + 15, kScreenHeight - 20 - w - 40, lineWidth , 1)];
    rightThirdline.alpha = 0.6;
    rightThirdline.backgroundColor = [UIColor whiteColor];
    [effectView addSubview:rightThirdline];
    
    // QQ,微信，新浪，，腾讯
    VerticalBtn *wxBtn = [[VerticalBtn alloc]initWithFrame:CGRectMake( kMargin ,kScreenHeight - 20 - w, w,  w)];
    wxBtn.tag = 1002;
    wxBtn.backgroundColor = [UIColor clearColor];
    [wxBtn setTitle:@"微信登录" forState:UIControlStateNormal];
    [wxBtn setImage:[UIImage imageNamed:@"weixin@2x.png"] forState:UIControlStateNormal];
    [wxBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [wxBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [effectView addSubview:wxBtn];
    
    //QQ
    VerticalBtn *qqBtn = [[VerticalBtn alloc]initWithFrame:CGRectMake( kMargin * 3 + w ,kScreenHeight - 20 - w, w,  w)];
    qqBtn.tag = 1003;
    qqBtn.backgroundColor = [UIColor clearColor];
    [qqBtn setTitle:@"QQ登录" forState:UIControlStateNormal];
    [qqBtn setImage:[UIImage imageNamed:@"qq@2x.png"] forState:UIControlStateNormal];
    [qqBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [qqBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [effectView addSubview:qqBtn];
    
    //新浪xinLangWeiBo@2x.png
    VerticalBtn *xinLangWeiBoBtn = [[VerticalBtn alloc]initWithFrame:CGRectMake( kMargin * 5 + w*2 ,kScreenHeight - 20 - w, w,  w)];
    xinLangWeiBoBtn.tag = 1004;
    xinLangWeiBoBtn.backgroundColor = [UIColor clearColor];
    [xinLangWeiBoBtn setTitle:@"新浪微博" forState:UIControlStateNormal];
    [xinLangWeiBoBtn setImage:[UIImage imageNamed:@"xinLangWeiBo@2x.png"] forState:UIControlStateNormal];
    [xinLangWeiBoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [xinLangWeiBoBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [effectView addSubview:xinLangWeiBoBtn];
    //新浪xinLangWeiBo@2x.png
    VerticalBtn *tengXunWeiBoBtn = [[VerticalBtn alloc]initWithFrame:CGRectMake( kMargin * 7 + w *3 ,kScreenHeight - 20 - w, w,  w)];
    tengXunWeiBoBtn.tag = 1004;
    tengXunWeiBoBtn.backgroundColor = [UIColor clearColor];
    [tengXunWeiBoBtn setTitle:@"腾讯微博" forState:UIControlStateNormal];
    [tengXunWeiBoBtn setImage:[UIImage imageNamed:@"tengXunWeiBo@2x.png"] forState:UIControlStateNormal];
    [tengXunWeiBoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tengXunWeiBoBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [effectView addSubview:tengXunWeiBoBtn];
}

//- (UIButton *)creatBtnWithFrame:(CGRect)rect withTitle:(NSString *)title withTag:(NSInteger)tag  withImage:(UIImage *)image 
//{
//    VerticalBtn *wxBtn = [[VerticalBtn alloc]initWithFrame:CGRectMake( kMargin ,kScreenHeight - 20 - w, w,  w)];
//    wxBtn.tag = 1002;
//    wxBtn.backgroundColor = [UIColor clearColor];
//    [wxBtn setTitle:@"微信登录" forState:UIControlStateNormal];
//    [wxBtn setImage:[UIImage imageNamed:@"weixin@2x.png"] forState:UIControlStateNormal];
//    [wxBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [wxBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [effectView addSubview:wxBtn];
//}

#pragma  mark -- Method
- (void)addData
{
    //
    _keychainWrapper = [[KeychainItemWrapper alloc]initWithIdentifier:@"Myappstring" accessGroup:nil];
}

#pragma mark - Login
- (void)addLogin
{
    self.navigationItem.rightBarButtonItem.customView.hidden = YES;
    // backgroundView;
    _backView = [[UIView alloc]initWithFrame:self.view.bounds];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    
    
    // 账号
    _nameField = [[UITextField alloc]init];
    _nameField.frame = CGRectMake(30, 100, kScreenWidth - 60, 50);
    _nameField.textAlignment = NSTextAlignmentCenter;
    _nameField.backgroundColor = [UIColor lightGrayColor];
    _nameField.placeholder = @"账号/手机号码";
    _nameField.delegate = self;
    [_backView addSubview:_nameField];
    
    // 密码
    _passwordField = [[UITextField alloc]init];
    _passwordField.frame = CGRectMake(30, 170, kScreenWidth - 60, 50);
    _passwordField.textAlignment = NSTextAlignmentCenter;
    _passwordField.backgroundColor = [UIColor lightGrayColor];
    _passwordField.placeholder = @"密码";
    _passwordField.secureTextEntry = YES;
    _passwordField.delegate = self;
    [_backView addSubview:_passwordField];
    
    // 登录按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.backgroundColor = [UIColor redColor];
    self.loginBtn.frame = CGRectMake(0 , 0, 100,  40);
    self.loginBtn.center = CGPointMake(kScreenWidth / 3.0, CGRectGetMaxY(_passwordField.frame) + 40);
    [_backView addSubview:self.loginBtn];
    
    // 按钮
    self.touchIdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.touchIdBtn.tag = touchIdBtnTag ;
    [self.touchIdBtn setTitle:@"指纹登录" forState:UIControlStateNormal];
    [self.touchIdBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.touchIdBtn.backgroundColor = [UIColor redColor];
    self.touchIdBtn.frame = CGRectMake(0 , 0, 100,  40);
    self.touchIdBtn.center = CGPointMake(kScreenWidth * 2/ 3.0, CGRectGetMaxY(_passwordField.frame) + 40);
    [_backView addSubview:self.touchIdBtn];
    
    // 忘记密码
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.tag = forgetBtnTag;
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetBtn.backgroundColor = [UIColor redColor];
    
    [forgetBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    forgetBtn.frame = CGRectMake(kScreenWidth - 120 , CGRectGetMaxY(self.loginBtn.frame) + 5, 100,  40);
    
    [_backView addSubview:forgetBtn];
    
    
    //
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    // 1.
    BOOL hasLogin = [def objectForKey:@"hasLoginKey"];
    // 2.
    if (hasLogin) {
        self.navigationItem.rightBarButtonItem.customView.hidden = NO;
        [self AddOutLoginView];
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        self.loginBtn.tag = loginBtnTag;
    } else {
        
        if (![def objectForKey:@"createBtnTag"]) {
            [self.loginBtn setTitle:@"创建" forState:UIControlStateNormal];
            self.loginBtn.tag = createBtnTag;
        } else {
            [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
            self.loginBtn.tag = loginBtnTag;
            if ([def objectForKey:@"isLogin"]) {
                [self AddOutLoginView];
            }
        }
        
    }
    
    // 3.
    _nameField.text = [def objectForKey:@"username"];
    
}
#pragma mark - WoDe
- (void)AddOutLoginView
{
    _backView.hidden = YES;
    
    // 用户头像和名字
    [self addUserImageView];
    [self addUserAppInfo];
    
    
}
- (void)addUserAppInfo
{
    self.navigationItem.rightBarButtonItem.customView.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 + 120,kScreenWidth, kScreenHeight - 64 - 120) style:UITableViewStylePlain];
    self.myTableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleWidth;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.opaque = NO;
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.backgroundView = nil;
    self.myTableView.separatorColor = UITableViewCellSeparatorStyleNone;
    self.myTableView.bounces = NO;
    [self.view addSubview:self.myTableView];
    
    // backgroundView;
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    self.myTableView.tableFooterView = backView;
    
    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.myTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.myTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)addUserImageView
{
    self.title = @"我的";
    // 个人信息
    self.userImagebackView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 120)];
    self.userImagebackView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.userImagebackView];

    // UIImageView
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 80, 80)];
    imageView.userInteractionEnabled = YES;
    imageView.layer.cornerRadius = 40.f;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderWidth = 1.f;
    imageView.layer.borderColor = [[UIColor greenColor]CGColor];
    imageView.image = [UIImage imageNamed:@"profile.jpeg"];
    [self.userImagebackView addSubview:imageView];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myInfo)];
    [imageView addGestureRecognizer:tapGes];
    
    
    // 按钮
    UIButton *outLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    outLoginBtn.layer.cornerRadius = 2.f;
    outLoginBtn.layer.masksToBounds = YES;
    outLoginBtn.tag = outBtnTag;
    [outLoginBtn setTitle:@"out" forState:UIControlStateNormal];
    [outLoginBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    outLoginBtn.backgroundColor = [UIColor redColor];
    outLoginBtn.frame = CGRectMake(kScreenWidth - 75 , 85, 70, 30);
    [self.userImagebackView addSubview:outLoginBtn];
    
    // UILabel
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 15, 40, 100,40 )];
    //    label.backgroundColor = [UIColor redColor];
    label.textColor = [UIColor whiteColor];
    label.text = @"用户名称";
    label.textAlignment = NSTextAlignmentCenter;
    [self.userImagebackView addSubview:label];
}
- (void)myInfo
{
    MyInfoViewController *myInfoVC = [[MyInfoViewController alloc]init];
    [self.navigationController pushViewController:myInfoVC animated:YES];
}
- (void)addBtnItem
{
    self.title = @"登录";
    // 按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0 , 0, 30, 30);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    //
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"注册" forState:UIControlStateNormal];
    [rightBtn setTitleFont:[UIFont systemFontOfSize:17.f]];
    [rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(presentRightMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(0 , 0,50,  30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
}

- (void)presentLeftMenuViewController:(id)sender
{
//    [self.sideMenuViewController presentLeftMenuViewController];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)presentRightMenuViewController:(id)sender
{
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];
}
- (BOOL)checkLogin
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    BOOL isFitName = [_nameField.text isEqualToString:[def objectForKey:@"username"]];
   _keychainWrapper = [[KeychainItemWrapper alloc]initWithIdentifier:@"Myappstring" accessGroup:nil];
    BOOL isFitPassword = [_passwordField.text isEqualToString:[_keychainWrapper objectForKey:(id)kSecValueData]];
    NSLog(@"%@",[_keychainWrapper objectForKey:(id)kSecValueData]);
    
    return isFitName && isFitPassword;
}

#pragma mark -BtnClick
- (void)buttonClicked:(UIButton *)sender
{
    switch (sender.tag) {
        case 1000:
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case 1001:
        {

            [self.navigationController pushViewController:[[RegisterViewController alloc]init]  animated:YES];
        }
            break;
        default:
            break;
    }
//    if (sender == self.loginBtn) {
//        if ([_nameField.text isEqualToString:@""] ||[_passwordField.text isEqualToString:@""]) {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码或用户名不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            return;
//        }
//        
//        // 2.
//        [_nameField resignFirstResponder];
//        [_passwordField resignFirstResponder];
//        
//        // 3.
//        if (self.loginBtn.tag == createBtnTag) {
//            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//            BOOL hasLoginKey = [def boolForKey:@"hasLoginKey"];
//            
//            // 4
//            if (hasLoginKey  == false) {
//                [def setValue:_nameField.text forKey:@"username"];
//            }
//           
//            // 5
//            [_keychainWrapper setObject:@"Myappstring" forKey: (id)kSecAttrService];
//            [_keychainWrapper setObject:_nameField.text forKey:(id)kSecAttrAccount];
//            [_keychainWrapper setObject:_passwordField.text forKey:(id)kSecValueData];
//            
//            [def setBool:true forKey:@"hasLoginKey"];
//            [def setBool:YES forKey:@"isFinishedLogin"];
//            [def setObject:@"Yes" forKey:@"isLogin"];
//            [def setObject:@"cj" forKey:@"createBtnTag"];
//            [def synchronize];
//            
//            _passwordField.text = nil;
//            self.loginBtn.tag = loginBtnTag;
//            [self presentLeftMenuViewController:nil];
//        } else if (self.loginBtn.tag == loginBtnTag){
//            if ([self checkLogin]) {
//                NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//                [def setObject:@"Yes" forKey:@"isLogin"];
//                [def synchronize];
//                 _backView.hidden = YES;
//                [self addUserImageView];
//                [self addUserAppInfo];
//                _passwordField.text = nil;
//                [self presentLeftMenuViewController:nil];
//            }else {
//                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Login Problem" message:@"Wrong username or password" delegate:nil cancelButtonTitle:@"sure" otherButtonTitles:nil, nil];
//                [alertView show];
//            }
//        }
//
//    } else if (sender == self.touchIdBtn){
//        [self authenticateUser];
//    } else if (sender.tag == outBtnTag){
//        self.navigationItem.rightBarButtonItem.customView.hidden = YES;
//        _backView.hidden = NO;
//        [self.userImagebackView removeFromSuperview];
//        self.myTableView.delegate = nil;
//        self.myTableView.dataSource = nil;
//        [self.myTableView removeFromSuperview];
//        
//        sender.hidden = YES;
//        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//        [def removeObjectForKey:@"isLogin"];
//        [def removeObjectForKey:@"hasLoginKey"];
//        [def synchronize];
//        [self presentLeftMenuViewController:nil];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)authenticateUser
{
    // 初始化上下文对象
    LAContext *context = [[LAContext alloc]init];
    NSError *error;
    NSString *result = @"按手印";
    
    // 首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
            
                [APPDELEGATE.tbc setSelectedIndex:2];
              NSLog(@"%dafafafgagfasgagagadsaga",success);
//                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            
            }
            else
            {
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"Authentication was cancelled by the system");
                        //切换到其他APP，系统取消验证Touch ID

                        break;
                     }
                      case LAErrorUserCancel:
                    {
                        NSLog(@"Authentication was cancelled by the user");
                        //用户取消验证Touch ID
                        break;
                    }
                        case LAErrorUserFallback:
                    {
                         NSLog(@"User selected to enter custom password");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                             //用户选择输入密码，切换主线程处理
                        }];
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                            //其他情况，切换主线程处理
                        }];
                    }
                        break;
                }
            }
                
                
        }];
        
    }
    else
    {
      //不支持指纹识别，LOG出错误详情
        //不支持指纹识别，LOG出错误详情
        
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
    }

}
@end
