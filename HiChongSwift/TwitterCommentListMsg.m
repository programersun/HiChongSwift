//
//  TwitterCommentListMsg.m
//
//  Created by 超逸 李 on 15/2/9
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterCommentListMsg.h"
#import "TwitterCommentListStarList.h"
#import "TwitterCommentListComment.h"
#import "TwitterCommentListImage.h"


NSString *const kTwitterCommentListMsgStarList = @"star_list";
NSString *const kTwitterCommentListMsgCommentCount = @"comment_count";
NSString *const kTwitterCommentListMsgHeadImage = @"head_image";
NSString *const kTwitterCommentListMsgStarCount = @"star_count";
NSString *const kTwitterCommentListMsgTwitterLocation = @"twitter_location";
NSString *const kTwitterCommentListMsgTwitterId = @"twitter_id";
NSString *const kTwitterCommentListMsgTwitterLongitude = @"twitter_longitude";
NSString *const kTwitterCommentListMsgNickName = @"nick_name";
NSString *const kTwitterCommentListMsgTwitterKeeper = @"twitter_keeper";
NSString *const kTwitterCommentListMsgComment = @"comment";
NSString *const kTwitterCommentListMsgTwitterContent = @"twitter_content";
NSString *const kTwitterCommentListMsgTwitterType = @"twitter_type";
NSString *const kTwitterCommentListMsgTwitterLatitude = @"twitter_latitude";
NSString *const kTwitterCommentListMsgImage = @"image";
NSString *const kTwitterCommentListMsgTwitterPet = @"twitter_pet";
NSString *const kTwitterCommentListMsgAddTime = @"add_time";


@interface TwitterCommentListMsg ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterCommentListMsg

@synthesize starList = _starList;
@synthesize commentCount = _commentCount;
@synthesize headImage = _headImage;
@synthesize starCount = _starCount;
@synthesize twitterLocation = _twitterLocation;
@synthesize twitterId = _twitterId;
@synthesize twitterLongitude = _twitterLongitude;
@synthesize nickName = _nickName;
@synthesize twitterKeeper = _twitterKeeper;
@synthesize comment = _comment;
@synthesize twitterContent = _twitterContent;
@synthesize twitterType = _twitterType;
@synthesize twitterLatitude = _twitterLatitude;
@synthesize image = _image;
@synthesize twitterPet = _twitterPet;
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
    NSObject *receivedTwitterCommentListStarList = [dict objectForKey:kTwitterCommentListMsgStarList];
    NSMutableArray *parsedTwitterCommentListStarList = [NSMutableArray array];
    if ([receivedTwitterCommentListStarList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTwitterCommentListStarList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTwitterCommentListStarList addObject:[TwitterCommentListStarList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTwitterCommentListStarList isKindOfClass:[NSDictionary class]]) {
       [parsedTwitterCommentListStarList addObject:[TwitterCommentListStarList modelObjectWithDictionary:(NSDictionary *)receivedTwitterCommentListStarList]];
    }

    self.starList = [NSArray arrayWithArray:parsedTwitterCommentListStarList];
            self.commentCount = [self objectOrNilForKey:kTwitterCommentListMsgCommentCount fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kTwitterCommentListMsgHeadImage fromDictionary:dict];
            self.starCount = [self objectOrNilForKey:kTwitterCommentListMsgStarCount fromDictionary:dict];
            self.twitterLocation = [self objectOrNilForKey:kTwitterCommentListMsgTwitterLocation fromDictionary:dict];
            self.twitterId = [self objectOrNilForKey:kTwitterCommentListMsgTwitterId fromDictionary:dict];
            self.twitterLongitude = [self objectOrNilForKey:kTwitterCommentListMsgTwitterLongitude fromDictionary:dict];
            self.nickName = [self objectOrNilForKey:kTwitterCommentListMsgNickName fromDictionary:dict];
            self.twitterKeeper = [self objectOrNilForKey:kTwitterCommentListMsgTwitterKeeper fromDictionary:dict];
    NSObject *receivedTwitterCommentListComment = [dict objectForKey:kTwitterCommentListMsgComment];
    NSMutableArray *parsedTwitterCommentListComment = [NSMutableArray array];
    if ([receivedTwitterCommentListComment isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTwitterCommentListComment) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTwitterCommentListComment addObject:[TwitterCommentListComment modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTwitterCommentListComment isKindOfClass:[NSDictionary class]]) {
       [parsedTwitterCommentListComment addObject:[TwitterCommentListComment modelObjectWithDictionary:(NSDictionary *)receivedTwitterCommentListComment]];
    }

    self.comment = [NSArray arrayWithArray:parsedTwitterCommentListComment];
            self.twitterContent = [self objectOrNilForKey:kTwitterCommentListMsgTwitterContent fromDictionary:dict];
            self.twitterType = [self objectOrNilForKey:kTwitterCommentListMsgTwitterType fromDictionary:dict];
            self.twitterLatitude = [self objectOrNilForKey:kTwitterCommentListMsgTwitterLatitude fromDictionary:dict];
    NSObject *receivedTwitterCommentListImage = [dict objectForKey:kTwitterCommentListMsgImage];
    NSMutableArray *parsedTwitterCommentListImage = [NSMutableArray array];
    if ([receivedTwitterCommentListImage isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTwitterCommentListImage) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTwitterCommentListImage addObject:[TwitterCommentListImage modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTwitterCommentListImage isKindOfClass:[NSDictionary class]]) {
       [parsedTwitterCommentListImage addObject:[TwitterCommentListImage modelObjectWithDictionary:(NSDictionary *)receivedTwitterCommentListImage]];
    }

    self.image = [NSArray arrayWithArray:parsedTwitterCommentListImage];
            self.twitterPet = [self objectOrNilForKey:kTwitterCommentListMsgTwitterPet fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kTwitterCommentListMsgAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForStarList] forKey:kTwitterCommentListMsgStarList];
    [mutableDict setValue:self.commentCount forKey:kTwitterCommentListMsgCommentCount];
    [mutableDict setValue:self.headImage forKey:kTwitterCommentListMsgHeadImage];
    [mutableDict setValue:self.starCount forKey:kTwitterCommentListMsgStarCount];
    [mutableDict setValue:self.twitterLocation forKey:kTwitterCommentListMsgTwitterLocation];
    [mutableDict setValue:self.twitterId forKey:kTwitterCommentListMsgTwitterId];
    [mutableDict setValue:self.twitterLongitude forKey:kTwitterCommentListMsgTwitterLongitude];
    [mutableDict setValue:self.nickName forKey:kTwitterCommentListMsgNickName];
    [mutableDict setValue:self.twitterKeeper forKey:kTwitterCommentListMsgTwitterKeeper];
    NSMutableArray *tempArrayForComment = [NSMutableArray array];
    for (NSObject *subArrayObject in self.comment) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForComment addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForComment addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForComment] forKey:kTwitterCommentListMsgComment];
    [mutableDict setValue:self.twitterContent forKey:kTwitterCommentListMsgTwitterContent];
    [mutableDict setValue:self.twitterType forKey:kTwitterCommentListMsgTwitterType];
    [mutableDict setValue:self.twitterLatitude forKey:kTwitterCommentListMsgTwitterLatitude];
    NSMutableArray *tempArrayForImage = [NSMutableArray array];
    for (NSObject *subArrayObject in self.image) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImage addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImage addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImage] forKey:kTwitterCommentListMsgImage];
    [mutableDict setValue:self.twitterPet forKey:kTwitterCommentListMsgTwitterPet];
    [mutableDict setValue:self.addTime forKey:kTwitterCommentListMsgAddTime];

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

    self.starList = [aDecoder decodeObjectForKey:kTwitterCommentListMsgStarList];
    self.commentCount = [aDecoder decodeObjectForKey:kTwitterCommentListMsgCommentCount];
    self.headImage = [aDecoder decodeObjectForKey:kTwitterCommentListMsgHeadImage];
    self.starCount = [aDecoder decodeObjectForKey:kTwitterCommentListMsgStarCount];
    self.twitterLocation = [aDecoder decodeObjectForKey:kTwitterCommentListMsgTwitterLocation];
    self.twitterId = [aDecoder decodeObjectForKey:kTwitterCommentListMsgTwitterId];
    self.twitterLongitude = [aDecoder decodeObjectForKey:kTwitterCommentListMsgTwitterLongitude];
    self.nickName = [aDecoder decodeObjectForKey:kTwitterCommentListMsgNickName];
    self.twitterKeeper = [aDecoder decodeObjectForKey:kTwitterCommentListMsgTwitterKeeper];
    self.comment = [aDecoder decodeObjectForKey:kTwitterCommentListMsgComment];
    self.twitterContent = [aDecoder decodeObjectForKey:kTwitterCommentListMsgTwitterContent];
    self.twitterType = [aDecoder decodeObjectForKey:kTwitterCommentListMsgTwitterType];
    self.twitterLatitude = [aDecoder decodeObjectForKey:kTwitterCommentListMsgTwitterLatitude];
    self.image = [aDecoder decodeObjectForKey:kTwitterCommentListMsgImage];
    self.twitterPet = [aDecoder decodeObjectForKey:kTwitterCommentListMsgTwitterPet];
    self.addTime = [aDecoder decodeObjectForKey:kTwitterCommentListMsgAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_starList forKey:kTwitterCommentListMsgStarList];
    [aCoder encodeObject:_commentCount forKey:kTwitterCommentListMsgCommentCount];
    [aCoder encodeObject:_headImage forKey:kTwitterCommentListMsgHeadImage];
    [aCoder encodeObject:_starCount forKey:kTwitterCommentListMsgStarCount];
    [aCoder encodeObject:_twitterLocation forKey:kTwitterCommentListMsgTwitterLocation];
    [aCoder encodeObject:_twitterId forKey:kTwitterCommentListMsgTwitterId];
    [aCoder encodeObject:_twitterLongitude forKey:kTwitterCommentListMsgTwitterLongitude];
    [aCoder encodeObject:_nickName forKey:kTwitterCommentListMsgNickName];
    [aCoder encodeObject:_twitterKeeper forKey:kTwitterCommentListMsgTwitterKeeper];
    [aCoder encodeObject:_comment forKey:kTwitterCommentListMsgComment];
    [aCoder encodeObject:_twitterContent forKey:kTwitterCommentListMsgTwitterContent];
    [aCoder encodeObject:_twitterType forKey:kTwitterCommentListMsgTwitterType];
    [aCoder encodeObject:_twitterLatitude forKey:kTwitterCommentListMsgTwitterLatitude];
    [aCoder encodeObject:_image forKey:kTwitterCommentListMsgImage];
    [aCoder encodeObject:_twitterPet forKey:kTwitterCommentListMsgTwitterPet];
    [aCoder encodeObject:_addTime forKey:kTwitterCommentListMsgAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterCommentListMsg *copy = [[TwitterCommentListMsg alloc] init];
    
    if (copy) {

        copy.starList = [self.starList copyWithZone:zone];
        copy.commentCount = [self.commentCount copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.starCount = [self.starCount copyWithZone:zone];
        copy.twitterLocation = [self.twitterLocation copyWithZone:zone];
        copy.twitterId = [self.twitterId copyWithZone:zone];
        copy.twitterLongitude = [self.twitterLongitude copyWithZone:zone];
        copy.nickName = [self.nickName copyWithZone:zone];
        copy.twitterKeeper = [self.twitterKeeper copyWithZone:zone];
        copy.comment = [self.comment copyWithZone:zone];
        copy.twitterContent = [self.twitterContent copyWithZone:zone];
        copy.twitterType = [self.twitterType copyWithZone:zone];
        copy.twitterLatitude = [self.twitterLatitude copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.twitterPet = [self.twitterPet copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
