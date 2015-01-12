//
//  UserFansFriendsMsg.m
//
//  Created by 超逸 李 on 15/1/12
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "UserFansFriendsMsg.h"


NSString *const kUserFansFriendsMsgNickName = @"nick_name";
NSString *const kUserFansFriendsMsgSex = @"sex";
NSString *const kUserFansFriendsMsgUserId = @"user_id";
NSString *const kUserFansFriendsMsgHeadImage = @"head_image";
NSString *const kUserFansFriendsMsgTip = @"tip";
NSString *const kUserFansFriendsMsgPetCount = @"pet_count";


@interface UserFansFriendsMsg ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserFansFriendsMsg

@synthesize nickName = _nickName;
@synthesize sex = _sex;
@synthesize userId = _userId;
@synthesize headImage = _headImage;
@synthesize tip = _tip;
@synthesize petCount = _petCount;


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
            self.nickName = [self objectOrNilForKey:kUserFansFriendsMsgNickName fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kUserFansFriendsMsgSex fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kUserFansFriendsMsgUserId fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kUserFansFriendsMsgHeadImage fromDictionary:dict];
            self.tip = [self objectOrNilForKey:kUserFansFriendsMsgTip fromDictionary:dict];
            self.petCount = [self objectOrNilForKey:kUserFansFriendsMsgPetCount fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kUserFansFriendsMsgNickName];
    [mutableDict setValue:self.sex forKey:kUserFansFriendsMsgSex];
    [mutableDict setValue:self.userId forKey:kUserFansFriendsMsgUserId];
    [mutableDict setValue:self.headImage forKey:kUserFansFriendsMsgHeadImage];
    [mutableDict setValue:self.tip forKey:kUserFansFriendsMsgTip];
    [mutableDict setValue:self.petCount forKey:kUserFansFriendsMsgPetCount];

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

    self.nickName = [aDecoder decodeObjectForKey:kUserFansFriendsMsgNickName];
    self.sex = [aDecoder decodeObjectForKey:kUserFansFriendsMsgSex];
    self.userId = [aDecoder decodeObjectForKey:kUserFansFriendsMsgUserId];
    self.headImage = [aDecoder decodeObjectForKey:kUserFansFriendsMsgHeadImage];
    self.tip = [aDecoder decodeObjectForKey:kUserFansFriendsMsgTip];
    self.petCount = [aDecoder decodeObjectForKey:kUserFansFriendsMsgPetCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kUserFansFriendsMsgNickName];
    [aCoder encodeObject:_sex forKey:kUserFansFriendsMsgSex];
    [aCoder encodeObject:_userId forKey:kUserFansFriendsMsgUserId];
    [aCoder encodeObject:_headImage forKey:kUserFansFriendsMsgHeadImage];
    [aCoder encodeObject:_tip forKey:kUserFansFriendsMsgTip];
    [aCoder encodeObject:_petCount forKey:kUserFansFriendsMsgPetCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserFansFriendsMsg *copy = [[UserFansFriendsMsg alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.tip = [self.tip copyWithZone:zone];
        copy.petCount = [self.petCount copyWithZone:zone];
    }
    
    return copy;
}


@end
