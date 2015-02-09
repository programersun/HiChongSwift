//
//  TwitterCommentListStarList.m
//
//  Created by 超逸 李 on 15/2/9
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterCommentListStarList.h"


NSString *const kTwitterCommentListStarListUserId = @"user_id";
NSString *const kTwitterCommentListStarListHeadImage = @"head_image";


@interface TwitterCommentListStarList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterCommentListStarList

@synthesize userId = _userId;
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
            self.userId = [self objectOrNilForKey:kTwitterCommentListStarListUserId fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kTwitterCommentListStarListHeadImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userId forKey:kTwitterCommentListStarListUserId];
    [mutableDict setValue:self.headImage forKey:kTwitterCommentListStarListHeadImage];

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

    self.userId = [aDecoder decodeObjectForKey:kTwitterCommentListStarListUserId];
    self.headImage = [aDecoder decodeObjectForKey:kTwitterCommentListStarListHeadImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userId forKey:kTwitterCommentListStarListUserId];
    [aCoder encodeObject:_headImage forKey:kTwitterCommentListStarListHeadImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterCommentListStarList *copy = [[TwitterCommentListStarList alloc] init];
    
    if (copy) {

        copy.userId = [self.userId copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
    }
    
    return copy;
}


@end
