//
//  UserSearchFriendPets.m
//
//  Created by 超逸 李 on 15/2/2
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "UserSearchFriendPets.h"


NSString *const kUserSearchFriendPetsPetId = @"pet_id";
NSString *const kUserSearchFriendPetsPetHeadImage = @"pet_head_image";


@interface UserSearchFriendPets ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserSearchFriendPets

@synthesize petId = _petId;
@synthesize petHeadImage = _petHeadImage;


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
            self.petId = [self objectOrNilForKey:kUserSearchFriendPetsPetId fromDictionary:dict];
            self.petHeadImage = [self objectOrNilForKey:kUserSearchFriendPetsPetHeadImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.petId forKey:kUserSearchFriendPetsPetId];
    [mutableDict setValue:self.petHeadImage forKey:kUserSearchFriendPetsPetHeadImage];

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

    self.petId = [aDecoder decodeObjectForKey:kUserSearchFriendPetsPetId];
    self.petHeadImage = [aDecoder decodeObjectForKey:kUserSearchFriendPetsPetHeadImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_petId forKey:kUserSearchFriendPetsPetId];
    [aCoder encodeObject:_petHeadImage forKey:kUserSearchFriendPetsPetHeadImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserSearchFriendPets *copy = [[UserSearchFriendPets alloc] init];
    
    if (copy) {

        copy.petId = [self.petId copyWithZone:zone];
        copy.petHeadImage = [self.petHeadImage copyWithZone:zone];
    }
    
    return copy;
}


@end
