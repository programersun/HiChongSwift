//
//  TwitterRemindInfoComment.m
//
//  Created by 超逸 李 on 15/1/30
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterRemindInfoComment.h"


NSString *const kTwitterRemindInfoCommentNickName = @"nick_name";
NSString *const kTwitterRemindInfoCommentTwitterId = @"twitter_id";
NSString *const kTwitterRemindInfoCommentContent = @"content";
NSString *const kTwitterRemindInfoCommentReceiveKeeper = @"receive_keeper";
NSString *const kTwitterRemindInfoCommentKeeperId = @"keeper_id";
NSString *const kTwitterRemindInfoCommentAddTime = @"add_time";


@interface TwitterRemindInfoComment ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterRemindInfoComment

@synthesize nickName = _nickName;
@synthesize twitterId = _twitterId;
@synthesize content = _content;
@synthesize receiveKeeper = _receiveKeeper;
@synthesize keeperId = _keeperId;
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
            self.nickName = [self objectOrNilForKey:kTwitterRemindInfoCommentNickName fromDictionary:dict];
            self.twitterId = [self objectOrNilForKey:kTwitterRemindInfoCommentTwitterId fromDictionary:dict];
            self.content = [self objectOrNilForKey:kTwitterRemindInfoCommentContent fromDictionary:dict];
            self.receiveKeeper = [self objectOrNilForKey:kTwitterRemindInfoCommentReceiveKeeper fromDictionary:dict];
            self.keeperId = [self objectOrNilForKey:kTwitterRemindInfoCommentKeeperId fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kTwitterRemindInfoCommentAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kTwitterRemindInfoCommentNickName];
    [mutableDict setValue:self.twitterId forKey:kTwitterRemindInfoCommentTwitterId];
    [mutableDict setValue:self.content forKey:kTwitterRemindInfoCommentContent];
    [mutableDict setValue:self.receiveKeeper forKey:kTwitterRemindInfoCommentReceiveKeeper];
    [mutableDict setValue:self.keeperId forKey:kTwitterRemindInfoCommentKeeperId];
    [mutableDict setValue:self.addTime forKey:kTwitterRemindInfoCommentAddTime];

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

    self.nickName = [aDecoder decodeObjectForKey:kTwitterRemindInfoCommentNickName];
    self.twitterId = [aDecoder decodeObjectForKey:kTwitterRemindInfoCommentTwitterId];
    self.content = [aDecoder decodeObjectForKey:kTwitterRemindInfoCommentContent];
    self.receiveKeeper = [aDecoder decodeObjectForKey:kTwitterRemindInfoCommentReceiveKeeper];
    self.keeperId = [aDecoder decodeObjectForKey:kTwitterRemindInfoCommentKeeperId];
    self.addTime = [aDecoder decodeObjectForKey:kTwitterRemindInfoCommentAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kTwitterRemindInfoCommentNickName];
    [aCoder encodeObject:_twitterId forKey:kTwitterRemindInfoCommentTwitterId];
    [aCoder encodeObject:_content forKey:kTwitterRemindInfoCommentContent];
    [aCoder encodeObject:_receiveKeeper forKey:kTwitterRemindInfoCommentReceiveKeeper];
    [aCoder encodeObject:_keeperId forKey:kTwitterRemindInfoCommentKeeperId];
    [aCoder encodeObject:_addTime forKey:kTwitterRemindInfoCommentAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterRemindInfoComment *copy = [[TwitterRemindInfoComment alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.twitterId = [self.twitterId copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
        copy.receiveKeeper = [self.receiveKeeper copyWithZone:zone];
        copy.keeperId = [self.keeperId copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
