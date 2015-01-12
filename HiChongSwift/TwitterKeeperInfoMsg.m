//
//  TwitterKeeperInfoMsg.m
//
//  Created by 超逸 李 on 15/1/12
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterKeeperInfoMsg.h"


NSString *const kTwitterKeeperInfoMsgNickName = @"nick_name";
NSString *const kTwitterKeeperInfoMsgIsAttention = @"is_attention";
NSString *const kTwitterKeeperInfoMsgUserId = @"user_id";
NSString *const kTwitterKeeperInfoMsgHeadImage = @"head_image";
NSString *const kTwitterKeeperInfoMsgTip = @"tip";
NSString *const kTwitterKeeperInfoMsgBgImage = @"bg_image";


@interface TwitterKeeperInfoMsg ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterKeeperInfoMsg

@synthesize nickName = _nickName;
@synthesize isAttention = _isAttention;
@synthesize userId = _userId;
@synthesize headImage = _headImage;
@synthesize tip = _tip;
@synthesize bgImage = _bgImage;


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
            self.nickName = [self objectOrNilForKey:kTwitterKeeperInfoMsgNickName fromDictionary:dict];
            self.isAttention = [[self objectOrNilForKey:kTwitterKeeperInfoMsgIsAttention fromDictionary:dict] doubleValue];
            self.userId = [self objectOrNilForKey:kTwitterKeeperInfoMsgUserId fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kTwitterKeeperInfoMsgHeadImage fromDictionary:dict];
            self.tip = [self objectOrNilForKey:kTwitterKeeperInfoMsgTip fromDictionary:dict];
            self.bgImage = [self objectOrNilForKey:kTwitterKeeperInfoMsgBgImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kTwitterKeeperInfoMsgNickName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isAttention] forKey:kTwitterKeeperInfoMsgIsAttention];
    [mutableDict setValue:self.userId forKey:kTwitterKeeperInfoMsgUserId];
    [mutableDict setValue:self.headImage forKey:kTwitterKeeperInfoMsgHeadImage];
    [mutableDict setValue:self.tip forKey:kTwitterKeeperInfoMsgTip];
    [mutableDict setValue:self.bgImage forKey:kTwitterKeeperInfoMsgBgImage];

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

    self.nickName = [aDecoder decodeObjectForKey:kTwitterKeeperInfoMsgNickName];
    self.isAttention = [aDecoder decodeDoubleForKey:kTwitterKeeperInfoMsgIsAttention];
    self.userId = [aDecoder decodeObjectForKey:kTwitterKeeperInfoMsgUserId];
    self.headImage = [aDecoder decodeObjectForKey:kTwitterKeeperInfoMsgHeadImage];
    self.tip = [aDecoder decodeObjectForKey:kTwitterKeeperInfoMsgTip];
    self.bgImage = [aDecoder decodeObjectForKey:kTwitterKeeperInfoMsgBgImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kTwitterKeeperInfoMsgNickName];
    [aCoder encodeDouble:_isAttention forKey:kTwitterKeeperInfoMsgIsAttention];
    [aCoder encodeObject:_userId forKey:kTwitterKeeperInfoMsgUserId];
    [aCoder encodeObject:_headImage forKey:kTwitterKeeperInfoMsgHeadImage];
    [aCoder encodeObject:_tip forKey:kTwitterKeeperInfoMsgTip];
    [aCoder encodeObject:_bgImage forKey:kTwitterKeeperInfoMsgBgImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterKeeperInfoMsg *copy = [[TwitterKeeperInfoMsg alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.isAttention = self.isAttention;
        copy.userId = [self.userId copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.tip = [self.tip copyWithZone:zone];
        copy.bgImage = [self.bgImage copyWithZone:zone];
    }
    
    return copy;
}


@end
