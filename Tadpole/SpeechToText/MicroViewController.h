//
//  MicroViewController.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/11.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVSpeechSynthesis.h>
#import <iflyMSC/iflyMSC.h>
#import "PcmPlayer.h"
#import "CUShowView.h"

@class CUShowView;
@class PopupView;
@class IFlySpeechSynthesizer;
@class IFlySpeechRecognizer;
@class IFlyDataUploader;
/**
 语音听写demo
 使用该功能仅仅需要四步
 1.创建识别对象；
 2.设置识别参数；
 3.有选择的实现识别回调；
 4.启动识别
 */
typedef NS_OPTIONS(NSInteger, SynthesizeType) {
    NomalType           = 5,//普通合成
    UriType             = 6, //uri合成
};

typedef NS_OPTIONS(NSInteger, Status) {
    NotStart            = 0,
    Playing             = 2, //高异常分析需要的级别
    Paused              = 4,
};
@interface MicroViewController : UIViewController<UITextFieldDelegate,IFlySpeechSynthesizerDelegate,UITextViewDelegate,IFlySpeechRecognizerDelegate,IFlyRecognizerViewDelegate>
@property (nonatomic, strong) NSString *str;

@property (nonatomic, strong)IFlySpeechSynthesizer * iFlySpeechSynthesizer;
@property (nonatomic, strong) PopupView *popUpView;

@property (nonatomic, assign) SynthesizeType synType;

@property (nonatomic, strong)UITextField *textFiled;

@property (nonatomic, strong) UIButton *startBtn;

@property (nonatomic, assign) BOOL isViewDidDisappear;

@property (nonatomic, strong) PcmPlayer *audioPlayer;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, assign) Status state;

@property (nonatomic, strong) CUShowView *inidicateView;
#pragma mark-  读写
//************************
@property (nonatomic, strong) NSString *pcmFilePath; // 音频文件路径

@property (nonatomic, strong)IFlySpeechRecognizer *iFlySpeechRecognizer;//不带界面的识别对象

@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//带界面的识别对象

@property (nonatomic, strong) IFlyDataUploader *uploader; //数据上传对象

@property (weak, nonatomic) UIButton *startRecBtn;

@property (nonatomic, strong) NSString * result;


@property(nonatomic, assign) BOOL isCUPlaying; // 是否文字转音频

@property(nonatomic, assign) BOOL isPGControl; // 是否苹果原声框架






@end
