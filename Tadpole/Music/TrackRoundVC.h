//
//  TrackRoundVC.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/1/23.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMTracksModel.h"
#import "AudioPlayer.h"

@interface TrackRoundVC : UIViewController
{
    BOOL isPlaying;
    AudioPlayer *audioPlayer;
}
@property(nonatomic, strong) FMTracksModel *tracksModel;
@end
