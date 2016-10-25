//
//  MovieRMTPCreator.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/24.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieRMTPCreator : NSObject<NSCoding,NSCopying>

@property (nonatomic, assign)double creatorIdentifier;
@property (nonatomic, strong) NSString *thirdPlatform;
@property (nonatomic, strong) NSString *creatorDescription;
@property (nonatomic, assign)double rankVeri;
@property (nonatomic, assign)double gmutex;
@property (nonatomic, assign)double verified;
@property (nonatomic, strong) NSString *emotion;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, assign) double inkeVerify;// 验证
@property (nonatomic, strong) NSString *verifiedReason;
@property (nonatomic, strong) NSString *birth;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *portrait;
@property (nonatomic, strong) NSString *hometown;
@property (nonatomic, assign) double level;
@property (nonatomic, strong) NSString *veriInfo;
@property (nonatomic, assign) double gender;
@property (nonatomic, strong) NSString *profession;

+ (instancetype)modleObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;




















@end
