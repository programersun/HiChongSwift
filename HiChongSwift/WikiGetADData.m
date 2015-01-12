//
//  WikiGetADData.m
//
//  Created by 超逸 李 on 15/1/13
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "WikiGetADData.h"


NSString *const kWikiGetADDataAddTime = @"add_time";
NSString *const kWikiGetADDataAdId = @"ad_id";
NSString *const kWikiGetADDataEncyId = @"ency_id";
NSString *const kWikiGetADDataImage = @"image";


@interface WikiGetADData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WikiGetADData

@synthesize addTime = _addTime;
@synthesize adId = _adId;
@synthesize encyId = _encyId;
@synthesize image = _image;


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
            self.addTime = [self objectOrNilForKey:kWikiGetADDataAddTime fromDictionary:dict];
            self.adId = [self objectOrNilForKey:kWikiGetADDataAdId fromDictionary:dict];
            self.encyId = [self objectOrNilForKey:kWikiGetADDataEncyId fromDictionary:dict];
            self.image = [self objectOrNilForKey:kWikiGetADDataImage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.addTime forKey:kWikiGetADDataAddTime];
    [mutableDict setValue:self.adId forKey:kWikiGetADDataAdId];
    [mutableDict setValue:self.encyId forKey:kWikiGetADDataEncyId];
    [mutableDict setValue:self.image forKey:kWikiGetADDataImage];

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

    self.addTime = [aDecoder decodeObjectForKey:kWikiGetADDataAddTime];
    self.adId = [aDecoder decodeObjectForKey:kWikiGetADDataAdId];
    self.encyId = [aDecoder decodeObjectForKey:kWikiGetADDataEncyId];
    self.image = [aDecoder decodeObjectForKey:kWikiGetADDataImage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_addTime forKey:kWikiGetADDataAddTime];
    [aCoder encodeObject:_adId forKey:kWikiGetADDataAdId];
    [aCoder encodeObject:_encyId forKey:kWikiGetADDataEncyId];
    [aCoder encodeObject:_image forKey:kWikiGetADDataImage];
}

- (id)copyWithZone:(NSZone *)zone
{
    WikiGetADData *copy = [[WikiGetADData alloc] init];
    
    if (copy) {

        copy.addTime = [self.addTime copyWithZone:zone];
        copy.adId = [self.adId copyWithZone:zone];
        copy.encyId = [self.encyId copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
    }
    
    return copy;
}


@end
