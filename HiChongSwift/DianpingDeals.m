//
//  DianpingDeals.m
//
//  Created by 超逸 李 on 15/1/7
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "DianpingDeals.h"


NSString *const kDianpingDealsId = @"id";
NSString *const kDianpingDealsUrl = @"url";
NSString *const kDianpingDealsDescription = @"description";


@interface DianpingDeals ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DianpingDeals

@synthesize dealsIdentifier = _dealsIdentifier;
@synthesize url = _url;
@synthesize dealsDescription = _dealsDescription;


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
            self.dealsIdentifier = [self objectOrNilForKey:kDianpingDealsId fromDictionary:dict];
            self.url = [self objectOrNilForKey:kDianpingDealsUrl fromDictionary:dict];
            self.dealsDescription = [self objectOrNilForKey:kDianpingDealsDescription fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.dealsIdentifier forKey:kDianpingDealsId];
    [mutableDict setValue:self.url forKey:kDianpingDealsUrl];
    [mutableDict setValue:self.dealsDescription forKey:kDianpingDealsDescription];

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

    self.dealsIdentifier = [aDecoder decodeObjectForKey:kDianpingDealsId];
    self.url = [aDecoder decodeObjectForKey:kDianpingDealsUrl];
    self.dealsDescription = [aDecoder decodeObjectForKey:kDianpingDealsDescription];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_dealsIdentifier forKey:kDianpingDealsId];
    [aCoder encodeObject:_url forKey:kDianpingDealsUrl];
    [aCoder encodeObject:_dealsDescription forKey:kDianpingDealsDescription];
}

- (id)copyWithZone:(NSZone *)zone
{
    DianpingDeals *copy = [[DianpingDeals alloc] init];
    
    if (copy) {

        copy.dealsIdentifier = [self.dealsIdentifier copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.dealsDescription = [self.dealsDescription copyWithZone:zone];
    }
    
    return copy;
}


@end
