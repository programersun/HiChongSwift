//
//  UserFansFriendsPets.m
//
//  Created by 超逸 李 on 15/1/27
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "UserFansFriendsPets.h"


NSString *const kUserFansFriendsPetsPetId = @"pet_id";
NSString *const kUserFansFriendsPetsHeadImage = @"head_image";


@interface UserFansFriendsPets ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserFansFriendsPets

@synthesize petId = _petId;
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
            self.petId = [self objectOrNilForKey:kUserFansFriendsPetsPetId fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kUserFansFriendsPetsHeadImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.petId forKey:kUserFansFriendsPetsPetId];
    [mutableDict setValue:self.headImage forKey:kUserFansFriendsPetsHeadImage];

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

    self.petId = [aDecoder decodeObjectForKey:kUserFansFriendsPetsPetId];
    self.headImage = [aDecoder decodeObjectForKey:kUserFansFriendsPetsHeadImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_petId forKey:kUserFansFriendsPetsPetId];
    [aCoder encodeObject:_headImage forKey:kUserFansFriendsPetsHeadImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserFansFriendsPets *copy = [[UserFansFriendsPets alloc] init];
    
    if (copy) {

        copy.petId = [self.petId copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
    }
    
    return copy;
}


@end
