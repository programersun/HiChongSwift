//
//  TwitterListMsg.m
//
//  Created by 超逸 李 on 15/1/9
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterListMsg.h"
#import "TwitterListStarList.h"
#import "TwitterListImages.h"


NSString *const kTwitterListMsgPetName = @"pet_name";
NSString *const kTwitterListMsgStarList = @"star_list";
NSString *const kTwitterListMsgCommentCount = @"comment_count";
NSString *const kTwitterListMsgStarCount = @"star_count";
NSString *const kTwitterListMsgTwitterLocation = @"twitter_location";
NSString *const kTwitterListMsgTwitterId = @"twitter_id";
NSString *const kTwitterListMsgTwitterKeeper = @"twitter_keeper";
NSString *const kTwitterListMsgTwitterLongitude = @"twitter_longitude";
NSString *const kTwitterListMsgNickName = @"nick_name";
NSString *const kTwitterListMsgKeeperImage = @"keeper_image";
NSString *const kTwitterListMsgIsStar = @"is_star";
NSString *const kTwitterListMsgTwitterContent = @"twitter_content";
NSString *const kTwitterListMsgTwitterType = @"twitter_type";
NSString *const kTwitterListMsgTwitterLatitude = @"twitter_latitude";
NSString *const kTwitterListMsgTwitterPet = @"twitter_pet";
NSString *const kTwitterListMsgPetImage = @"pet_image";
NSString *const kTwitterListMsgImages = @"images";
NSString *const kTwitterListMsgAddTime = @"add_time";


@interface TwitterListMsg ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterListMsg

@synthesize petName = _petName;
@synthesize starList = _starList;
@synthesize commentCount = _commentCount;
@synthesize starCount = _starCount;
@synthesize twitterLocation = _twitterLocation;
@synthesize twitterId = _twitterId;
@synthesize twitterKeeper = _twitterKeeper;
@synthesize twitterLongitude = _twitterLongitude;
@synthesize nickName = _nickName;
@synthesize keeperImage = _keeperImage;
@synthesize isStar = _isStar;
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
            self.petName = [self objectOrNilForKey:kTwitterListMsgPetName fromDictionary:dict];
    NSObject *receivedTwitterListStarList = [dict objectForKey:kTwitterListMsgStarList];
    NSMutableArray *parsedTwitterListStarList = [NSMutableArray array];
    if ([receivedTwitterListStarList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTwitterListStarList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTwitterListStarList addObject:[TwitterListStarList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTwitterListStarList isKindOfClass:[NSDictionary class]]) {
       [parsedTwitterListStarList addObject:[TwitterListStarList modelObjectWithDictionary:(NSDictionary *)receivedTwitterListStarList]];
    }

    self.starList = [NSArray arrayWithArray:parsedTwitterListStarList];
            self.commentCount = [self objectOrNilForKey:kTwitterListMsgCommentCount fromDictionary:dict];
            self.starCount = [self objectOrNilForKey:kTwitterListMsgStarCount fromDictionary:dict];
            self.twitterLocation = [self objectOrNilForKey:kTwitterListMsgTwitterLocation fromDictionary:dict];
            self.twitterId = [self objectOrNilForKey:kTwitterListMsgTwitterId fromDictionary:dict];
            self.twitterKeeper = [self objectOrNilForKey:kTwitterListMsgTwitterKeeper fromDictionary:dict];
            self.twitterLongitude = [self objectOrNilForKey:kTwitterListMsgTwitterLongitude fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kTwitterListMsgNickName fromDictionary:dict];
            self.keeperImage = [self objectOrNilForKey:kTwitterListMsgKeeperImage fromDictionary:dict];
            self.isStar = [[self objectOrNilForKey:kTwitterListMsgIsStar fromDictionary:dict] doubleValue];
            self.twitterContent = [self objectOrNilForKey:kTwitterListMsgTwitterContent fromDictionary:dict];
            self.twitterType = [self objectOrNilForKey:kTwitterListMsgTwitterType fromDictionary:dict];
            self.twitterLatitude = [self objectOrNilForKey:kTwitterListMsgTwitterLatitude fromDictionary:dict];
            self.twitterPet = [self objectOrNilForKey:kTwitterListMsgTwitterPet fromDictionary:dict];
            self.petImage = [self objectOrNilForKey:kTwitterListMsgPetImage fromDictionary:dict];
    NSObject *receivedTwitterListImages = [dict objectForKey:kTwitterListMsgImages];
    NSMutableArray *parsedTwitterListImages = [NSMutableArray array];
    if ([receivedTwitterListImages isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTwitterListImages) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTwitterListImages addObject:[TwitterListImages modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTwitterListImages isKindOfClass:[NSDictionary class]]) {
       [parsedTwitterListImages addObject:[TwitterListImages modelObjectWithDictionary:(NSDictionary *)receivedTwitterListImages]];
    }

    self.images = [NSArray arrayWithArray:parsedTwitterListImages];
            self.addTime = [self objectOrNilForKey:kTwitterListMsgAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.petName forKey:kTwitterListMsgPetName];
    NSMutableArray *tempArrayForStarList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.starList) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForStarList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForStarList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForStarList] forKey:kTwitterListMsgStarList];
    [mutableDict setValue:self.commentCount forKey:kTwitterListMsgCommentCount];
    [mutableDict setValue:self.starCount forKey:kTwitterListMsgStarCount];
    [mutableDict setValue:self.twitterLocation forKey:kTwitterListMsgTwitterLocation];
    [mutableDict setValue:self.twitterId forKey:kTwitterListMsgTwitterId];
    [mutableDict setValue:self.twitterKeeper forKey:kTwitterListMsgTwitterKeeper];
    [mutableDict setValue:self.twitterLongitude forKey:kTwitterListMsgTwitterLongitude];
    [mutableDict setValue:self.nickName forKey:kTwitterListMsgNickName];
    [mutableDict setValue:self.keeperImage forKey:kTwitterListMsgKeeperImage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isStar] forKey:kTwitterListMsgIsStar];
    [mutableDict setValue:self.twitterContent forKey:kTwitterListMsgTwitterContent];
    [mutableDict setValue:self.twitterType forKey:kTwitterListMsgTwitterType];
    [mutableDict setValue:self.twitterLatitude forKey:kTwitterListMsgTwitterLatitude];
    [mutableDict setValue:self.twitterPet forKey:kTwitterListMsgTwitterPet];
    [mutableDict setValue:self.petImage forKey:kTwitterListMsgPetImage];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImages] forKey:kTwitterListMsgImages];
    [mutableDict setValue:self.addTime forKey:kTwitterListMsgAddTime];

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

    self.petName = [aDecoder decodeObjectForKey:kTwitterListMsgPetName];
    self.starList = [aDecoder decodeObjectForKey:kTwitterListMsgStarList];
    self.commentCount = [aDecoder decodeObjectForKey:kTwitterListMsgCommentCount];
    self.starCount = [aDecoder decodeObjectForKey:kTwitterListMsgStarCount];
    self.twitterLocation = [aDecoder decodeObjectForKey:kTwitterListMsgTwitterLocation];
    self.twitterId = [aDecoder decodeObjectForKey:kTwitterListMsgTwitterId];
    self.twitterKeeper = [aDecoder decodeObjectForKey:kTwitterListMsgTwitterKeeper];
    self.twitterLongitude = [aDecoder decodeObjectForKey:kTwitterListMsgTwitterLongitude];
    self.nickName = [aDecoder decodeObjectForKey:kTwitterListMsgNickName];
    self.keeperImage = [aDecoder decodeObjectForKey:kTwitterListMsgKeeperImage];
    self.isStar = [aDecoder decodeDoubleForKey:kTwitterListMsgIsStar];
    self.twitterContent = [aDecoder decodeObjectForKey:kTwitterListMsgTwitterContent];
    self.twitterType = [aDecoder decodeObjectForKey:kTwitterListMsgTwitterType];
    self.twitterLatitude = [aDecoder decodeObjectForKey:kTwitterListMsgTwitterLatitude];
    self.twitterPet = [aDecoder decodeObjectForKey:kTwitterListMsgTwitterPet];
    self.petImage = [aDecoder decodeObjectForKey:kTwitterListMsgPetImage];
    self.images = [aDecoder decodeObjectForKey:kTwitterListMsgImages];
    self.addTime = [aDecoder decodeObjectForKey:kTwitterListMsgAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_petName forKey:kTwitterListMsgPetName];
    [aCoder encodeObject:_starList forKey:kTwitterListMsgStarList];
    [aCoder encodeObject:_commentCount forKey:kTwitterListMsgCommentCount];
    [aCoder encodeObject:_starCount forKey:kTwitterListMsgStarCount];
    [aCoder encodeObject:_twitterLocation forKey:kTwitterListMsgTwitterLocation];
    [aCoder encodeObject:_twitterId forKey:kTwitterListMsgTwitterId];
    [aCoder encodeObject:_twitterKeeper forKey:kTwitterListMsgTwitterKeeper];
    [aCoder encodeObject:_twitterLongitude forKey:kTwitterListMsgTwitterLongitude];
    [aCoder encodeObject:_nickName forKey:kTwitterListMsgNickName];
    [aCoder encodeObject:_keeperImage forKey:kTwitterListMsgKeeperImage];
    [aCoder encodeDouble:_isStar forKey:kTwitterListMsgIsStar];
    [aCoder encodeObject:_twitterContent forKey:kTwitterListMsgTwitterContent];
    [aCoder encodeObject:_twitterType forKey:kTwitterListMsgTwitterType];
    [aCoder encodeObject:_twitterLatitude forKey:kTwitterListMsgTwitterLatitude];
    [aCoder encodeObject:_twitterPet forKey:kTwitterListMsgTwitterPet];
    [aCoder encodeObject:_petImage forKey:kTwitterListMsgPetImage];
    [aCoder encodeObject:_images forKey:kTwitterListMsgImages];
    [aCoder encodeObject:_addTime forKey:kTwitterListMsgAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterListMsg *copy = [[TwitterListMsg alloc] init];
    
    if (copy) {

        copy.petName = [self.petName copyWithZone:zone];
        copy.starList = [self.starList copyWithZone:zone];
        copy.commentCount = [self.commentCount copyWithZone:zone];
        copy.starCount = [self.starCount copyWithZone:zone];
        copy.twitterLocation = [self.twitterLocation copyWithZone:zone];
        copy.twitterId = [self.twitterId copyWithZone:zone];
        copy.twitterKeeper = [self.twitterKeeper copyWithZone:zone];
        copy.twitterLongitude = [self.twitterLongitude copyWithZone:zone];
        copy.nickName = [self.nickName copyWithZone:zone];
        copy.keeperImage = [self.keeperImage copyWithZone:zone];
        copy.isStar = self.isStar;
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
