//
//  TwitterCommentListComment.m
//
//  Created by 超逸 李 on 15/1/14
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterCommentListComment.h"


NSString *const kTwitterCommentListCommentAddTime = @"add_time";
NSString *const kTwitterCommentListCommentCommentId = @"comment_id";
NSString *const kTwitterCommentListCommentContent = @"content";
NSString *const kTwitterCommentListCommentReceiveKeeper = @"receive_keeper";
NSString *const kTwitterCommentListCommentKeeperId = @"keeper_id";
NSString *const kTwitterCommentListCommentReceiverName = @"receiver_name";
NSString *const kTwitterCommentListCommentKeeperName = @"keeper_name";
NSString *const kTwitterCommentListCommentTwitterId = @"twitter_id";


@interface TwitterCommentListComment ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterCommentListComment

@synthesize addTime = _addTime;
@synthesize commentId = _commentId;
@synthesize content = _content;
@synthesize receiveKeeper = _receiveKeeper;
@synthesize keeperId = _keeperId;
@synthesize receiverName = _receiverName;
@synthesize keeperName = _keeperName;
@synthesize twitterId = _twitterId;


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
            self.addTime = [self objectOrNilForKey:kTwitterCommentListCommentAddTime fromDictionary:dict];
            self.commentId = [self objectOrNilForKey:kTwitterCommentListCommentCommentId fromDictionary:dict];
            self.content = [self objectOrNilForKey:kTwitterCommentListCommentContent fromDictionary:dict];
            self.receiveKeeper = [self objectOrNilForKey:kTwitterCommentListCommentReceiveKeeper fromDictionary:dict];
            self.keeperId = [self objectOrNilForKey:kTwitterCommentListCommentKeeperId fromDictionary:dict];
            self.receiverName = [self objectOrNilForKey:kTwitterCommentListCommentReceiverName fromDictionary:dict];
            self.keeperName = [self objectOrNilForKey:kTwitterCommentListCommentKeeperName fromDictionary:dict];
            self.twitterId = [self objectOrNilForKey:kTwitterCommentListCommentTwitterId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.addTime forKey:kTwitterCommentListCommentAddTime];
    [mutableDict setValue:self.commentId forKey:kTwitterCommentListCommentCommentId];
    [mutableDict setValue:self.content forKey:kTwitterCommentListCommentContent];
    [mutableDict setValue:self.receiveKeeper forKey:kTwitterCommentListCommentReceiveKeeper];
    [mutableDict setValue:self.keeperId forKey:kTwitterCommentListCommentKeeperId];
    [mutableDict setValue:self.receiverName forKey:kTwitterCommentListCommentReceiverName];
    [mutableDict setValue:self.keeperName forKey:kTwitterCommentListCommentKeeperName];
    [mutableDict setValue:self.twitterId forKey:kTwitterCommentListCommentTwitterId];

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

    self.addTime = [aDecoder decodeObjectForKey:kTwitterCommentListCommentAddTime];
    self.commentId = [aDecoder decodeObjectForKey:kTwitterCommentListCommentCommentId];
    self.content = [aDecoder decodeObjectForKey:kTwitterCommentListCommentContent];
    self.receiveKeeper = [aDecoder decodeObjectForKey:kTwitterCommentListCommentReceiveKeeper];
    self.keeperId = [aDecoder decodeObjectForKey:kTwitterCommentListCommentKeeperId];
    self.receiverName = [aDecoder decodeObjectForKey:kTwitterCommentListCommentReceiverName];
    self.keeperName = [aDecoder decodeObjectForKey:kTwitterCommentListCommentKeeperName];
    self.twitterId = [aDecoder decodeObjectForKey:kTwitterCommentListCommentTwitterId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_addTime forKey:kTwitterCommentListCommentAddTime];
    [aCoder encodeObject:_commentId forKey:kTwitterCommentListCommentCommentId];
    [aCoder encodeObject:_content forKey:kTwitterCommentListCommentContent];
    [aCoder encodeObject:_receiveKeeper forKey:kTwitterCommentListCommentReceiveKeeper];
    [aCoder encodeObject:_keeperId forKey:kTwitterCommentListCommentKeeperId];
    [aCoder encodeObject:_receiverName forKey:kTwitterCommentListCommentReceiverName];
    [aCoder encodeObject:_keeperName forKey:kTwitterCommentListCommentKeeperName];
    [aCoder encodeObject:_twitterId forKey:kTwitterCommentListCommentTwitterId];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterCommentListComment *copy = [[TwitterCommentListComment alloc] init];
    
    if (copy) {

        copy.addTime = [self.addTime copyWithZone:zone];
        copy.commentId = [self.commentId copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
        copy.receiveKeeper = [self.receiveKeeper copyWithZone:zone];
        copy.keeperId = [self.keeperId copyWithZone:zone];
        copy.receiverName = [self.receiverName copyWithZone:zone];
        copy.keeperName = [self.keeperName copyWithZone:zone];
        copy.twitterId = [self.twitterId copyWithZone:zone];
    }
    
    return copy;
}


@end
