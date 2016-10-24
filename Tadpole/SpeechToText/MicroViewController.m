//
//  MicroViewController.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/11.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "MicroViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVAudioSession.h>
#import <AudioToolbox/AudioSession.h>
#import "PopupView.h"
#import "TTSConfig.h"
#import "ISRDataHelper.h"
#import "IATConfig.h"



@interface MicroViewController ()

@end

@implementation MicroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addBtn];
    [self addIFlySpeechSynthesizer];
    [self addCUTextView];
    
    self.popUpView = [[PopupView alloc]initWithFrame:self.textView.frame withParentView:self.view];
    
    CGFloat posY = self.textView.frame.origin.y+self.textView.frame.size.height/6;

    
    _inidicateView =  [[CUShowView alloc]initWithFrame:CGRectMake(100, posY, 0, 0)];
    _inidicateView.ParentView = self.view;
    [self.view addSubview:_inidicateView];
    [_inidicateView hide];
    [self addCUPcmFilePath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initSynthesizer];
    [self initRecognizer];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.isViewDidDisappear = true;
    [_iFlySpeechSynthesizer stopSpeaking];
    [_audioPlayer stop];
    _iFlySpeechSynthesizer.delegate = nil;
    
    if ([IATConfig sharedInstance].haveView == NO) {
        //无界面
        [_iFlySpeechRecognizer cancel]; //取消识别
        [_iFlySpeechRecognizer setDelegate:nil];
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
    }
    else
    {
        [_iflyRecognizerView cancel]; //取消识别
        [_iflyRecognizerView setDelegate:nil];
        [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
    }
    [super viewWillDisappear:animated];
    
}
#pragma mark - UITextView
- (void)addCUTextView
{
    self.textView = [[UITextView alloc]init];
    self.textView.frame = CGRectMake(20, 100, kScreenWidth - 40, 300);
    self.textView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.textView.delegate = self;
    self.editing = YES;
    [self.view addSubview:self.textView];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}



#pragma mark- iFlySpeechSynthesizer

- (void)addIFlySpeechSynthesizer
{
    //    通过appid连接讯飞语音服务器，把@"53b5560a"换成你申请的appid
    //        NSString *initString = [NSString alloc]initWithFormat:@"appid=%@,"
    //        [self.iFlySpeechSynthesizer  ]
}
#pragma mark - 设置合成参数
- (void)initSynthesizer
{
    TTSConfig *instance = [TTSConfig sharedInstance];
    if (instance == nil) {
        return;
    }
    
    //合成服务单例
    if (_iFlySpeechSynthesizer == nil) {
        _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    }
    
    _iFlySpeechSynthesizer.delegate = self;
    
    //设置语速1-100
    [_iFlySpeechSynthesizer setParameter:instance.speed forKey:[IFlySpeechConstant SPEED]];
    
    //设置音量1-100
    [_iFlySpeechSynthesizer setParameter:instance.volume forKey:[IFlySpeechConstant VOLUME]];
    
    //设置音调1-100
    [_iFlySpeechSynthesizer setParameter:instance.pitch forKey:[IFlySpeechConstant PITCH]];
    
    //设置采样率
    [_iFlySpeechSynthesizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
    
    //设置发音人
    [_iFlySpeechSynthesizer setParameter:instance.vcnName forKey:[IFlySpeechConstant VOICE_NAME]];
    
    
}

/**
 开始通用合成
 ****/
- (void)CUPlaying
{
    NSLog(@"~~~~~~~~~LLY%d",self.isCUPlaying);
    if (self.isCUPlaying == YES) {
        self.isCUPlaying =NO;
        if (self.isPGControl == NO) {
            if ([self.textView.text isEqualToString:@""]) {
                [_popUpView showText:@"无效的文本信息"];
                return;
            }
            self.isPGControl = YES;
            AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc]init];
            AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:self.textView.text];  //需要转换的文本
            utterance.rate = 0.1;
            [av speakUtterance:utterance];
        }
        else
        {
            if ([self.textView.text isEqualToString:@""]) {
                [_popUpView showText:@"无效的文本信息"];
                return;
            }
            self.isPGControl = NO;
            if (_audioPlayer != nil && _audioPlayer.isPlaying == YES) {
                [_audioPlayer stop];
            }
            
            _synType = NomalType;
            _iFlySpeechSynthesizer.delegate = self;
            [_iFlySpeechSynthesizer startSpeaking:self.textView.text];
            
            if (_iFlySpeechSynthesizer.isSpeaking) {
                self.state  = Playing;
            }
        }
    }else { //  音频转文本
        
        if ([IATConfig sharedInstance].haveView == NO) {//无界面
            
            [_textView setText:@""];
            [_textView resignFirstResponder];
            
            if(_iFlySpeechRecognizer == nil)
            {
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
                NSLog(@"科大讯飞    Good！～！！！");
            }else{
                [_popUpView showText: @"启动识别服务失败，请稍后重试"];//可能
                NSLog(@"科大讯飞    bad！～！！！");
            }
            
        }
        else {
            
            if(_iflyRecognizerView == nil)
            {
                [self initRecognizer ];
            }
            
            [_textView setText:@""];
            [_textView resignFirstResponder];
            
            //设置音频来源为麦克风
            [_iflyRecognizerView setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
            
            //设置听写结果格式为json
            [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
            
            //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
            [_iflyRecognizerView setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
            [_iflyRecognizerView start];
        }
    }
}

#pragma mark - iFlySpeechSynthesizerDelegate
/**
 合成结束（完成）回调
 
 对uri合成添加播放的功能
 ****/
- (void)onCompleted:(IFlySpeechError *) error
{
    
    if (error.errorCode != 0) {
        //        [_inidicateView hide];
        //        [_popUpView showText:[NSString stringWithFormat:@"错误码:%d",error.errorCode]];
        return;
    }
    //    NSString *text ;
    //    if (self.isCanceled) {
    //        text = @"合成已取消";
    //    }else if (error.errorCode == 0) {
    //        text = @"合成结束";
    //    }else {
    //        text = [NSString stringWithFormat:@"发生错误：%d %@",error.errorCode,error.errorDesc];
    //        self.hasError = YES;
    //        NSLog(@"%@",text);
    //    }
    //
    //    [_inidicateView hide];
    //    [_popUpView showText:text];
    
    _state = NotStart;
    
    //    if (_synType == UriType) {//Uri合成类型
    //
    //        NSFileManager *fm = [NSFileManager defaultManager];
    //        if ([fm fileExistsAtPath:_uriPath]) {
    //            [self playUriAudio];//播放合成的音频
    //        }
    //    }
}


/**
 开始播放回调
 注：
 对通用合成方式有效，
 对uri合成无效
 ****/
- (void)onSpeakBegin
{
    //    [_inidicateView hide];
    //    self.isCanceled = NO;
    //    if (_state  != Playing) {
    //        [_popUpView showText:@"开始播放"];
    //    }
    
    
    _state = Playing;
    
    
    
}

#pragma mark - 读写
-(void)addCUPcmFilePath
{
    self.uploader = [[IFlyDataUploader alloc]init];
    
    //demo录音文件保存路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath  = [paths objectAtIndex:0];
    _pcmFilePath = [[NSString alloc]initWithFormat:@"%@",[cachePath stringByAppendingPathComponent:@"asr.pcm"]];
}

/**
 设置识别参数
 ****/
- (void)initRecognizer
{
    if ([IATConfig sharedInstance].haveView == NO) {//无界面
        
        //单例模式，无UI的实例
        if (_iFlySpeechRecognizer == nil) {
            _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
            [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
            
            //设置听写模式
            [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        }
        _iFlySpeechRecognizer.delegate = self;
        if (_iFlySpeechRecognizer != nil) {
            IATConfig *instance = [IATConfig sharedInstance];
            
            //设置最长录音时间
            [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            
            //设置后端点
            [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_EOS]];
            //设置前端点
            [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
            //网络等待时间
            [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
            
            //设置采样率，推荐使用16K
            [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
            
            if ([instance.language isEqualToString:[IATConfig chinese]]) {
                //设置语言
                [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
                //设置方言
                [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            }else if ([instance.language isEqualToString:[IATConfig english]]) {
                [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            }
            //设置是否返回标点符号
            [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
        }
    } else {//有界面
        
        //单例模式，UI的实例
        if (_iflyRecognizerView == nil) {
            //UI显示剧中
            _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
            
            [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
            
            //设置听写模式
            [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
            
        }
        _iflyRecognizerView.delegate = self;
        
        if (_iflyRecognizerView != nil) {
            IATConfig *instance = [IATConfig sharedInstance];
            //设置最长录音时间
            [_iflyRecognizerView setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            //设置后端点
            [_iflyRecognizerView setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
            //设置前端点
            [_iflyRecognizerView setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
            //网络等待时间
            [_iflyRecognizerView setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
            
            //设置采样率，推荐使用16K
            [_iflyRecognizerView setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
            if ([instance.language isEqualToString:[IATConfig chinese]]) {
                //设置语言
                [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
                //设置方言
                [_iflyRecognizerView setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            }else if ([instance.language isEqualToString:[IATConfig english]]) {
                //设置语言
                [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            }
            //设置是否返回标点符号
            [_iflyRecognizerView setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
            
        }
    }
}
#pragma mark -RecoginerDelgate

/**
 无界面，听写结果回调
 results：听写结果
 isLast：表示最后一次
 ****/
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    _result =[NSString stringWithFormat:@"%@%@", _textView.text,resultString];
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:resultString];
    _textView.text = [NSString stringWithFormat:@"%@%@", _textView.text,resultFromJson];
    
    if (isLast){
        NSLog(@"听写结果(json)：%@测试",  self.result);
    }
    if (_textView.text) {
        self.isCUPlaying = YES;
        if (self.isPGControl == NO) {
            self.isPGControl = 1;
        } else {
            self.isPGControl = 0;
        }
    }
    
    NSLog(@"_result=%@",_result);
    NSLog(@"resultFromJson=%@",resultFromJson);
    NSLog(@"isLast=%d,_textView.text=%@",isLast,_textView.text);
    NSLog(@"self.isCUPlaying=%d",self.isCUPlaying);
    
}

/**
 听写结束回调（注：无论听写是否正确都会回调）
 error.errorCode =
 0     听写正确
 other 听写出错
 ****/
- (void) onError:(IFlySpeechError *) error
{
    NSLog(@"%s",__func__);
    
    if ([IATConfig sharedInstance].haveView == NO ) {
        NSString *text ;
        
        if (error.errorCode == 0 ) {
            if (_result.length == 0) {
                text = @"无识别结果";
            }else {
                text = @"识别成功";
            }
        }else {
            text = [NSString stringWithFormat:@"发生错误：%d %@", error.errorCode,error.errorDesc];
            NSLog(@"%@",text);
        }
        
        [_popUpView showText: text];
        
    }else {
        [_popUpView showText:@"识别结束"];
        NSLog(@"errorCode:%d",[error errorCode]);
    }
    
    [_startRecBtn setEnabled:YES];
    
    
}

#pragma mark - AddBtn
- (void)addBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *imgIcon = imageNamed(@"Btn.png");
    [btn setBackgroundImage:imgIcon forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(CUPlaying) forControlEvents:UIControlEventTouchUpInside];
    //    [btn setTitle:@"按" forState:UIControlStateNormal];
    //    btn.titleLabel.font = [UIFont systemFontOfSize:100.f];
    btn.frame = CGRectMake(0 , 0, 100,  100);
    btn.center = CGPointMake(kScreenWidth / 2.0, kScreenHeight  - 49 - 100);
    
    btn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btn];
}


@end
