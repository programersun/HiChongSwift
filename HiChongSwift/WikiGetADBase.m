//
//  WikiGetADBase.m
//
//  Created by 超逸 李 on 15/1/13
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "WikiGetADBase.h"
#import "WikiGetADData.h"


NSString *const kWikiGetADBaseData = @"data";


@interface WikiGetADBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WikiGetADBase

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
    NSObject *receivedWikiGetADData = [dict objectForKey:kWikiGetADBaseData];
    NSMutableArray *parsedWikiGetADData = [NSMutableArray array];
    if ([receivedWikiGetADData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedWikiGetADData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedWikiGetADData addObject:[WikiGetADData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedWikiGetADData isKindOfClass:[NSDictionary class]]) {
       [parsedWikiGetADData addObject:[WikiGetADData modelObjectWithDictionary:(NSDictionary *)receivedWikiGetADData]];
    }

    self.data = [NSArray arrayWithArray:parsedWikiGetADData];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kWikiGetADBaseData];

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

    self.data = [aDecoder decodeObjectForKey:kWikiGetADBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kWikiGetADBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    WikiGetADBase *copy = [[WikiGetADBase alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
