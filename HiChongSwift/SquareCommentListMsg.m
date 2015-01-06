//
//  SquareCommentListMsg.m
//
//  Created by 超逸 李 on 15/1/6
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "SquareCommentListMsg.h"


NSString *const kSquareCommentListMsgNickName = @"nick_name";
NSString *const kSquareCommentListMsgContent = @"content";
NSString *const kSquareCommentListMsgUserId = @"user_id";
NSString *const kSquareCommentListMsgHeadImage = @"head_image";
NSString *const kSquareCommentListMsgCommentScore = @"comment_score";


@interface SquareCommentListMsg ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SquareCommentListMsg

@synthesize nickName = _nickName;
@synthesize content = _content;
@synthesize userId = _userId;
@synthesize headImage = _headImage;
@synthesize commentScore = _commentScore;


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
            self.nickName = [self objectOrNilForKey:kSquareCommentListMsgNickName fromDictionary:dict];
            self.content = [self objectOrNilForKey:kSquareCommentListMsgContent fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kSquareCommentListMsgUserId fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kSquareCommentListMsgHeadImage fromDictionary:dict];
            self.commentScore = [self objectOrNilForKey:kSquareCommentListMsgCommentScore fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kSquareCommentListMsgNickName];
    [mutableDict setValue:self.content forKey:kSquareCommentListMsgContent];
    [mutableDict setValue:self.userId forKey:kSquareCommentListMsgUserId];
    [mutableDict setValue:self.headImage forKey:kSquareCommentListMsgHeadImage];
    [mutableDict setValue:self.commentScore forKey:kSquareCommentListMsgCommentScore];

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

    self.nickName = [aDecoder decodeObjectForKey:kSquareCommentListMsgNickName];
    self.content = [aDecoder decodeObjectForKey:kSquareCommentListMsgContent];
    self.userId = [aDecoder decodeObjectForKey:kSquareCommentListMsgUserId];
    self.headImage = [aDecoder decodeObjectForKey:kSquareCommentListMsgHeadImage];
    self.commentScore = [aDecoder decodeObjectForKey:kSquareCommentListMsgCommentScore];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kSquareCommentListMsgNickName];
    [aCoder encodeObject:_content forKey:kSquareCommentListMsgContent];
    [aCoder encodeObject:_userId forKey:kSquareCommentListMsgUserId];
    [aCoder encodeObject:_headImage forKey:kSquareCommentListMsgHeadImage];
    [aCoder encodeObject:_commentScore forKey:kSquareCommentListMsgCommentScore];
}

- (id)copyWithZone:(NSZone *)zone
{
    SquareCommentListMsg *copy = [[SquareCommentListMsg alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.commentScore = [self.commentScore copyWithZone:zone];
    }
    
    return copy;
}


@end
