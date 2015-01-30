//
//  TwitterRemindInfoStar.m
//
//  Created by 超逸 李 on 15/1/30
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterRemindInfoStar.h"


NSString *const kTwitterRemindInfoStarTwitterId = @"twitter_id";
NSString *const kTwitterRemindInfoStarAddTime = @"add_time";
NSString *const kTwitterRemindInfoStarKeeperId = @"keeper_id";
NSString *const kTwitterRemindInfoStarHeadImage = @"head_image";


@interface TwitterRemindInfoStar ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterRemindInfoStar

@synthesize twitterId = _twitterId;
@synthesize addTime = _addTime;
@synthesize keeperId = _keeperId;
@synthesize headImage = _headImage;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.twitterId = [self objectOrNilForKey:kTwitterRemindInfoStarTwitterId fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kTwitterRemindInfoStarAddTime fromDictionary:dict];
            self.keeperId = [self objectOrNilForKey:kTwitterRemindInfoStarKeeperId fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kTwitterRemindInfoStarHeadImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.twitterId forKey:kTwitterRemindInfoStarTwitterId];
    [mutableDict setValue:self.addTime forKey:kTwitterRemindInfoStarAddTime];
    [mutableDict setValue:self.keeperId forKey:kTwitterRemindInfoStarKeeperId];
    [mutableDict setValue:self.headImage forKey:kTwitterRemindInfoStarHeadImage];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.twitterId = [aDecoder decodeObjectForKey:kTwitterRemindInfoStarTwitterId];
    self.addTime = [aDecoder decodeObjectForKey:kTwitterRemindInfoStarAddTime];
    self.keeperId = [aDecoder decodeObjectForKey:kTwitterRemindInfoStarKeeperId];
    self.headImage = [aDecoder decodeObjectForKey:kTwitterRemindInfoStarHeadImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_twitterId forKey:kTwitterRemindInfoStarTwitterId];
    [aCoder encodeObject:_addTime forKey:kTwitterRemindInfoStarAddTime];
    [aCoder encodeObject:_keeperId forKey:kTwitterRemindInfoStarKeeperId];
    [aCoder encodeObject:_headImage forKey:kTwitterRemindInfoStarHeadImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterRemindInfoStar *copy = [[TwitterRemindInfoStar alloc] init];
    
    if (copy) {

        copy.twitterId = [self.twitterId copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
        copy.keeperId = [self.keeperId copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
    }
    
    return copy;
}


@end
