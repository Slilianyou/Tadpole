//
//  TomMainVC.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/5/24.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "TomBaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>
#import "SCListener.h"
#import "EAFRead.h"
#import "EAFWrite.h"

@class EAFRead;
@class EAFWrite;

@interface TomMainVC : TomBaseViewController<AVAudioPlayerDelegate,AVAudioRecorderDelegate>

{
    @private
    AVAudioPlayer * _player; //播放器
    
   // NSURL *_recorderTmpFile;  // 录音的临时文件路径
    NSString *audioPath;
    AVAudioRecorder *_recorder;   // use record
    
    // 用来检测的布尔值
    BOOL isRecording;
    BOOL isPlaying;
    BOOL ISRECORDED; //记录是否录音过声音
    
    NSInteger _lowTimes;
    NSInteger _playTimes;
    
    EAFWrite *_writer;
    EAFRead *_reader;
    float percent;
    NSTimer *_timer;
}
@property (nonatomic, strong)AVAudioSession *audioSession;
@property (nonatomic, strong) EAFRead *reader;
@property (nonatomic, strong) EAFWrite *writer;

- (int)getRandomNumber:(int)from  to:(int)to;


























@end
