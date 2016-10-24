//
//  VoiceViewController.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/5/19.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "VoiceViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SharpLabel.h"

//
#import "IATConfig.h"
#import "ISRDataHelper.h"

@interface VoiceViewController ()<IFlySpeechRecognizerDelegate>
{
    CAShapeLayer  *arcLayer;
    SharpLabel * _sharpLabel;
    BOOL _isAnimation;
    BOOL _isPressButton;
    NSTimer *_time;
    UIView *_mainView;
    UIView *_backView;
    //
    UIImageView * _imageCircle1;
    
    //不带界面的识别对象
    IFlySpeechRecognizer *_iFlySpeechRecognizer;
    
}
@property (nonatomic, strong) UILabel *mainLabel;
@property (nonatomic, strong) UIButton *voiceBtn;

//
@property (nonatomic,strong)CALayer * layer1;
@property (nonatomic,strong)CALayer * layermin;
@property (nonatomic,strong)CALayer * layertime;

//语音
@property (nonatomic, strong) NSString  *pcmFilePath; //音频文件路径
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, assign) BOOL isCanceled;
@property (nonatomic, strong) NSString * result;
@end

@implementation VoiceViewController
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //demo录音文件保存路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    _pcmFilePath = [[NSString alloc]initWithFormat:@"%@",[cachePath stringByAppendingPathComponent:@"asr.pcm"]];
    [self initRecognizer];
    
    [self change];
}
- (void)change
{
    self.view.backgroundColor = [UIColor whiteColor];
    // backgroundView;
    _mainView = [[UIView alloc]initWithFrame:self.view.bounds];
    _mainView.hidden = NO;
    _mainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mainView];
    
    _backView = [[UIView alloc]initWithFrame:self.view.bounds];
    // 给图层添加背景图片
    _backView.layer.contents =(__bridge id)[UIImage imageNamed:@"welcome_background.png"].CGImage;
//    _backView.layer.contentsScale = [UIScreen mainScreen].scale;
//    _backView.layer.contentsGravity = kCAGravityResizeAspect;
    _backView.hidden = YES;
    [self.view addSubview:_backView];
    
    // 按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.tag = 1000;
    [backBtn setBackgroundImage:[UIImage imageNamed:@"present_back@2x.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.backgroundColor = [UIColor whiteColor];
    backBtn.frame = CGRectMake(kScreenWidth - 50 , 30, 30,  30);
    backBtn.layer.cornerRadius = backBtn.width / 2.0;
    backBtn.layer.masksToBounds = YES;
    [_mainView addSubview:backBtn];
    
    // UILabel
    
    self.mainLabel= [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 30,40 )];
    self.mainLabel.center = CGPointMake(kScreenWidth / 2.0, 100);
    self.mainLabel.backgroundColor = [UIColor whiteColor];
    self.mainLabel.textColor = [UIColor blackColor];
    self.mainLabel.text = @"大声说出你想要什么";
    self.mainLabel.textAlignment = NSTextAlignmentCenter;
    [_mainView addSubview:self.mainLabel];
    
    // UIView
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, self.mainLabel.bottom + 10, kScreenWidth, 40 *5 + 20)];
    backView.backgroundColor = [UIColor clearColor];
    
    
    
    for (int i = 0; i < 5; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10 + 40 * i, kScreenWidth ,40 )];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.text = @"大米";
        label.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:label];
    }
    [_mainView addSubview:backView];
    //
    _sharpLabel = [[SharpLabel alloc]init:CGPointMake(kScreenWidth/2.0 , kScreenHeight -  80 -40 -30) str:@"按住说话"];
    _sharpLabel.label.text = @"按住说话";
    self.voiceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.voiceBtn.center = CGPointMake(kScreenWidth/2.0, kScreenHeight - 80);
    self.voiceBtn.layer.cornerRadius = 40.f;
    self.voiceBtn.layer.masksToBounds = YES;
    self.voiceBtn.tag = 1001;
    [self.voiceBtn setBackgroundImage:[UIImage imageNamed:@"Voice"] forState:UIControlStateNormal];
    [self.voiceBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
    self.voiceBtn.backgroundColor = [UIColor whiteColor];
    [_mainView addSubview:_sharpLabel];
    [_mainView addSubview:self.voiceBtn];
    
    // 语音TextView
    self.textView = [[UITextView alloc]init];
    self.textView.frame = CGRectMake(20, backView.bottom + 2, kScreenWidth - 40, 80);
    self.textView.backgroundColor = [UIColor greenColor];
//    [_mainView addSubview:self.textView];

}


- (void)buttonClicked:(UIButton *)sender
{
    if (sender.tag == 1000) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (sender.tag == 1001){
        
        _isPressButton = YES;
        [_voiceBtn addTarget:self action:@selector(buttonClicked11:) forControlEvents:UIControlEventTouchUpInside];
        _sharpLabel.label.text = @"松开结束";
        
        //产生光晕
        [self initUIForBtnAnimation];
        arcLayer.strokeColor = [UIColor colorWithRed:224.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:0.5].CGColor;
        
        // 散发光圈
        _time  =  [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(setWaveUI) userInfo:nil repeats:YES];
        
        //  语音
        self.textView.text = @"";
        _mainLabel.text = @"";
        
        [self.textView  resignFirstResponder];
        self.isCanceled = NO;
        if (_iFlySpeechRecognizer == nil) {
            [self initRecognizer];
        }
        [_iFlySpeechRecognizer cancel];
        
        //设置音频来源为麦克风
        [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        //设置听写结果格式为json
        [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
        [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        [_iFlySpeechRecognizer setDelegate:self];
        
        BOOL ret = [_iFlySpeechRecognizer startListening];
        
        if (ret) {
            self.voiceBtn.enabled = NO;
        } else {
            //可能是上次请求未结束，暂不支持多路并发
            self.textView.text = @"启动识别服务失败，请稍后重试";
        }
        
    }
}
- (void)buttonClicked11:(UIButton *)sender
{
    _isPressButton = NO;
    [_time invalidate];
    _mainView.hidden = YES;
    _backView.hidden = NO;
    
    [self setCilke];
    
    if (self.layer1 ) {
        [self.layer1 removeFromSuperlayer];
    }
    [self setlayer];
    
}

- (void)initUIForBtnAnimation
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(kScreenWidth/2.0, kScreenHeight - 80) radius:42 startAngle:0 endAngle:2*M_PI clockwise:NO];
    arcLayer = [CAShapeLayer layer];
    arcLayer.path = path.CGPath;
    arcLayer.fillColor = [UIColor colorWithRed:46.0/255.0 green:169.0/255.0 blue:230.0/255.0 alpha:0].CGColor;
    arcLayer.lineWidth = 4;
    arcLayer.frame = self.view.frame;
    [_mainView.layer addSublayer:arcLayer];
    
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    _isPressButton =YES;
    _mainView.hidden = NO;
    _backView.hidden = YES;
    //隐藏光晕
    arcLayer.strokeColor = [UIColor colorWithRed:224.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:0].CGColor;
    
    // 语音
    if (![self isBlankString:self.mainLabel.text]) {
        
    } else {
        self.mainLabel.text = @"你说什么我没听清";
    }
    [_iFlySpeechRecognizer stopListening];
    [self.textView resignFirstResponder];
    
    _sharpLabel.label.text = @"按住说话";
}

- (void)setWaveUI
{
    CALayer *waveLayer = [CALayer layer];
    waveLayer.frame = CGRectMake(kScreenWidth/2.0 - 40,  kScreenHeight - 120, 80, 80);
    waveLayer.borderColor = [UIColor redColor].CGColor;
    waveLayer.borderWidth = 0.5;
    waveLayer.cornerRadius = 40;
    [_mainView.layer addSublayer:waveLayer];
    [self scaleBegin:waveLayer];
    
}

- (void)scaleBegin:(CALayer *)alayer
{
    const float max = 4;
    if (alayer.transform.m11 < max) {
        if (alayer.transform.m11 == 1.0) {
            [alayer setTransform:CATransform3DMakeScale(1.1, 1.1, 1.0)];
        } else {
            [alayer setTransform:CATransform3DScale(alayer.transform, 1.1, 1.1, 1.0)];
            alayer.borderColor = [UIColor colorWithRed:255.f/255.f green:(4.0 - alayer.transform.m11) / 4.0 blue:(4.0 - alayer.transform.m11) / 4.0 alpha:(4.0 - alayer.transform.m11) / 4.0].CGColor;
        }
        [self performSelector:_cmd withObject:alayer afterDelay:0.08];
    }else {
        [alayer removeFromSuperlayer];
    }
}

-(void)setCilke{
    
    _imageCircle1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"clock_circle2"]];
    //    imageCircle1.backgroundColor = [UIColor redColor];
    _imageCircle1.frame = CGRectMake(0, 0, 100, 100);
    _imageCircle1.center = CGPointMake(kScreenWidth/2.0, kScreenHeight - 80);
    [_backView addSubview:_imageCircle1];
}

-(void)setlayer{
    //动画载体
    self.layer1 = [CALayer layer];
    self.layer1.frame = CGRectMake(0 , 0, 100, 100);
    self.layer1.position = CGPointMake(kScreenWidth/2.0 , kScreenHeight - 80 + 1);
    [_backView.layer addSublayer:self.layer1];
    //设置动画代理
    self.layer1.delegate = self;
    //设置动画
    [self.layer1 setNeedsDisplay];
    
    //动画  作用在layer某个属性上，动画效果不会影响layer原有的属性值
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //动画时长
    animation.duration = 1.0;
    animation.delegate = self;
    //动画的初始值
    animation.fromValue = [NSNumber numberWithFloat:0];
    //动画的结束时的值
    animation.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
    //动画结束时的状态
    /*
     kCAFillModeForwards   保持结束时的状态
     kCAFillModeBackwards    回到开始时的状态
     kCAFillModeBoth         兼顾以上的两种效果
     kCAFillModeRemoved      结束时删除效果
     */
    animation.fillMode = kCAFillModeRemoved;
     animation.repeatCount = CGFLOAT_MAX;
    //动画的重复次数
    [self performSelectorOnMainThread:@selector(onResults:isLast:) withObject:nil waitUntilDone:YES];
    animation.repeatCount =  1;
    //开始动画
    [self.layer1 addAnimation:animation forKey:@"rotation"];
    
    
}

//实现代理方法
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    if (layer == self.layer1) {
        UIImage * image = [UIImage imageNamed:@"clock_circle3"];
        CGContextDrawImage(ctx, CGRectMake(0,0, 100, 100), image.CGImage);
    }
    //    CGContextRestoreGState(ctx);
    CGContextSaveGState(ctx);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --动画画圆
//- (void)drawLineAnimation:(CALayer *)layer
//{
//    CABasicAnimation *bas = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    bas.duration =5;
//    bas.delegate = self;
//    bas.fromValue = [NSNumber numberWithInt:0];
//    bas.toValue = [NSNumber numberWithInt:1];
//    [layer addAnimation:bas forKey:@"key"];
//
//
//}

-(void)dealloc
{
    if (self.layer1.delegate == self) {
        self.layer1.delegate = nil;
    }
}

#pragma mark ---IFlySpeech
// 初始化识别对象
- (void)initRecognizer
{
    //单例模式，无UI的实例
    if (_iFlySpeechRecognizer == nil) {
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //设置听写模式
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN ]];
    }
    
    _iFlySpeechRecognizer.delegate = self;
    if (_iFlySpeechRecognizer != nil) {
        IATConfig * instance = [IATConfig sharedInstance];
        //设置最长录音时间
        [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        
        // 设置后端点
        [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
        
        // 设置前端点
        [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
        // 网络等待时间
        [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        
        //设置采样率，推荐使用16K
        [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE_16K]];
        
        if ([instance.language isEqualToString:[IATConfig chinese]]) {
            // 设置语言
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //设置方言
            [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
        }else if ([instance.language isEqualToString:[IATConfig english]]) {
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        }
        //设置是否返回标点符号
        [_iFlySpeechRecognizer setParameter: [IFlySpeechConstant ASR_PTT_NODOT] forKey:[IFlySpeechConstant ASR_PTT]];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [_iFlySpeechRecognizer cancel];
    [_iFlySpeechRecognizer setDelegate:nil];
    [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
}

#pragma mark - IFlySpeechRecognizerDelegate
/**
 音量回调函数
 volume 0－30
 */

- (void) onVolumeChanged:(int)volume
{
    if (self.isCanceled) {
        return;
    }
    NSString *vol = [NSString stringWithFormat:@"音量： %d",volume];
    self.textView.text = vol;
}

/**
 开始识别回调
 */
-(void)onBeginOfSpeech
{
    self.textView.text = @"正在录音";
}

/**
 停止录音回调
 */

- (void)onEndOfSpeech
{
    self.textView.text = @"停止录音";
   
}

/**
 听写结束回调（注：无论听写是否正确都会回调）
 error.errorCode =
 0     听写正确
 other 听写出错
 */
- (void)onError:(IFlySpeechError *)error
{
    NSLog(@"%s",__func__);
    NSString *text;
    if (self.isCanceled) {
        text = @"识别取消";
    } else if (error.errorCode){
        if (self.result.length == 0) {
            text = @"无识别结果";
        }else {
            text = @"识别成功";
        }
        
    }
    
    else {
        text = [NSString stringWithFormat:@"发生错误：%d %@", error.errorCode,error.errorDesc];
        NSLog(@"%@",text);
    }
   self.textView.text = text;
    self.voiceBtn.enabled = YES;
    
}
/**
 无界面，听写结果回调
 results：听写结果
 isLast：表示最后一次
 ****/

-(void)onResults:(NSArray *)results isLast:(BOOL)isLast
{
    NSMutableString *resultString = [[NSMutableString alloc]init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    self.result = [NSString stringWithFormat:@"%@%@",_mainLabel.text,resultString];
    NSString *resultFromJson = [ISRDataHelper stringFromJson:resultString];

   _mainLabel.text = [NSString stringWithFormat:@"%@%@",_mainLabel.text,resultFromJson];
    
    if (isLast) {
        NSLog(@"听写结果(json)：%@测试",  self.result);
    }
    NSLog(@"_result=%@",_result);
    NSLog(@"resultFromJson=%@",resultFromJson);
    NSLog(@"isLast=%d,_mainLabel.text=%@",isLast,_mainLabel.text);
}



#pragma mark ---method/LK
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






































@end
