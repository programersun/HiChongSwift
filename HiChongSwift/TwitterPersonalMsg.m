//
//  TwitterPersonalMsg.m
//
//  Created by 超逸 李 on 15/1/12
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterPersonalMsg.h"
#import "TwitterPersonalImages.h"


NSString *const kTwitterPersonalMsgPetName = @"pet_name";
NSString *const kTwitterPersonalMsgCommentCount = @"comment_count";
NSString *const kTwitterPersonalMsgTwitterLocation = @"twitter_location";
NSString *const kTwitterPersonalMsgStarCount = @"star_count";
NSString *const kTwitterPersonalMsgTwitterId = @"twitter_id";
NSString *const kTwitterPersonalMsgTwitterKeeper = @"twitter_keeper";
NSString *const kTwitterPersonalMsgTwitterLongitude = @"twitter_longitude";
NSString *const kTwitterPersonalMsgNickName = @"nick_name";
NSString *const kTwitterPersonalMsgTwitterContent = @"twitter_content";
NSString *const kTwitterPersonalMsgTwitterType = @"twitter_type";
NSString *const kTwitterPersonalMsgTwitterLatitude = @"twitter_latitude";
NSString *const kTwitterPersonalMsgTwitterPet = @"twitter_pet";
NSString *const kTwitterPersonalMsgPetImage = @"pet_image";
NSString *const kTwitterPersonalMsgImages = @"images";
NSString *const kTwitterPersonalMsgAddTime = @"add_time";


@interface TwitterPersonalMsg ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterPersonalMsg

@synthesize petName = _petName;
@synthesize commentCount = _commentCount;
@synthesize twitterLocation = _twitterLocation;
@synthesize starCount = _starCount;
@synthesize twitterId = _twitterId;
@synthesize twitterKeeper = _twitterKeeper;
@synthesize twitterLongitude = _twitterLongitude;
@synthesize nickName = _nickName;
@synthesize twitterContent = _twitterContent;
@synthesize twitterType = _twitterType;
@synthesize twitterLatitude = _twitterLatitude;
@synthesize twitterPet = _twitterPet;
@synthesize petImage = _petImage;
@synthesize images = _images;
@synthesize addTime = _addTime;


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
            self.petName = [self objectOrNilForKey:kTwitterPersonalMsgPetName fromDictionary:dict];
            self.commentCount = [self objectOrNilForKey:kTwitterPersonalMsgCommentCount fromDictionary:dict];
            self.twitterLocation = [self objectOrNilForKey:kTwitterPersonalMsgTwitterLocation fromDictionary:dict];
            self.starCount = [self objectOrNilForKey:kTwitterPersonalMsgStarCount fromDictionary:dict];
            self.twitterId = [self objectOrNilForKey:kTwitterPersonalMsgTwitterId fromDictionary:dict];
            self.twitterKeeper = [self objectOrNilForKey:kTwitterPersonalMsgTwitterKeeper fromDictionary:dict];
            self.twitterLongitude = [self objectOrNilForKey:kTwitterPersonalMsgTwitterLongitude fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kTwitterPersonalMsgNickName fromDictionary:dict];
            self.twitterContent = [self objectOrNilForKey:kTwitterPersonalMsgTwitterContent fromDictionary:dict];
            self.twitterType = [self objectOrNilForKey:kTwitterPersonalMsgTwitterType fromDictionary:dict];
            self.twitterLatitude = [self objectOrNilForKey:kTwitterPersonalMsgTwitterLatitude fromDictionary:dict];
            self.twitterPet = [self objectOrNilForKey:kTwitterPersonalMsgTwitterPet fromDictionary:dict];
            self.petImage = [self objectOrNilForKey:kTwitterPersonalMsgPetImage fromDictionary:dict];
    NSObject *receivedTwitterPersonalImages = [dict objectForKey:kTwitterPersonalMsgImages];
    NSMutableArray *parsedTwitterPersonalImages = [NSMutableArray array];
    if ([receivedTwitterPersonalImages isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTwitterPersonalImages) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTwitterPersonalImages addObject:[TwitterPersonalImages modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTwitterPersonalImages isKindOfClass:[NSDictionary class]]) {
       [parsedTwitterPersonalImages addObject:[TwitterPersonalImages modelObjectWithDictionary:(NSDictionary *)receivedTwitterPersonalImages]];
    }

    self.images = [NSArray arrayWithArray:parsedTwitterPersonalImages];
            self.addTime = [self objectOrNilForKey:kTwitterPersonalMsgAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.petName forKey:kTwitterPersonalMsgPetName];
    [mutableDict setValue:self.commentCount forKey:kTwitterPersonalMsgCommentCount];
    [mutableDict setValue:self.twitterLocation forKey:kTwitterPersonalMsgTwitterLocation];
    [mutableDict setValue:self.starCount forKey:kTwitterPersonalMsgStarCount];
    [mutableDict setValue:self.twitterId forKey:kTwitterPersonalMsgTwitterId];
    [mutableDict setValue:self.twitterKeeper forKey:kTwitterPersonalMsgTwitterKeeper];
    [mutableDict setValue:self.twitterLongitude forKey:kTwitterPersonalMsgTwitterLongitude];
    [mutableDict setValue:self.nickName forKey:kTwitterPersonalMsgNickName];
    [mutableDict setValue:self.twitterContent forKey:kTwitterPersonalMsgTwitterContent];
    [mutableDict setValue:self.twitterType forKey:kTwitterPersonalMsgTwitterType];
    [mutableDict setValue:self.twitterLatitude forKey:kTwitterPersonalMsgTwitterLatitude];
    [mutableDict setValue:self.twitterPet forKey:kTwitterPersonalMsgTwitterPet];
    [mutableDict setValue:self.petImage forKey:kTwitterPersonalMsgPetImage];
    NSMutableArray *tempArrayForImages = [NSMutableArray array];
    for (NSObject *subArrayObject in self.images) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImages addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImages addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImages] forKey:kTwitterPersonalMsgImages];
    [mutableDict setValue:self.addTime forKey:kTwitterPersonalMsgAddTime];

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

    self.petName = [aDecoder decodeObjectForKey:kTwitterPersonalMsgPetName];
    self.commentCount = [aDecoder decodeObjectForKey:kTwitterPersonalMsgCommentCount];
    self.twitterLocation = [aDecoder decodeObjectForKey:kTwitterPersonalMsgTwitterLocation];
    self.starCount = [aDecoder decodeObjectForKey:kTwitterPersonalMsgStarCount];
    self.twitterId = [aDecoder decodeObjectForKey:kTwitterPersonalMsgTwitterId];
    self.twitterKeeper = [aDecoder decodeObjectForKey:kTwitterPersonalMsgTwitterKeeper];
    self.twitterLongitude = [aDecoder decodeObjectForKey:kTwitterPersonalMsgTwitterLongitude];
    self.nickName = [aDecoder decodeObjectForKey:kTwitterPersonalMsgNickName];
    self.twitterContent = [aDecoder decodeObjectForKey:kTwitterPersonalMsgTwitterContent];
    self.twitterType = [aDecoder decodeObjectForKey:kTwitterPersonalMsgTwitterType];
    self.twitterLatitude = [aDecoder decodeObjectForKey:kTwitterPersonalMsgTwitterLatitude];
    self.twitterPet = [aDecoder decodeObjectForKey:kTwitterPersonalMsgTwitterPet];
    self.petImage = [aDecoder decodeObjectForKey:kTwitterPersonalMsgPetImage];
    self.images = [aDecoder decodeObjectForKey:kTwitterPersonalMsgImages];
    self.addTime = [aDecoder decodeObjectForKey:kTwitterPersonalMsgAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_petName forKey:kTwitterPersonalMsgPetName];
    [aCoder encodeObject:_commentCount forKey:kTwitterPersonalMsgCommentCount];
    [aCoder encodeObject:_twitterLocation forKey:kTwitterPersonalMsgTwitterLocation];
    [aCoder encodeObject:_starCount forKey:kTwitterPersonalMsgStarCount];
    [aCoder encodeObject:_twitterId forKey:kTwitterPersonalMsgTwitterId];
    [aCoder encodeObject:_twitterKeeper forKey:kTwitterPersonalMsgTwitterKeeper];
    [aCoder encodeObject:_twitterLongitude forKey:kTwitterPersonalMsgTwitterLongitude];
    [aCoder encodeObject:_nickName forKey:kTwitterPersonalMsgNickName];
    [aCoder encodeObject:_twitterContent forKey:kTwitterPersonalMsgTwitterContent];
    [aCoder encodeObject:_twitterType forKey:kTwitterPersonalMsgTwitterType];
    [aCoder encodeObject:_twitterLatitude forKey:kTwitterPersonalMsgTwitterLatitude];
    [aCoder encodeObject:_twitterPet forKey:kTwitterPersonalMsgTwitterPet];
    [aCoder encodeObject:_petImage forKey:kTwitterPersonalMsgPetImage];
    [aCoder encodeObject:_images forKey:kTwitterPersonalMsgImages];
    [aCoder encodeObject:_addTime forKey:kTwitterPersonalMsgAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterPersonalMsg *copy = [[TwitterPersonalMsg alloc] init];
    
    if (copy) {

        copy.petName = [self.petName copyWithZone:zone];
        copy.commentCount = [self.commentCount copyWithZone:zone];
        copy.twitterLocation = [self.twitterLocation copyWithZone:zone];
        copy.starCount = [self.starCount copyWithZone:zone];
        copy.twitterId = [self.twitterId copyWithZone:zone];
        copy.twitterKeeper = [self.twitterKeeper copyWithZone:zone];
        copy.twitterLongitude = [self.twitterLongitude copyWithZone:zone];
        copy.nickName = [self.nickName copyWithZone:zone];
        copy.twitterContent = [self.twitterContent copyWithZone:zone];
        copy.twitterType = [self.twitterType copyWithZone:zone];
        copy.twitterLatitude = [self.twitterLatitude copyWithZone:zone];
        copy.twitterPet = [self.twitterPet copyWithZone:zone];
        copy.petImage = [self.petImage copyWithZone:zone];
        copy.images = [self.images copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
