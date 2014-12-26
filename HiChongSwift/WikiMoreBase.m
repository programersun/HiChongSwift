//
//  WikiMoreBase.m
//
//  Created by 超逸 李 on 14/12/26
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import "WikiMoreBase.h"
#import "WikiMoreData.h"


NSString *const kWikiMoreBaseData = @"data";


@interface WikiMoreBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WikiMoreBase

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
    NSObject *receivedWikiMoreData = [dict objectForKey:kWikiMoreBaseData];
    NSMutableArray *parsedWikiMoreData = [NSMutableArray array];
    if ([receivedWikiMoreData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedWikiMoreData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedWikiMoreData addObject:[WikiMoreData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedWikiMoreData isKindOfClass:[NSDictionary class]]) {
       [parsedWikiMoreData addObject:[WikiMoreData modelObjectWithDictionary:(NSDictionary *)receivedWikiMoreData]];
    }

    self.data = [NSArray arrayWithArray:parsedWikiMoreData];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kWikiMoreBaseData];

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

    self.data = [aDecoder decodeObjectForKey:kWikiMoreBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kWikiMoreBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    WikiMoreBase *copy = [[WikiMoreBase alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
