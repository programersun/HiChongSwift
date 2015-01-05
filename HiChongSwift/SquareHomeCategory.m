//
//  SquareHomeCategory.m
//
//  Created by 超逸 李 on 15/1/4
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "SquareHomeCategory.h"


NSString *const kSquareHomeCategoryCateId = @"cate_id";
NSString *const kSquareHomeCategoryCateName = @"cate_name";
NSString *const kSquareHomeCategoryIsLock = @"is_lock";
NSString *const kSquareHomeCategorySortKey = @"sort_key";


@interface SquareHomeCategory ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SquareHomeCategory

@synthesize cateId = _cateId;
@synthesize cateName = _cateName;
@synthesize isLock = _isLock;
@synthesize sortKey = _sortKey;


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
            self.cateId = [self objectOrNilForKey:kSquareHomeCategoryCateId fromDictionary:dict];
            self.cateName = [self objectOrNilForKey:kSquareHomeCategoryCateName fromDictionary:dict];
            self.isLock = [self objectOrNilForKey:kSquareHomeCategoryIsLock fromDictionary:dict];
            self.sortKey = [self objectOrNilForKey:kSquareHomeCategorySortKey fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cateId forKey:kSquareHomeCategoryCateId];
    [mutableDict setValue:self.cateName forKey:kSquareHomeCategoryCateName];
    [mutableDict setValue:self.isLock forKey:kSquareHomeCategoryIsLock];
    [mutableDict setValue:self.sortKey forKey:kSquareHomeCategorySortKey];

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

    self.cateId = [aDecoder decodeObjectForKey:kSquareHomeCategoryCateId];
    self.cateName = [aDecoder decodeObjectForKey:kSquareHomeCategoryCateName];
    self.isLock = [aDecoder decodeObjectForKey:kSquareHomeCategoryIsLock];
    self.sortKey = [aDecoder decodeObjectForKey:kSquareHomeCategorySortKey];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cateId forKey:kSquareHomeCategoryCateId];
    [aCoder encodeObject:_cateName forKey:kSquareHomeCategoryCateName];
    [aCoder encodeObject:_isLock forKey:kSquareHomeCategoryIsLock];
    [aCoder encodeObject:_sortKey forKey:kSquareHomeCategorySortKey];
}

- (id)copyWithZone:(NSZone *)zone
{
    SquareHomeCategory *copy = [[SquareHomeCategory alloc] init];
    
    if (copy) {

        copy.cateId = [self.cateId copyWithZone:zone];
        copy.cateName = [self.cateName copyWithZone:zone];
        copy.isLock = [self.isLock copyWithZone:zone];
        copy.sortKey = [self.sortKey copyWithZone:zone];
    }
    
    return copy;
}


@end
