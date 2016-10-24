//
//  CUSSenderFallLayer.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/10.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CUSSenderLayer.h"

@interface CUSSenderFallLayer : CUSSenderLayer

- (id)initWithImageName:(NSString *)imageName;
- (id)initWithImageNameArray:(NSArray *)imageNameArray;

- (void)initializeValue;

- (CAEmitterCell *)createSubLayerContainer;
- (CAEmitterCell *)createSubLayer:(UIImage *)image;









































@end
