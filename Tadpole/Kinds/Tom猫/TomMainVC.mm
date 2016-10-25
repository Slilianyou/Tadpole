//
//  TomMainVC.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/5/24.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "TomMainVC.h"
#include <stdio.h>
#include <sys/time.h>
#include "Dirac.h"
#import "EAFRead.h"
#import "EAFWrite.h"


double gExecTimeTotal = 0.;

void DeallocateAudioBuffer(float **audio, int numChannels)
{
    if (!audio) return;
    for (long v = 0; v < numChannels; v++) {
        if (audio[v]) {
            free(audio[v]);
            audio[v] = NULL;
        }
    }
    free(audio);
    audio = NULL;
}

float **AllocateAudioBuffer(int numChannels, int numFrames)
{
    // Allocate buffer for output
    float **audio = (float**)malloc(numChannels*sizeof(float*));
    if (!audio) return NULL;
    memset(audio, 0, numChannels*sizeof(float*));
    for (long v = 0; v < numChannels; v++) {
        audio[v] = (float*)malloc(numFrames*sizeof(float));
        if (!audio[v]) {
            DeallocateAudioBuffer(audio, numChannels);
            return NULL;
        }
        else memset(audio[v], 0, numFrames*sizeof(float));
    }
    return audio;
}


long myReadData(float **chdata, long numFrames, void *userData)
{
    if (!chdata)	return 0;
    
    TomMainVC *Self = (__bridge  TomMainVC*)userData;
    if (!Self)	return 0;
    
    gExecTimeTotal += DiracClockTimeSeconds();
    
    OSStatus err = [Self.reader readFloatsConsecutive:numFrames intoArray:chdata];
    
    DiracStartClock();
    return err;
    
}

@interface TomMainVC ()
- (void)record;
- (void)stopRecord;
- (void)play;
- (BOOL)canRecord;
- (void)updateMeters:(NSTimer *)sender;
- (void)mackChangeSound;
@end

@implementation TomMainVC
@synthesize reader = _reader;
@synthesize writer = _writer;
- (void)record
{
    if ([self canRecord]) {
        NSError *error;
        
        NSMutableDictionary *_recordSetting = [[NSMutableDictionary alloc]init];
        
        [_recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
        [_recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
        [_recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
        [_recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityMax] forKey:AVEncoderAudioQualityKey];
        _recorder = NULL;
        _recorder = [[AVAudioRecorder alloc]initWithURL:[NSURL fileURLWithPath:audioPath] settings:_recordSetting error:&error];
        
        [_recorder setMeteringEnabled: YES];
        [_recorder setDelegate:self];
        
        [_recorder prepareToRecord];
        
        
    } else {
        NSLog(@"不能录制！！！！");
    }
}

-(int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + arc4random() % (to-from+1));
}

- (BOOL)canRecord
{
    NSError *error;
    self.audioSession = [AVAudioSession sharedInstance];
    
    if (![self.audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error]) {
        NSLog(@"Error  %@",[error localizedDescription]);
        return NO;
    }
    
    if (![self.audioSession setActive:YES error:&error]) {
        NSLog(@"Error  %@",[error localizedDescription]);
        return NO;
    }
    
    return self.audioSession.inputAvailable;
}
- (void)updateMeters:(NSTimer *)sender
{
    // NSLog(@"%@",[SCListener sharedListener]);
    if ([[SCListener sharedListener] averagePower] > 0.1) {
        if (!ISRECORDED) {
            if (!isRecording) {
                [self startListen];
                NSLog(@"1开始录制");
                isRecording = YES;
                ISRECORDED = YES;  //记录是否录音过声音
                _playTimes = 0;
                
                [_recorder prepareToRecord];
                [_recorder record];
            }
        } else {
            if (!isPlaying) {
                if (!isRecording) {
                    [self startListen];
                    NSLog(@"2开始录制");
                    isRecording = YES;
                    _playTimes = 0;
                    [_recorder prepareToRecord];
                    [_recorder record];
                }
            }
        }
    }
    
    if ([[SCListener sharedListener] averagePower] < 0.1) {
        
        _lowTimes++;
        
        if (_lowTimes >= 5) {  //5  次  0.5s=======
            _lowTimes = 0;
            isRecording = NO;
            if (!isRecording & !isPlaying) {
                
                if (ISRECORDED) {
                    
                    if (_playTimes < 1) {
                        _playTimes++;
                        
                        NSLog(@"停止录制内容");
                        [self stopRecord];
                        isPlaying = YES;
                    }
                    
                }
            }
        }
    }
    
}

- (void)stopRecord {
    [_recorder stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self change];
}

- (void)change
{
    // 按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.tag = 998;
    [backBtn setBackgroundImage:[UIImage imageNamed:@"present_back@2x.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.backgroundColor = [UIColor whiteColor];
    backBtn.frame = CGRectMake(kScreenWidth -  40 , 30, 30,  30);
    backBtn.layer.cornerRadius = backBtn.width / 2.0;
    backBtn.layer.masksToBounds = YES;
    [self.view addSubview:backBtn];
    
    
    // titleLabel
    NSString *title = @"山寨汤姆猫";
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20.f]}];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - titleSize.width) / 2, 20, titleSize.width, titleSize.height)];
    titleLabel.text = title;
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:titleLabel];
    
    // 打钹
    UIButton *cymbalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cymbalBtn.frame = CGRectMake(2 , 370, 50,  50);
    [cymbalBtn setBackgroundImage:[UIImage imageNamed:@"cymbal"] forState:UIControlStateNormal];
    cymbalBtn.tag = 1000;
    [cymbalBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cymbalBtn];
    
    
    // 喝奶
    UIButton *drinkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    drinkBtn.frame = CGRectMake(kScreenWidth - 52 , 370, 50,  50);
    [drinkBtn setBackgroundImage:[UIImage imageNamed:@"drink"] forState:UIControlStateNormal];
    drinkBtn.tag = 1001;
    [drinkBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:drinkBtn];
    
    // 划痕
    UIButton *scratchButton = [[UIButton alloc] initWithFrame:CGRectMake(2, 440, 50, 50)];
    scratchButton.tag = 1002;
    [scratchButton setBackgroundImage:[UIImage imageNamed:@"btn_cat_print-60@2x.png"] forState:UIControlStateNormal];
    [scratchButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scratchButton];
    
    //吃鸟
    UIButton *birdButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 52 , 440, 50,  50)];
    birdButton.tag = 1003;
    [birdButton setBackgroundImage:[UIImage imageNamed:@"gumb-bird2-60@2x.png"] forState:UIControlStateNormal];
    [birdButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:birdButton];
    
    //pie
    UIButton *pieButton = [[UIButton alloc] initWithFrame:CGRectMake(2, 510, 50, 50)];
    pieButton.tag = 1004;
    [pieButton setBackgroundImage:[UIImage imageNamed:@"pie"] forState:UIControlStateNormal];
    [pieButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pieButton];
    
    // 放屁
    UIButton *fartButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 52, 510, 50, 50)];
    fartButton.tag = 1005;
    [fartButton setBackgroundImage:[UIImage imageNamed:@"fart"] forState:UIControlStateNormal];
    [fartButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fartButton];
    
    // 生气
    UIButton *angryButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 580, 36, 36)];
    angryButton.tag = 1006;
    [angryButton setBackgroundImage:[UIImage imageNamed:@"angry"] forState:UIControlStateNormal];
    [angryButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [angryButton setBackgroundColor:[UIColor whiteColor]];
    angryButton.layer.cornerRadius = angryButton.bounds.size.width / 2.0;
    angryButton.layer.masksToBounds = YES;
    [self.view addSubview:angryButton];
    
    // 生气
    UIButton *happyButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 48, 580, 36, 36)];
    happyButton.tag = 1007;
    [happyButton setBackgroundImage:[UIImage imageNamed:@"happy"] forState:UIControlStateNormal];
    [happyButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [happyButton setBackgroundColor:[UIColor whiteColor]];
    happyButton.layer.cornerRadius = happyButton.bounds.size.width / 2.0;
    happyButton.layer.masksToBounds = YES;
    [self.view addSubview:happyButton];
    //
    [self performSelector:@selector(startYawn) withObject:nil afterDelay:0.5];
    
    _lowTimes = 0;
    _playTimes = 0;
    
    // 设置路径
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    audioPath = [[searchPaths objectAtIndex:0]stringByAppendingPathComponent:@"audio.wav"];
    outUrl = [[NSURL alloc]initFileURLWithPath:[[searchPaths objectAtIndex:0]stringByAppendingPathComponent:@"audio.aif"]];
    
    [self record];
    
    //启动监听
    [[SCListener sharedListener] listen];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateMeters:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    
}

- (void)buttonClicked:(UIButton *)btn
{
    int num = [self getRandomNumber:1 to:3];
    if (btn.tag == 998) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (btn.tag == 1000) {
        [self initCymbalArray];
        [self startAnimationWithImages:cymbalArray duration:2];
        [self performSelector:@selector(playSoundWithFile:) withObject:@"cymbal" afterDelay:0.8];
        
    }else if (btn.tag == 1001) {
        [self initDrinkArray];
        [self startAnimationWithImages:drinkArray duration:10];
        [self performSelector:@selector(playSoundWithFile:) withObject:@"pour_milk" afterDelay:2.4];
        [self performSelector:@selector(playSoundWithFile:) withObject:@"p_drink_milk" afterDelay:5.8];
        
    } else if (btn.tag == 1002){
        [self initScratchArray];
        [self startAnimationWithImages:scratchArray duration:8];
        [self performSelector:@selector(playSoundWithFile:) withObject:@"scratch_kratzen" afterDelay:3.8];
    }else if (btn.tag == 1003){
        [self initBirdArray];
        [self startAnimationWithImages:birdArray duration:4];
        [self performSelector:@selector(playSoundWithFile:) withObject:@"p_eat" afterDelay:1.8];
    }else if (btn.tag == 1004){
        [self initPieArray];
        [self startAnimationWithImages:pieArray duration:4];
        
    }else if (btn.tag == 1005){
        [self initFartArray];
        [self startAnimationWithImages:fartArray duration:3];
        NSString *fileName = [NSString stringWithFormat:@"%@%d%@",@"fart00",num,@"_11025"];
        [self performSelector:@selector(playSoundWithFile:) withObject:fileName afterDelay:1];
        
    }else if (btn.tag == 1006){
        [self initAngryArray];
        [self startAnimationWithImages:angryArray duration:3];
        [self performSelector:@selector(playSoundWithFile:) withObject:@"angry" afterDelay:1];
        
    }else if (btn.tag == 1007){
        [self initHappyArray];
        [self startAnimationWithImages:happyArray duration:3 repeatCount:1 ];
        
    }
    
}


int touchHeader = 0;
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event touchesForView:self.view]anyObject];
    CGPoint location = [touch locationInView:gifImageView];
    
    int number = [self getRandomNumber:1 to:2];
    if ((location.x >= 200.0 && location.y >= 580.0) && (location.x <= 230.0 && location.y <= 620.0)) {
        [self initFootLeftArray];
        [self startAnimationWithImages:footLeftArray duration:3];
        [self playSoundWithFile:number ==1 ? @"p_foot3" : @"p_foot4"];
    }
    
    if ((location.x >= 140.0 && location.y >= 615.0) && (location.x <= 160.0 && location.y <= 640.0)) {
        [self initFootRightArray];
        [self startAnimationWithImages:footRightArray duration:3];
        [self playSoundWithFile:number == 1 ? @"p_foot3" : @"p_foot4"];
    }
    
    if ((location.x >= 165.0 && location.y >= 470.0) && (location.x <= 185.0 && location.y <= 500.0)) {
        [self initStomachArray];
        [self startAnimationWithImages:stomachArray duration:3];
        [self playSoundWithFile:number == 1 ? @"p_belly1" : @"p_belly2"];
    }
    
    if ((location.x >= 150.0 && location.y >= 165.0) && (location.x <= 230.0 && location.y <= 190.0)) {
        touchHeader++;
        NSString *file = [NSString stringWithFormat:@"slap%d",[self getRandomNumber:1 to:6]];
        
        if (touchHeader >= 3) {
            [self initKnockout2Array];
            [self startAnimationWithImages:knockout2Array duration:10];
            [self playSoundWithFile:file];
            [self performSelector:@selector(playSoundWithFile:) withObject:@"fall" afterDelay:1.8];
            [self performSelector:@selector(playSoundWithFile:) withObject:@"p_stars2s" afterDelay:2.3];
            touchHeader = 0;
        }else{
            [self initKnockout1Array];
            [self startAnimationWithImages:knockout1Array duration:2];
            [self playSoundWithFile:file];
        }
    }
    
    
    NSLog(@"location.x ===%f---location.y====%f",location.x,location.y);
}


- (void)mackChangeSound {
    
    _reader = [[EAFRead alloc] init];
    _writer = [[EAFWrite alloc] init];
    
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~xxxxx");
    long numChannels = 1;		// DIRAC LE allows mono only
    float sampleRate = 44100.;
    
    NSLog(@"inurl = %@;outurl = %@", inUrl, outUrl);
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~1");
    [_reader openFileForRead:[NSURL fileURLWithPath:audioPath] sr:sampleRate channels:numChannels];
    NSLog(@"!!!!!~~~~~~!!!!!!!!!!!~~~~~~~~");
    [_writer openFileForWrite:outUrl sr:sampleRate channels:numChannels wordLength:16 type:kAudioFileAIFFType];
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~2");
    float time      = 1.0;
    float pitch     = 1.4;
    float formant   = 1.0;
    
    void *dirac = DiracCreate(kDiracLambdaPreview, kDiracQualityPreview, numChannels, sampleRate, &myReadData, (__bridge void*)self);
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~3");
    
    
    DiracSetProperty(kDiracPropertyTimeFactor, time, dirac);
    DiracSetProperty(kDiracPropertyPitchFactor, pitch, dirac);
    DiracSetProperty(kDiracPropertyFormantFactor, formant, dirac);
    
    if (pitch > 1.0)
        DiracSetProperty(kDiracPropertyUseConstantCpuPitchShift, 1, dirac);
    
    DiracPrintSettings(dirac);
    
    
    SInt64 numf = [_reader fileNumFrames];
    SInt64 outframes = 0;
    SInt64 newOutframe = numf*time;
    
    percent = 0;
    
    long numFrames = 8192;
    
    float **audio = AllocateAudioBuffer(numChannels, numFrames);
    
    double bavg = 0;
    
    for(;;) {
        
        DiracStartClock();
        long ret = DiracProcess(audio, numFrames, dirac);
        bavg += (numFrames/sampleRate);
        gExecTimeTotal += DiracClockTimeSeconds();
        
        SInt64 framesToWrite = numFrames;
        SInt64 nextWrite = outframes + numFrames;
        if (nextWrite > newOutframe) framesToWrite = numFrames - nextWrite + newOutframe;
        if (framesToWrite < 0) framesToWrite = 0;
        
        [_writer writeFloats:(long)framesToWrite fromArray:audio];
        outframes += numFrames;
        
        if (ret <= 0)
            break;
    }
    
    
    
    DeallocateAudioBuffer(audio, numChannels);
    DiracDestroy( dirac );
    
    
    //必须清空，不然沙盒中的audio.aif编译错误，打不开
    _writer = NULL;
    _reader = NULL;
    // Done!
    NSLog(@"\nDone!");
    //
    [self play];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)play {
    NSLog(@"播放录制内容");
    NSError *error;
    // NSString *_filePath = [[NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithString:@"out.aif"]] retain];
    
    _player = NULL;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:outUrl error:&error];
    _player.delegate = self;
    [_player play];
}
#pragma mark --RecorderDelegate
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    NSLog(@"录音失败");
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSLog(@"录音结束并且成功  ～～～～～@@～～～～～～");
    
    NSData *data = [NSData dataWithContentsOfURL:_recorder.url];
    [data writeToFile:audioPath atomically:YES];
    
    [self mackChangeSound];
    [self stopListen];
    [self initTalkArray];
    [self startAnimationWithImages:talkArray duration:0.12 repeatCount:3];
}

#pragma mark -- AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"播放结束！！！～～～@@～～～～");
    isPlaying = NO;
    [self stopListen];
    [[SCListener sharedListener] listen];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}



@end
