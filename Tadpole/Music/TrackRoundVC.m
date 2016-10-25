//
//  TrackRoundVC.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/1/23.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "TrackRoundVC.h"
#import "TrackRoundView.h"
#import "FSPlayIistItem.h"


@interface TrackRoundVC ()<TrackRoundViewDelegate,AudioPlayerDelegate>

@property (nonatomic, strong) TrackRoundView *roundView;
@end

@implementation TrackRoundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self change];
}

- (void)change
{
    // http://www.cnblogs.com/xiaowai/archive/2013/11/10/3416911.html
    //    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]]; // 拉伸耗内存

    UIImage *image = [UIImage imageNamed:@"background.jpg"];
    self.view.layer.contents = (id)image.CGImage;
    
    // backgroundView;
    CGFloat w = (kScreenWidth - 300.0) / 2.0;
   self.roundView = [[TrackRoundView alloc]initWithFrame:CGRectMake(w, (kScreenHeight - 364)/2.0, 300, 300)];
    self.roundView .backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.roundView];
    
    self.roundView.delegate = self;
    self.roundView.roundImage = [UIImage imageNamed:@"girl"];
    self.roundView.rotationDuration = 8.0;
    self.roundView.isPlay = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)playStatuUpdate:(BOOL)playState
{
    isPlaying = playState;
    if (playState) {
        FSPlayIistItem * item = [[FSPlayIistItem alloc] init];
        item.url =  self.tracksModel.playUrl32;
        
    }
}


-(void) updateControls
{
    if (audioPlayer.state == AudioPlayerStateStopped) {
        
        isPlaying = NO;
    }else if (audioPlayer.state == AudioPlayerStateReady){
    }else if (audioPlayer.state == AudioPlayerStateRunning){
    }else if (audioPlayer.state == AudioPlayerStatePlaying){
        isPlaying = YES;
        
    }else if (audioPlayer.state == AudioPlayerStateError){
        
    }
   
}

-(void) audioPlayer:(AudioPlayer*)audioPlayer stateChanged:(AudioPlayerState)state
{
    [self updateControls];
}

-(void) audioPlayer:(AudioPlayer*)audioPlayer didEncounterError:(AudioPlayerErrorCode)errorCode
{
    [self updateControls];
}

-(void) audioPlayer:(AudioPlayer*)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId
{
    [self updateControls];
}

-(void) audioPlayer:(AudioPlayer*)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId
{
    [self updateControls];
}

-(void) audioPlayer:(AudioPlayer*)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(AudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration
{
    [self updateControls];
}

















@end
