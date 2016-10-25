//
//  FSPlayIistItem.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/1/18.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * A playlist item. Each item has a title and url.
 */

@interface FSPlayIistItem : NSObject

@property (nonatomic,copy)NSString *title;

@property (nonatomic,copy)NSString *url;

@end
