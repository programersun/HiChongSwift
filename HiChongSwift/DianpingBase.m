//
//  DianpingBase.m
//
//  Created by 超逸 李 on 15/1/7
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "DianpingBase.h"
#import "DianpingBusinesses.h"


NSString *const kDianpingBaseStatus = @"status";
NSString *const kDianpingBaseBusinesses = @"businesses";
NSString *const kDianpingBaseTotalCount = @"total_count";
NSString *const kDianpingBaseCount = @"count";


@interface DianpingBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DianpingBase

@synthesize status = _status;
@synthesize businesses = _businesses;
@synthesize totalCount = _totalCount;
@synthesize count = _count;


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
            self.status = [self objectOrNilForKey:kDianpingBaseStatus fromDictionary:dict];
    NSObject *receivedDianpingBusinesses = [dict objectForKey:kDianpingBaseBusinesses];
    NSMutableArray *parsedDianpingBusinesses = [NSMutableArray array];
    if ([receivedDianpingBusinesses isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedDianpingBusinesses) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedDianpingBusinesses addObject:[DianpingBusinesses modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedDianpingBusinesses isKindOfClass:[NSDictionary class]]) {
       [parsedDianpingBusinesses addObject:[DianpingBusinesses modelObjectWithDictionary:(NSDictionary *)receivedDianpingBusinesses]];
    }

    self.businesses = [NSArray arrayWithArray:parsedDianpingBusinesses];
            self.totalCount = [[self objectOrNilForKey:kDianpingBaseTotalCount fromDictionary:dict] doubleValue];
            self.count = [[self objectOrNilForKey:kDianpingBaseCount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kDianpingBaseStatus];
    NSMutableArray *tempArrayForBusinesses = [NSMutableArray array];
    for (NSObject *subArrayObject in self.businesses) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBusinesses addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBusinesses addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBusinesses] forKey:kDianpingBaseBusinesses];
    [mutableDict setValue:[NSNumber numberWithDouble:self.totalCount] forKey:kDianpingBaseTotalCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kDianpingBaseCount];

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

    self.status = [aDecoder decodeObjectForKey:kDianpingBaseStatus];
    self.businesses = [aDecoder decodeObjectForKey:kDianpingBaseBusinesses];
    self.totalCount = [aDecoder decodeDoubleForKey:kDianpingBaseTotalCount];
    self.count = [aDecoder decodeDoubleForKey:kDianpingBaseCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kDianpingBaseStatus];
    [aCoder encodeObject:_businesses forKey:kDianpingBaseBusinesses];
    [aCoder encodeDouble:_totalCount forKey:kDianpingBaseTotalCount];
    [aCoder encodeDouble:_count forKey:kDianpingBaseCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    DianpingBase *copy = [[DianpingBase alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.businesses = [self.businesses copyWithZone:zone];
        copy.totalCount = self.totalCount;
        copy.count = self.count;
    }
    
    return copy;
}


@end
