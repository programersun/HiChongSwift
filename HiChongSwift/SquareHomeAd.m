//
//  SquareHomeAd.m
//
//  Created by 超逸 李 on 15/1/4
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "SquareHomeAd.h"


NSString *const kSquareHomeAdAdId = @"ad_id";
NSString *const kSquareHomeAdBusinessId = @"business_id";
NSString *const kSquareHomeAdWebUrl = @"web_url";
NSString *const kSquareHomeAdTypeId = @"type_id";
NSString *const kSquareHomeAdAdImage = @"ad_image";
NSString *const kSquareHomeAdIsShow = @"is_show";
NSString *const kSquareHomeAdSortKey = @"sort_key";
NSString *const kSquareHomeAdAddTime = @"add_time";


@interface SquareHomeAd ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SquareHomeAd

@synthesize adId = _adId;
@synthesize businessId = _businessId;
@synthesize webUrl = _webUrl;
@synthesize typeId = _typeId;
@synthesize adImage = _adImage;
@synthesize isShow = _isShow;
@synthesize sortKey = _sortKey;
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
            self.adId = [self objectOrNilForKey:kSquareHomeAdAdId fromDictionary:dict];
            self.businessId = [self objectOrNilForKey:kSquareHomeAdBusinessId fromDictionary:dict];
            self.webUrl = [self objectOrNilForKey:kSquareHomeAdWebUrl fromDictionary:dict];
            self.typeId = [self objectOrNilForKey:kSquareHomeAdTypeId fromDictionary:dict];
            self.adImage = [self objectOrNilForKey:kSquareHomeAdAdImage fromDictionary:dict];
            self.isShow = [self objectOrNilForKey:kSquareHomeAdIsShow fromDictionary:dict];
            self.sortKey = [self objectOrNilForKey:kSquareHomeAdSortKey fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kSquareHomeAdAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.adId forKey:kSquareHomeAdAdId];
    [mutableDict setValue:self.businessId forKey:kSquareHomeAdBusinessId];
    [mutableDict setValue:self.webUrl forKey:kSquareHomeAdWebUrl];
    [mutableDict setValue:self.typeId forKey:kSquareHomeAdTypeId];
    [mutableDict setValue:self.adImage forKey:kSquareHomeAdAdImage];
    [mutableDict setValue:self.isShow forKey:kSquareHomeAdIsShow];
    [mutableDict setValue:self.sortKey forKey:kSquareHomeAdSortKey];
    [mutableDict setValue:self.addTime forKey:kSquareHomeAdAddTime];

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

    self.adId = [aDecoder decodeObjectForKey:kSquareHomeAdAdId];
    self.businessId = [aDecoder decodeObjectForKey:kSquareHomeAdBusinessId];
    self.webUrl = [aDecoder decodeObjectForKey:kSquareHomeAdWebUrl];
    self.typeId = [aDecoder decodeObjectForKey:kSquareHomeAdTypeId];
    self.adImage = [aDecoder decodeObjectForKey:kSquareHomeAdAdImage];
    self.isShow = [aDecoder decodeObjectForKey:kSquareHomeAdIsShow];
    self.sortKey = [aDecoder decodeObjectForKey:kSquareHomeAdSortKey];
    self.addTime = [aDecoder decodeObjectForKey:kSquareHomeAdAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_adId forKey:kSquareHomeAdAdId];
    [aCoder encodeObject:_businessId forKey:kSquareHomeAdBusinessId];
    [aCoder encodeObject:_webUrl forKey:kSquareHomeAdWebUrl];
    [aCoder encodeObject:_typeId forKey:kSquareHomeAdTypeId];
    [aCoder encodeObject:_adImage forKey:kSquareHomeAdAdImage];
    [aCoder encodeObject:_isShow forKey:kSquareHomeAdIsShow];
    [aCoder encodeObject:_sortKey forKey:kSquareHomeAdSortKey];
    [aCoder encodeObject:_addTime forKey:kSquareHomeAdAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    SquareHomeAd *copy = [[SquareHomeAd alloc] init];
    
    if (copy) {

        copy.adId = [self.adId copyWithZone:zone];
        copy.businessId = [self.businessId copyWithZone:zone];
        copy.webUrl = [self.webUrl copyWithZone:zone];
        copy.typeId = [self.typeId copyWithZone:zone];
        copy.adImage = [self.adImage copyWithZone:zone];
        copy.isShow = [self.isShow copyWithZone:zone];
        copy.sortKey = [self.sortKey copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
