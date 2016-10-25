//
//  TomBaseViewController.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/5/24.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>
#import "SCListener.h"

@interface TomBaseViewController : UIViewController<AVAudioPlayerDelegate>
{
    NSMutableArray *yawnArray;   // 打哈欠
    NSMutableArray *cymbalArray; // 打钹
    NSMutableArray *talkArray;   // 说话
    NSMutableArray *drinkArray;  // 喝东西
    NSMutableArray *footLeftArray;   // 踩左脚
    NSMutableArray *footRightArray;  // 踩右脚
    NSMutableArray *stomachArray;    // 胃部
    NSMutableArray *knockout1Array;  // 敲头1
    NSMutableArray *knockout2Array;  // 敲头2
    NSMutableArray *scratchArray;    // 划痕
    NSMutableArray *birdArray;       // 吃鸟
    NSMutableArray *pieArray;        // 披萨
    NSMutableArray *fartArray;       // 放屁
    NSMutableArray *angryArray;      // 生气
    NSMutableArray *happyArray;      // 高兴
    
    NSURL *inUrl;
    NSURL *outUrl;
    
    NSURL *inUrlB;
    NSURL *outUrlB;
    AVAudioPlayer *player;
    UIImageView *gifImageView;
}


- (void)startYawn;
- (void)startListen;
- (void)stopListen;
- (void)playSoundWithFile:(NSString *)filename;
- (void)startAnimationWithImages:(NSMutableArray *)images duration:(NSTimeInterval)duration;
- (void)startAnimationWithImages:(NSMutableArray *)images duration :(NSTimeInterval) duration repeatCount: (int) repeatCount;
- (void)initGifImageView;
- (void)initYawnArray;
- (void)initCymbalArray;
- (void)initTalkArray;
- (void)initDrinkArray;
- (void)initFootLeftArray;
- (void)initFootRightArray;
- (void)initStomachArray;
- (void)initKnockout1Array;
- (void)initKnockout2Array;
- (void)initScratchArray;
- (void)initBirdArray;
- (void)initPieArray;
- (void)initFartArray;
- (void)initAngryArray;
- (void)initHappyArray;
- (void)clearWithArray:(NSMutableArray *)array;




























@end
