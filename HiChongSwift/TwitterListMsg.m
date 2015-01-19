//
//  TwitterListMsg.m
//
//  Created by 超逸 李 on 15/1/19
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterListMsg.h"
#import "TwitterListImages.h"
#import "TwitterListStarList.h"


NSString *const kTwitterListMsgTwitterLatitude = @"twitter_latitude";
NSString *const kTwitterListMsgTwitterType = @"twitter_type";
NSString *const kTwitterListMsgTwitterId = @"twitter_id";
NSString *const kTwitterListMsgCatId = @"cat_id";
NSString *const kTwitterListMsgTwitterPet = @"twitter_pet";
NSString *const kTwitterListMsgImages = @"images";
NSString *const kTwitterListMsgTwitterLongitude = @"twitter_longitude";
NSString *const kTwitterListMsgKeeperImage = @"keeper_image";
NSString *const kTwitterListMsgCateName = @"cate_name";
NSString *const kTwitterListMsgIsStar = @"is_star";
NSString *const kTwitterListMsgPetName = @"pet_name";
NSString *const kTwitterListMsgTwitterContent = @"twitter_content";
NSString *const kTwitterListMsgAddTime = @"add_time";
NSString *const kTwitterListMsgTwitterLocation = @"twitter_location";
NSString *const kTwitterListMsgPetImage = @"pet_image";
NSString *const kTwitterListMsgStarCount = @"star_count";
NSString *const kTwitterListMsgNickName = @"nick_name";
NSString *const kTwitterListMsgStarList = @"star_list";
NSString *const kTwitterListMsgCommentCount = @"comment_count";
NSString *const kTwitterListMsgTwitterKeeper = @"twitter_keeper";


@interface TwitterListMsg ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterListMsg

@synthesize twitterLatitude = _twitterLatitude;
@synthesize twitterType = _twitterType;
@synthesize twitterId = _twitterId;
@synthesize catId = _catId;
@synthesize twitterPet = _twitterPet;
@synthesize images = _images;
@synthesize twitterLongitude = _twitterLongitude;
@synthesize keeperImage = _keeperImage;
@synthesize cateName = _cateName;
@synthesize isStar = _isStar;
@synthesize petName = _petName;
@synthesize twitterContent = _twitterContent;
@synthesize addTime = _addTime;
@synthesize twitterLocation = _twitterLocation;
@synthesize petImage = _petImage;
@synthesize starCount = _starCount;
@synthesize nickName = _nickName;
@synthesize starList = _starList;
@synthesize commentCount = _commentCount;
@synthesize twitterKeeper = _twitterKeeper;


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
            self.twitterLatitude = [self objectOrNilForKey:kTwitterListMsgTwitterLatitude fromDictionary:dict];
            self.twitterType = [self objectOrNilForKey:kTwitterListMsgTwitterType fromDictionary:dict];
            self.twitterId = [self objectOrNilForKey:kTwitterListMsgTwitterId fromDictionary:dict];
            self.catId = [self objectOrNilForKey:kTwitterListMsgCatId fromDictionary:dict];
            self.twitterPet = [self objectOrNilForKey:kTwitterListMsgTwitterPet fromDictionary:dict];
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
            self.twitterLongitude = [self objectOrNilForKey:kTwitterListMsgTwitterLongitude fromDictionary:dict];
            self.keeperImage = [self objectOrNilForKey:kTwitterListMsgKeeperImage fromDictionary:dict];
            self.cateName = [self objectOrNilForKey:kTwitterListMsgCateName fromDictionary:dict];
            self.isStar = [[self objectOrNilForKey:kTwitterListMsgIsStar fromDictionary:dict] doubleValue];
            self.petName = [self objectOrNilForKey:kTwitterListMsgPetName fromDictionary:dict];
            self.twitterContent = [self objectOrNilForKey:kTwitterListMsgTwitterContent fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kTwitterListMsgAddTime fromDictionary:dict];
            self.twitterLocation = [self objectOrNilForKey:kTwitterListMsgTwitterLocation fromDictionary:dict];
            self.petImage = [self objectOrNilForKey:kTwitterListMsgPetImage fromDictionary:dict];
            self.starCount = [self objectOrNilForKey:kTwitterListMsgStarCount fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kTwitterListMsgNickName fromDictionary:dict];
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
            self.twitterKeeper = [self objectOrNilForKey:kTwitterListMsgTwitterKeeper fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.twitterLatitude forKey:kTwitterListMsgTwitterLatitude];
    [mutableDict setValue:self.twitterType forKey:kTwitterListMsgTwitterType];
    [mutableDict setValue:self.twitterId forKey:kTwitterListMsgTwitterId];
    [mutableDict setValue:self.catId forKey:kTwitterListMsgCatId];
    [mutableDict setValue:self.twitterPet forKey:kTwitterListMsgTwitterPet];
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
    [mutableDict setValue:self.twitterLongitude forKey:kTwitterListMsgTwitterLongitude];
    [mutableDict setValue:self.keeperImage forKey:kTwitterListMsgKeeperImage];
    [mutableDict setValue:self.cateName forKey:kTwitterListMsgCateName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isStar] forKey:kTwitterListMsgIsStar];
    [mutableDict setValue:self.petName forKey:kTwitterListMsgPetName];
    [mutableDict setValue:self.twitterContent forKey:kTwitterListMsgTwitterContent];
    [mutableDict setValue:self.addTime forKey:kTwitterListMsgAddTime];
    [mutableDict setValue:self.twitterLocation forKey:kTwitterListMsgTwitterLocation];
    [mutableDict setValue:self.petImage forKey:kTwitterListMsgPetImage];
    [mutableDict setValue:self.starCount forKey:kTwitterListMsgStarCount];
    [mutableDict setValue:self.nickName forKey:kTwitterListMsgNickName];
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
    [mutableDict setValue:self.twitterKeeper forKey:kTwitterListMsgTwitterKeeper];

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

    self.twitterLatitude = [aDecoder decodeObjectForKey:kTwitterListMsgTwitterLatitude];
    self.twitterType = [aDecoder decodeObjectForKey:kTwitterListMsgTwitterType];
    self.twitterId = [aDecoder decodeObjectForKey:kTwitterListMsgTwitterId];
    self.catId = [aDecoder decodeObjectForKey:kTwitterListMsgCatId];
    self.twitterPet = [aDecoder decodeObjectForKey:kTwitterListMsgTwitterPet];
    self.images = [aDecoder decodeObjectForKey:kTwitterListMsgImages];
    self.twitterLongitude = [aDecoder decodeObjectForKey:kTwitterListMsgTwitterLongitude];
    self.keeperImage = [aDecoder decodeObjectForKey:kTwitterListMsgKeeperImage];
    self.cateName = [aDecoder decodeObjectForKey:kTwitterListMsgCateName];
    self.isStar = [aDecoder decodeDoubleForKey:kTwitterListMsgIsStar];
    self.petName = [aDecoder decodeObjectForKey:kTwitterListMsgPetName];
    self.twitterContent = [aDecoder decodeObjectForKey:kTwitterListMsgTwitterContent];
    self.addTime = [aDecoder decodeObjectForKey:kTwitterListMsgAddTime];
    self.twitterLocation = [aDecoder decodeObjectForKey:kTwitterListMsgTwitterLocation];
    self.petImage = [aDecoder decodeObjectForKey:kTwitterListMsgPetImage];
    self.starCount = [aDecoder decodeObjectForKey:kTwitterListMsgStarCount];
    self.nickName = [aDecoder decodeObjectForKey:kTwitterListMsgNickName];
    self.starList = [aDecoder decodeObjectForKey:kTwitterListMsgStarList];
    self.commentCount = [aDecoder decodeObjectForKey:kTwitterListMsgCommentCount];
    self.twitterKeeper = [aDecoder decodeObjectForKey:kTwitterListMsgTwitterKeeper];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_twitterLatitude forKey:kTwitterListMsgTwitterLatitude];
    [aCoder encodeObject:_twitterType forKey:kTwitterListMsgTwitterType];
    [aCoder encodeObject:_twitterId forKey:kTwitterListMsgTwitterId];
    [aCoder encodeObject:_catId forKey:kTwitterListMsgCatId];
    [aCoder encodeObject:_twitterPet forKey:kTwitterListMsgTwitterPet];
    [aCoder encodeObject:_images forKey:kTwitterListMsgImages];
    [aCoder encodeObject:_twitterLongitude forKey:kTwitterListMsgTwitterLongitude];
    [aCoder encodeObject:_keeperImage forKey:kTwitterListMsgKeeperImage];
    [aCoder encodeObject:_cateName forKey:kTwitterListMsgCateName];
    [aCoder encodeDouble:_isStar forKey:kTwitterListMsgIsStar];
    [aCoder encodeObject:_petName forKey:kTwitterListMsgPetName];
    [aCoder encodeObject:_twitterContent forKey:kTwitterListMsgTwitterContent];
    [aCoder encodeObject:_addTime forKey:kTwitterListMsgAddTime];
    [aCoder encodeObject:_twitterLocation forKey:kTwitterListMsgTwitterLocation];
    [aCoder encodeObject:_petImage forKey:kTwitterListMsgPetImage];
    [aCoder encodeObject:_starCount forKey:kTwitterListMsgStarCount];
    [aCoder encodeObject:_nickName forKey:kTwitterListMsgNickName];
    [aCoder encodeObject:_starList forKey:kTwitterListMsgStarList];
    [aCoder encodeObject:_commentCount forKey:kTwitterListMsgCommentCount];
    [aCoder encodeObject:_twitterKeeper forKey:kTwitterListMsgTwitterKeeper];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterListMsg *copy = [[TwitterListMsg alloc] init];
    
    if (copy) {

        copy.twitterLatitude = [self.twitterLatitude copyWithZone:zone];
        copy.twitterType = [self.twitterType copyWithZone:zone];
        copy.twitterId = [self.twitterId copyWithZone:zone];
        copy.catId = [self.catId copyWithZone:zone];
        copy.twitterPet = [self.twitterPet copyWithZone:zone];
        copy.images = [self.images copyWithZone:zone];
        copy.twitterLongitude = [self.twitterLongitude copyWithZone:zone];
        copy.keeperImage = [self.keeperImage copyWithZone:zone];
        copy.cateName = [self.cateName copyWithZone:zone];
        copy.isStar = self.isStar;
        copy.petName = [self.petName copyWithZone:zone];
        copy.twitterContent = [self.twitterContent copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
        copy.twitterLocation = [self.twitterLocation copyWithZone:zone];
        copy.petImage = [self.petImage copyWithZone:zone];
        copy.starCount = [self.starCount copyWithZone:zone];
        copy.nickName = [self.nickName copyWithZone:zone];
        copy.starList = [self.starList copyWithZone:zone];
        copy.commentCount = [self.commentCount copyWithZone:zone];
        copy.twitterKeeper = [self.twitterKeeper copyWithZone:zone];
    }
    
    return copy;
}


@end
