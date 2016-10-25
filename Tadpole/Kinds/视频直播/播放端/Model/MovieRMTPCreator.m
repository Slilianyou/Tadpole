//
//  MovieRMTPCreator.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/6/24.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "MovieRMTPCreator.h"


NSString *const kMovieRMTPCreatorId = @"id";
NSString *const kMovieRMTPCreatorThirdPlatform = @"third_platform";
NSString *const kMovieRMTPCreatorDescription = @"description";
NSString *const kMovieRMTPCreatorRankVeri = @"rank_veri";
NSString *const kMovieRMTPCreatorGmutex = @"gmutex";
NSString *const kMovieRMTPCreatorVerified = @"verified";
NSString *const kMovieRMTPCreatorEmotion = @"emotion";
NSString *const kMovieRMTPCreatorNick = @"nick";
NSString *const kMovieRMTPCreatorInkeVerify = @"inke_verify";
NSString *const kMovieRMTPCreatorVerifiedReason = @"verified_reason";
NSString *const kMovieRMTPCreatorBirth = @"birth";
NSString *const kMovieRMTPCreatorLocation = @"location";
NSString *const kMovieRMTPCreatorPortrait = @"portrait";
NSString *const kMovieRMTPCreatorHometown = @"hometown";
NSString *const kMovieRMTPCreatorLevel = @"level";
NSString *const kMovieRMTPCreatorVeriInfo = @"veri_info";
NSString *const kMovieRMTPCreatorGender = @"gender";
NSString *const kMovieRMTPCreatorProfession = @"profession";


@interface MovieRMTPCreator ()
- (id)objectOrNilForKey:(id)akey fromDictionary:(NSDictionary *)dict;
@end
@implementation MovieRMTPCreator
+ (instancetype)modleObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self =  [super init];
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.creatorIdentifier = [[self objectOrNilForKey:kMovieRMTPCreatorId fromDictionary:dict] doubleValue];
        self.thirdPlatform = [self objectOrNilForKey:kMovieRMTPCreatorThirdPlatform fromDictionary:dict];
        self.creatorDescription = [self objectOrNilForKey:kMovieRMTPCreatorDescription fromDictionary:dict];
        self.rankVeri = [[self objectOrNilForKey:kMovieRMTPCreatorRankVeri fromDictionary:dict] doubleValue];
        self.gmutex = [[self objectOrNilForKey:kMovieRMTPCreatorGmutex fromDictionary:dict] doubleValue];
        self.verified = [[self objectOrNilForKey:kMovieRMTPCreatorVerified fromDictionary:dict] doubleValue];
        self.emotion = [self objectOrNilForKey:kMovieRMTPCreatorEmotion fromDictionary:dict];
        self.nick = [self objectOrNilForKey:kMovieRMTPCreatorNick fromDictionary:dict];
        self.inkeVerify = [[self objectOrNilForKey:kMovieRMTPCreatorInkeVerify fromDictionary:dict] doubleValue];
        self.verifiedReason = [self objectOrNilForKey:kMovieRMTPCreatorVerifiedReason fromDictionary:dict];
        self.birth = [self objectOrNilForKey:kMovieRMTPCreatorBirth fromDictionary:dict];
        self.location = [self objectOrNilForKey:kMovieRMTPCreatorLocation fromDictionary:dict];
        self.portrait = [self objectOrNilForKey:kMovieRMTPCreatorPortrait fromDictionary:dict];
        self.hometown = [self objectOrNilForKey:kMovieRMTPCreatorHometown fromDictionary:dict];
        self.level = [[self objectOrNilForKey:kMovieRMTPCreatorLevel fromDictionary:dict] doubleValue];
        self.veriInfo = [self objectOrNilForKey:kMovieRMTPCreatorVeriInfo fromDictionary:dict];
        self.gender = [[self objectOrNilForKey:kMovieRMTPCreatorGender fromDictionary:dict] doubleValue];
        self.profession = [self objectOrNilForKey:kMovieRMTPCreatorProfession fromDictionary:dict];
    }
    return self;
}

#pragma mark - Helper Method
-(id)objectOrNilForKey:(id)akey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:akey];
    return [object isEqual:[NSNull class]] ? nil : object;
}
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.creatorIdentifier] forKey:kMovieRMTPCreatorId];
    [mutableDict setValue:self.thirdPlatform forKey:kMovieRMTPCreatorThirdPlatform];
    [mutableDict setValue:self.creatorDescription forKey:kMovieRMTPCreatorDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.rankVeri] forKey:kMovieRMTPCreatorRankVeri];
    [mutableDict setValue:[NSNumber numberWithDouble:self.gmutex] forKey:kMovieRMTPCreatorGmutex];
    [mutableDict setValue:[NSNumber numberWithDouble:self.verified] forKey:kMovieRMTPCreatorVerified];
    [mutableDict setValue:self.emotion forKey:kMovieRMTPCreatorEmotion];
    [mutableDict setValue:self.nick forKey:kMovieRMTPCreatorNick];
    [mutableDict setValue:[NSNumber numberWithDouble:self.inkeVerify] forKey:kMovieRMTPCreatorInkeVerify];
    [mutableDict setValue:self.verifiedReason forKey:kMovieRMTPCreatorVerifiedReason];
    [mutableDict setValue:self.birth forKey:kMovieRMTPCreatorBirth];
    [mutableDict setValue:self.location forKey:kMovieRMTPCreatorLocation];
    [mutableDict setValue:self.portrait forKey:kMovieRMTPCreatorPortrait];
    [mutableDict setValue:self.hometown forKey:kMovieRMTPCreatorHometown];
    [mutableDict setValue:[NSNumber numberWithDouble:self.level] forKey:kMovieRMTPCreatorLevel];
    [mutableDict setValue:self.veriInfo forKey:kMovieRMTPCreatorVeriInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.gender] forKey:kMovieRMTPCreatorGender];
    [mutableDict setValue:self.profession forKey:kMovieRMTPCreatorProfession];
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"%@",[self dictionaryRepresentation]];
}

#pragma mark - NSCoding Methods
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.creatorIdentifier = [aDecoder decodeDoubleForKey:kMovieRMTPCreatorId];
    self.thirdPlatform = [aDecoder decodeObjectForKey:kMovieRMTPCreatorThirdPlatform];
    self.creatorDescription = [aDecoder decodeObjectForKey:kMovieRMTPCreatorDescription];
    self.rankVeri = [aDecoder decodeDoubleForKey:kMovieRMTPCreatorRankVeri];
    self.gmutex = [aDecoder decodeDoubleForKey:kMovieRMTPCreatorGmutex];
    self.verified = [aDecoder decodeDoubleForKey:kMovieRMTPCreatorVerified];
    self.emotion = [aDecoder decodeObjectForKey:kMovieRMTPCreatorEmotion];
    self.nick = [aDecoder decodeObjectForKey:kMovieRMTPCreatorNick];
    self.inkeVerify = [aDecoder decodeDoubleForKey:kMovieRMTPCreatorInkeVerify];
    self.verifiedReason = [aDecoder decodeObjectForKey:kMovieRMTPCreatorVerifiedReason];
    self.birth = [aDecoder decodeObjectForKey:kMovieRMTPCreatorBirth];
    self.location = [aDecoder decodeObjectForKey:kMovieRMTPCreatorLocation];
    self.portrait = [aDecoder decodeObjectForKey:kMovieRMTPCreatorPortrait];
    self.hometown = [aDecoder decodeObjectForKey:kMovieRMTPCreatorHometown];
    self.level = [aDecoder decodeDoubleForKey:kMovieRMTPCreatorLevel];
    self.veriInfo = [aDecoder decodeObjectForKey:kMovieRMTPCreatorVeriInfo];
    self.gender = [aDecoder decodeDoubleForKey:kMovieRMTPCreatorGender];
    self.profession = [aDecoder decodeObjectForKey:kMovieRMTPCreatorProfession];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeDouble:_creatorIdentifier forKey:kMovieRMTPCreatorId];
    [aCoder encodeObject:_thirdPlatform forKey:kMovieRMTPCreatorThirdPlatform];
    [aCoder encodeObject:_creatorDescription forKey:kMovieRMTPCreatorDescription];
    [aCoder encodeDouble:_rankVeri forKey:kMovieRMTPCreatorRankVeri];
    [aCoder encodeDouble:_gmutex forKey:kMovieRMTPCreatorGmutex];
    [aCoder encodeDouble:_verified forKey:kMovieRMTPCreatorVerified];
    [aCoder encodeObject:_emotion forKey:kMovieRMTPCreatorEmotion];
    [aCoder encodeObject:_nick forKey:kMovieRMTPCreatorNick];
    [aCoder encodeDouble:_inkeVerify forKey:kMovieRMTPCreatorInkeVerify];
    [aCoder encodeObject:_verifiedReason forKey:kMovieRMTPCreatorVerifiedReason];
    [aCoder encodeObject:_birth forKey:kMovieRMTPCreatorBirth];
    [aCoder encodeObject:_location forKey:kMovieRMTPCreatorLocation];
    [aCoder encodeObject:_portrait forKey:kMovieRMTPCreatorPortrait];
    [aCoder encodeObject:_hometown forKey:kMovieRMTPCreatorHometown];
    [aCoder encodeDouble:_level forKey:kMovieRMTPCreatorLevel];
    [aCoder encodeObject:_veriInfo forKey:kMovieRMTPCreatorVeriInfo];
    [aCoder encodeDouble:_gender forKey:kMovieRMTPCreatorGender];
    [aCoder encodeObject:_profession forKey:kMovieRMTPCreatorProfession];
}

-(id)copyWithZone:(NSZone *)zone
{
//    MovieRMTPCreator *copy = [[MovieRMTPCreator alloc]init];
    MovieRMTPCreator *copy = [[self class]allocWithZone:zone];
    if (copy) {
        copy.creatorIdentifier = self.creatorIdentifier;
        copy.thirdPlatform = [self.thirdPlatform copyWithZone:zone];
        copy.creatorDescription = [self.creatorDescription copyWithZone:zone];
        copy.rankVeri = self.rankVeri;
        copy.gmutex = self.gmutex;
        copy.verified = self.verified;
        copy.emotion = [self.emotion copyWithZone:zone];
        copy.nick = [self.nick copyWithZone:zone];
        copy.inkeVerify = self.inkeVerify;
        copy.verifiedReason = [self.verifiedReason copyWithZone:zone];
        copy.birth = [self.birth copyWithZone:zone];
        copy.location = [self.location copyWithZone:zone];
        copy.portrait = [self.portrait copyWithZone:zone];
        copy.hometown = [self.hometown copyWithZone:zone];
        copy.level = self.level;
        copy.veriInfo = [self.veriInfo copyWithZone:zone];
        copy.gender = self.gender;
        copy.profession = [self.profession copyWithZone:zone];
    }    
    return copy;
}






















































































@end
