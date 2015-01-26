//
//  TwitterListStarList.m
//
//  Created by 超逸 李 on 15/1/26
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterListStarList.h"


NSString *const kTwitterListStarListUserId = @"user_id";
NSString *const kTwitterListStarListHeadImage = @"head_image";


@interface TwitterListStarList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterListStarList

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
            self.userId = [self objectOrNilForKey:kTwitterListStarListUserId fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kTwitterListStarListHeadImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userId forKey:kTwitterListStarListUserId];
    [mutableDict setValue:self.headImage forKey:kTwitterListStarListHeadImage];

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

    self.userId = [aDecoder decodeObjectForKey:kTwitterListStarListUserId];
    self.headImage = [aDecoder decodeObjectForKey:kTwitterListStarListHeadImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userId forKey:kTwitterListStarListUserId];
    [aCoder encodeObject:_headImage forKey:kTwitterListStarListHeadImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterListStarList *copy = [[TwitterListStarList alloc] init];
    
    if (copy) {

        copy.userId = [self.userId copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
    }
    
    return copy;
}


@end
