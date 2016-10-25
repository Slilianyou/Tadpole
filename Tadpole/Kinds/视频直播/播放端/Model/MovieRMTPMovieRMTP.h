//
//  MovieRMTPMovieRMTP.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/27.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieRMTPMovieRMTP : NSObject<NSCoding,NSCopying>
@property (nonatomic, assign) double expireTime;
@property (nonatomic, strong) NSArray *lives;
@property (nonatomic, assign) int dmError;
@property (nonatomic, strong) NSString *errorMsg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
@end
