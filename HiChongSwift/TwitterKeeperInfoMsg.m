//
//  TwitterKeeperInfoMsg.m
//
//  Created by 超逸 李 on 15/1/9
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterKeeperInfoMsg.h"


NSString *const kTwitterKeeperInfoMsgUserId = @"user_id";
NSString *const kTwitterKeeperInfoMsgNickName = @"nick_name";
NSString *const kTwitterKeeperInfoMsgHeadImage = @"head_image";


@interface TwitterKeeperInfoMsg ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterKeeperInfoMsg

@synthesize userId = _userId;
@synthesize nickName = _nickName;
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
            self.userId = [self objectOrNilForKey:kTwitterKeeperInfoMsgUserId fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kTwitterKeeperInfoMsgNickName fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kTwitterKeeperInfoMsgHeadImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userId forKey:kTwitterKeeperInfoMsgUserId];
    [mutableDict setValue:self.nickName forKey:kTwitterKeeperInfoMsgNickName];
    [mutableDict setValue:self.headImage forKey:kTwitterKeeperInfoMsgHeadImage];

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

    self.userId = [aDecoder decodeObjectForKey:kTwitterKeeperInfoMsgUserId];
    self.nickName = [aDecoder decodeObjectForKey:kTwitterKeeperInfoMsgNickName];
    self.headImage = [aDecoder decodeObjectForKey:kTwitterKeeperInfoMsgHeadImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userId forKey:kTwitterKeeperInfoMsgUserId];
    [aCoder encodeObject:_nickName forKey:kTwitterKeeperInfoMsgNickName];
    [aCoder encodeObject:_headImage forKey:kTwitterKeeperInfoMsgHeadImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterKeeperInfoMsg *copy = [[TwitterKeeperInfoMsg alloc] init];
    
    if (copy) {

        copy.userId = [self.userId copyWithZone:zone];
        copy.nickName = [self.nickName copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
    }
    
    return copy;
}


@end
