//
//  TwitterRemindInfoMsg.m
//
//  Created by 超逸 李 on 15/1/30
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterRemindInfoMsg.h"
#import "TwitterRemindInfoComment.h"
#import "TwitterRemindInfoStar.h"


NSString *const kTwitterRemindInfoMsgComment = @"comment";
NSString *const kTwitterRemindInfoMsgStar = @"star";
NSString *const kTwitterRemindInfoMsgHeadImage = @"head_image";


@interface TwitterRemindInfoMsg ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterRemindInfoMsg

@synthesize comment = _comment;
@synthesize star = _star;
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
    NSObject *receivedTwitterRemindInfoComment = [dict objectForKey:kTwitterRemindInfoMsgComment];
    NSMutableArray *parsedTwitterRemindInfoComment = [NSMutableArray array];
    if ([receivedTwitterRemindInfoComment isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTwitterRemindInfoComment) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTwitterRemindInfoComment addObject:[TwitterRemindInfoComment modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTwitterRemindInfoComment isKindOfClass:[NSDictionary class]]) {
       [parsedTwitterRemindInfoComment addObject:[TwitterRemindInfoComment modelObjectWithDictionary:(NSDictionary *)receivedTwitterRemindInfoComment]];
    }

    self.comment = [NSArray arrayWithArray:parsedTwitterRemindInfoComment];
    NSObject *receivedTwitterRemindInfoStar = [dict objectForKey:kTwitterRemindInfoMsgStar];
    NSMutableArray *parsedTwitterRemindInfoStar = [NSMutableArray array];
    if ([receivedTwitterRemindInfoStar isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTwitterRemindInfoStar) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTwitterRemindInfoStar addObject:[TwitterRemindInfoStar modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTwitterRemindInfoStar isKindOfClass:[NSDictionary class]]) {
       [parsedTwitterRemindInfoStar addObject:[TwitterRemindInfoStar modelObjectWithDictionary:(NSDictionary *)receivedTwitterRemindInfoStar]];
    }

    self.star = [NSArray arrayWithArray:parsedTwitterRemindInfoStar];
            self.headImage = [self objectOrNilForKey:kTwitterRemindInfoMsgHeadImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForComment] forKey:kTwitterRemindInfoMsgComment];
    NSMutableArray *tempArrayForStar = [NSMutableArray array];
    for (NSObject *subArrayObject in self.star) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForStar addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForStar addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForStar] forKey:kTwitterRemindInfoMsgStar];
    [mutableDict setValue:self.headImage forKey:kTwitterRemindInfoMsgHeadImage];

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

    self.comment = [aDecoder decodeObjectForKey:kTwitterRemindInfoMsgComment];
    self.star = [aDecoder decodeObjectForKey:kTwitterRemindInfoMsgStar];
    self.headImage = [aDecoder decodeObjectForKey:kTwitterRemindInfoMsgHeadImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_comment forKey:kTwitterRemindInfoMsgComment];
    [aCoder encodeObject:_star forKey:kTwitterRemindInfoMsgStar];
    [aCoder encodeObject:_headImage forKey:kTwitterRemindInfoMsgHeadImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterRemindInfoMsg *copy = [[TwitterRemindInfoMsg alloc] init];
    
    if (copy) {

        copy.comment = [self.comment copyWithZone:zone];
        copy.star = [self.star copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
    }
    
    return copy;
}


@end
