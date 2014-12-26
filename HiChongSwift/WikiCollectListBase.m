//
//  WikiCollectListBase.m
//
//  Created by 超逸 李 on 14/12/26
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import "WikiCollectListBase.h"
#import "WikiCollectListData.h"


NSString *const kWikiCollectListBaseData = @"data";


@interface WikiCollectListBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WikiCollectListBase

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
    NSObject *receivedWikiCollectListData = [dict objectForKey:kWikiCollectListBaseData];
    NSMutableArray *parsedWikiCollectListData = [NSMutableArray array];
    if ([receivedWikiCollectListData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedWikiCollectListData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedWikiCollectListData addObject:[WikiCollectListData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedWikiCollectListData isKindOfClass:[NSDictionary class]]) {
       [parsedWikiCollectListData addObject:[WikiCollectListData modelObjectWithDictionary:(NSDictionary *)receivedWikiCollectListData]];
    }

    self.data = [NSArray arrayWithArray:parsedWikiCollectListData];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kWikiCollectListBaseData];

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

    self.data = [aDecoder decodeObjectForKey:kWikiCollectListBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kWikiCollectListBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    WikiCollectListBase *copy = [[WikiCollectListBase alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
