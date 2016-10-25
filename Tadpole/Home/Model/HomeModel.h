//
//  HomeModel.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/4/28.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
AS_SINGLETON(HomeModel)
@property(nonatomic, strong) NSMutableArray *imageArr;


#pragma mark- Method
- (NSMutableArray *)getImageArrForScr;
- (NSMutableDictionary *)getDataForKind;
- (NSDictionary *)getCityData;



@end
