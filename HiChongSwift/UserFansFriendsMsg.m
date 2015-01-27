//
//  UserFansFriendsMsg.m
//
//  Created by 超逸 李 on 15/1/27
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "UserFansFriendsMsg.h"
#import "UserFansFriendsPets.h"


NSString *const kUserFansFriendsMsgNickName = @"nick_name";
NSString *const kUserFansFriendsMsgHeadImage = @"head_image";
NSString *const kUserFansFriendsMsgLongitude = @"longitude";
NSString *const kUserFansFriendsMsgTip = @"tip";
NSString *const kUserFansFriendsMsgPets = @"pets";
NSString *const kUserFansFriendsMsgLatitude = @"latitude";
NSString *const kUserFansFriendsMsgUserId = @"user_id";
NSString *const kUserFansFriendsMsgSex = @"sex";
NSString *const kUserFansFriendsMsgPetCount = @"pet_count";


@interface UserFansFriendsMsg ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserFansFriendsMsg

@synthesize nickName = _nickName;
@synthesize headImage = _headImage;
@synthesize longitude = _longitude;
@synthesize tip = _tip;
@synthesize pets = _pets;
@synthesize latitude = _latitude;
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
            self.nickName = [self objectOrNilForKey:kUserFansFriendsMsgNickName fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kUserFansFriendsMsgHeadImage fromDictionary:dict];
            self.longitude = [self objectOrNilForKey:kUserFansFriendsMsgLongitude fromDictionary:dict];
            self.tip = [self objectOrNilForKey:kUserFansFriendsMsgTip fromDictionary:dict];
    NSObject *receivedUserFansFriendsPets = [dict objectForKey:kUserFansFriendsMsgPets];
    NSMutableArray *parsedUserFansFriendsPets = [NSMutableArray array];
    if ([receivedUserFansFriendsPets isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedUserFansFriendsPets) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedUserFansFriendsPets addObject:[UserFansFriendsPets modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedUserFansFriendsPets isKindOfClass:[NSDictionary class]]) {
       [parsedUserFansFriendsPets addObject:[UserFansFriendsPets modelObjectWithDictionary:(NSDictionary *)receivedUserFansFriendsPets]];
    }

    self.pets = [NSArray arrayWithArray:parsedUserFansFriendsPets];
            self.latitude = [self objectOrNilForKey:kUserFansFriendsMsgLatitude fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kUserFansFriendsMsgUserId fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kUserFansFriendsMsgSex fromDictionary:dict];
            self.petCount = [self objectOrNilForKey:kUserFansFriendsMsgPetCount fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kUserFansFriendsMsgNickName];
    [mutableDict setValue:self.headImage forKey:kUserFansFriendsMsgHeadImage];
    [mutableDict setValue:self.longitude forKey:kUserFansFriendsMsgLongitude];
    [mutableDict setValue:self.tip forKey:kUserFansFriendsMsgTip];
    NSMutableArray *tempArrayForPets = [NSMutableArray array];
    for (NSObject *subArrayObject in self.pets) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPets addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPets addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPets] forKey:kUserFansFriendsMsgPets];
    [mutableDict setValue:self.latitude forKey:kUserFansFriendsMsgLatitude];
    [mutableDict setValue:self.userId forKey:kUserFansFriendsMsgUserId];
    [mutableDict setValue:self.sex forKey:kUserFansFriendsMsgSex];
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
    self.headImage = [aDecoder decodeObjectForKey:kUserFansFriendsMsgHeadImage];
    self.longitude = [aDecoder decodeObjectForKey:kUserFansFriendsMsgLongitude];
    self.tip = [aDecoder decodeObjectForKey:kUserFansFriendsMsgTip];
    self.pets = [aDecoder decodeObjectForKey:kUserFansFriendsMsgPets];
    self.latitude = [aDecoder decodeObjectForKey:kUserFansFriendsMsgLatitude];
    self.userId = [aDecoder decodeObjectForKey:kUserFansFriendsMsgUserId];
    self.sex = [aDecoder decodeObjectForKey:kUserFansFriendsMsgSex];
    self.petCount = [aDecoder decodeObjectForKey:kUserFansFriendsMsgPetCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kUserFansFriendsMsgNickName];
    [aCoder encodeObject:_headImage forKey:kUserFansFriendsMsgHeadImage];
    [aCoder encodeObject:_longitude forKey:kUserFansFriendsMsgLongitude];
    [aCoder encodeObject:_tip forKey:kUserFansFriendsMsgTip];
    [aCoder encodeObject:_pets forKey:kUserFansFriendsMsgPets];
    [aCoder encodeObject:_latitude forKey:kUserFansFriendsMsgLatitude];
    [aCoder encodeObject:_userId forKey:kUserFansFriendsMsgUserId];
    [aCoder encodeObject:_sex forKey:kUserFansFriendsMsgSex];
    [aCoder encodeObject:_petCount forKey:kUserFansFriendsMsgPetCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserFansFriendsMsg *copy = [[UserFansFriendsMsg alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.longitude = [self.longitude copyWithZone:zone];
        copy.tip = [self.tip copyWithZone:zone];
        copy.pets = [self.pets copyWithZone:zone];
        copy.latitude = [self.latitude copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
        copy.petCount = [self.petCount copyWithZone:zone];
    }
    
    return copy;
}


@end
