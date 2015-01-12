//
//  UserSearchFriendMsg.m
//
//  Created by 超逸 李 on 15/1/13
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "UserSearchFriendMsg.h"


NSString *const kUserSearchFriendMsgNickName = @"nick_name";
NSString *const kUserSearchFriendMsgHeadImage = @"head_image";
NSString *const kUserSearchFriendMsgTip = @"tip";
NSString *const kUserSearchFriendMsgDistance = @"distance";
NSString *const kUserSearchFriendMsgUserId = @"user_id";
NSString *const kUserSearchFriendMsgSex = @"sex";
NSString *const kUserSearchFriendMsgPetCount = @"pet_count";


@interface UserSearchFriendMsg ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserSearchFriendMsg

@synthesize nickName = _nickName;
@synthesize headImage = _headImage;
@synthesize tip = _tip;
@synthesize distance = _distance;
@synthesize userId = _userId;
@synthesize sex = _sex;
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
            self.nickName = [self objectOrNilForKey:kUserSearchFriendMsgNickName fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kUserSearchFriendMsgHeadImage fromDictionary:dict];
            self.tip = [self objectOrNilForKey:kUserSearchFriendMsgTip fromDictionary:dict];
            self.distance = [self objectOrNilForKey:kUserSearchFriendMsgDistance fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kUserSearchFriendMsgUserId fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kUserSearchFriendMsgSex fromDictionary:dict];
            self.petCount = [self objectOrNilForKey:kUserSearchFriendMsgPetCount fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kUserSearchFriendMsgNickName];
    [mutableDict setValue:self.headImage forKey:kUserSearchFriendMsgHeadImage];
    [mutableDict setValue:self.tip forKey:kUserSearchFriendMsgTip];
    [mutableDict setValue:self.distance forKey:kUserSearchFriendMsgDistance];
    [mutableDict setValue:self.userId forKey:kUserSearchFriendMsgUserId];
    [mutableDict setValue:self.sex forKey:kUserSearchFriendMsgSex];
    [mutableDict setValue:self.petCount forKey:kUserSearchFriendMsgPetCount];

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

    self.nickName = [aDecoder decodeObjectForKey:kUserSearchFriendMsgNickName];
    self.headImage = [aDecoder decodeObjectForKey:kUserSearchFriendMsgHeadImage];
    self.tip = [aDecoder decodeObjectForKey:kUserSearchFriendMsgTip];
    self.distance = [aDecoder decodeObjectForKey:kUserSearchFriendMsgDistance];
    self.userId = [aDecoder decodeObjectForKey:kUserSearchFriendMsgUserId];
    self.sex = [aDecoder decodeObjectForKey:kUserSearchFriendMsgSex];
    self.petCount = [aDecoder decodeObjectForKey:kUserSearchFriendMsgPetCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kUserSearchFriendMsgNickName];
    [aCoder encodeObject:_headImage forKey:kUserSearchFriendMsgHeadImage];
    [aCoder encodeObject:_tip forKey:kUserSearchFriendMsgTip];
    [aCoder encodeObject:_distance forKey:kUserSearchFriendMsgDistance];
    [aCoder encodeObject:_userId forKey:kUserSearchFriendMsgUserId];
    [aCoder encodeObject:_sex forKey:kUserSearchFriendMsgSex];
    [aCoder encodeObject:_petCount forKey:kUserSearchFriendMsgPetCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserSearchFriendMsg *copy = [[UserSearchFriendMsg alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.tip = [self.tip copyWithZone:zone];
        copy.distance = [self.distance copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
        copy.petCount = [self.petCount copyWithZone:zone];
    }
    
    return copy;
}


@end
