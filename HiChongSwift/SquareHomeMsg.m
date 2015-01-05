//
//  SquareHomeMsg.m
//
//  Created by 超逸 李 on 15/1/4
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "SquareHomeMsg.h"
#import "SquareHomeAd.h"
#import "SquareHomeCategory.h"


NSString *const kSquareHomeMsgAd = @"ad";
NSString *const kSquareHomeMsgCategory = @"category";


@interface SquareHomeMsg ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SquareHomeMsg

@synthesize ad = _ad;
@synthesize category = _category;


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
    NSObject *receivedSquareHomeAd = [dict objectForKey:kSquareHomeMsgAd];
    NSMutableArray *parsedSquareHomeAd = [NSMutableArray array];
    if ([receivedSquareHomeAd isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSquareHomeAd) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSquareHomeAd addObject:[SquareHomeAd modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSquareHomeAd isKindOfClass:[NSDictionary class]]) {
       [parsedSquareHomeAd addObject:[SquareHomeAd modelObjectWithDictionary:(NSDictionary *)receivedSquareHomeAd]];
    }

    self.ad = [NSArray arrayWithArray:parsedSquareHomeAd];
    NSObject *receivedSquareHomeCategory = [dict objectForKey:kSquareHomeMsgCategory];
    NSMutableArray *parsedSquareHomeCategory = [NSMutableArray array];
    if ([receivedSquareHomeCategory isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSquareHomeCategory) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSquareHomeCategory addObject:[SquareHomeCategory modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSquareHomeCategory isKindOfClass:[NSDictionary class]]) {
       [parsedSquareHomeCategory addObject:[SquareHomeCategory modelObjectWithDictionary:(NSDictionary *)receivedSquareHomeCategory]];
    }

    self.category = [NSArray arrayWithArray:parsedSquareHomeCategory];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForAd = [NSMutableArray array];
    for (NSObject *subArrayObject in self.ad) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForAd addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForAd addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAd] forKey:kSquareHomeMsgAd];
    NSMutableArray *tempArrayForCategory = [NSMutableArray array];
    for (NSObject *subArrayObject in self.category) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCategory addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCategory addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCategory] forKey:kSquareHomeMsgCategory];

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

    self.ad = [aDecoder decodeObjectForKey:kSquareHomeMsgAd];
    self.category = [aDecoder decodeObjectForKey:kSquareHomeMsgCategory];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_ad forKey:kSquareHomeMsgAd];
    [aCoder encodeObject:_category forKey:kSquareHomeMsgCategory];
}

- (id)copyWithZone:(NSZone *)zone
{
    SquareHomeMsg *copy = [[SquareHomeMsg alloc] init];
    
    if (copy) {

        copy.ad = [self.ad copyWithZone:zone];
        copy.category = [self.category copyWithZone:zone];
    }
    
    return copy;
}


@end
