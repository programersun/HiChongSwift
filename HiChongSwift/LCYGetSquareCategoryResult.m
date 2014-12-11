//
//  LCYGetSquareCategoryResult.m
//
//  Created by 超逸 李 on 14/12/11
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import "LCYGetSquareCategoryResult.h"
#import "LCYGetSquareCategoryListInfo.h"


NSString *const kLCYGetSquareCategoryResultResult = @"result";
NSString *const kLCYGetSquareCategoryResultListInfo = @"listInfo";


@interface LCYGetSquareCategoryResult ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LCYGetSquareCategoryResult

@synthesize result = _result;
@synthesize listInfo = _listInfo;


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
            self.result = [[self objectOrNilForKey:kLCYGetSquareCategoryResultResult fromDictionary:dict] boolValue];
    NSObject *receivedLCYGetSquareCategoryListInfo = [dict objectForKey:kLCYGetSquareCategoryResultListInfo];
    NSMutableArray *parsedLCYGetSquareCategoryListInfo = [NSMutableArray array];
    if ([receivedLCYGetSquareCategoryListInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLCYGetSquareCategoryListInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLCYGetSquareCategoryListInfo addObject:[LCYGetSquareCategoryListInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLCYGetSquareCategoryListInfo isKindOfClass:[NSDictionary class]]) {
       [parsedLCYGetSquareCategoryListInfo addObject:[LCYGetSquareCategoryListInfo modelObjectWithDictionary:(NSDictionary *)receivedLCYGetSquareCategoryListInfo]];
    }

    self.listInfo = [NSArray arrayWithArray:parsedLCYGetSquareCategoryListInfo];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.result] forKey:kLCYGetSquareCategoryResultResult];
    NSMutableArray *tempArrayForListInfo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.listInfo) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForListInfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForListInfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForListInfo] forKey:kLCYGetSquareCategoryResultListInfo];

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

    self.result = [aDecoder decodeBoolForKey:kLCYGetSquareCategoryResultResult];
    self.listInfo = [aDecoder decodeObjectForKey:kLCYGetSquareCategoryResultListInfo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_result forKey:kLCYGetSquareCategoryResultResult];
    [aCoder encodeObject:_listInfo forKey:kLCYGetSquareCategoryResultListInfo];
}

- (id)copyWithZone:(NSZone *)zone
{
    LCYGetSquareCategoryResult *copy = [[LCYGetSquareCategoryResult alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.listInfo = [self.listInfo copyWithZone:zone];
    }
    
    return copy;
}


@end
