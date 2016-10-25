//
//  FMTracksModel.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/1/15.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "FMTracksModel.h"

@implementation FMTracksModel
-(instancetype)init
{
    if ([super init]) {
        self.trackId = nil;
        self.playtimes = nil;
        self.playUrl32 = nil;
        self.playUrl64 = nil;
    }
    return self;
}
@end
