//
//  WikiTodayBase.m
//
//  Created by 超逸 李 on 14/12/25
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import "WikiTodayBase.h"
#import "WikiTodayData.h"


NSString *const kWikiTodayBaseData = @"data";


@interface WikiTodayBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WikiTodayBase

@synthesize data = _data;


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
    NSObject *receivedWikiTodayData = [dict objectForKey:kWikiTodayBaseData];
    NSMutableArray *parsedWikiTodayData = [NSMutableArray array];
    if ([receivedWikiTodayData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedWikiTodayData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedWikiTodayData addObject:[WikiTodayData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedWikiTodayData isKindOfClass:[NSDictionary class]]) {
       [parsedWikiTodayData addObject:[WikiTodayData modelObjectWithDictionary:(NSDictionary *)receivedWikiTodayData]];
    }

    self.data = [NSArray arrayWithArray:parsedWikiTodayData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kWikiTodayBaseData];

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

    self.data = [aDecoder decodeObjectForKey:kWikiTodayBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kWikiTodayBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    WikiTodayBase *copy = [[WikiTodayBase alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
