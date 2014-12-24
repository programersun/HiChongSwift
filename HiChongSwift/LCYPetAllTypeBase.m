//
//  LCYPetAllTypeBase.m
//
//  Created by 超逸 李 on 14/12/24
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import "LCYPetAllTypeBase.h"
#import "LCYPetAllTypeFatherStyle.h"


NSString *const kLCYPetAllTypeBaseFatherStyle = @"fatherStyle";


@interface LCYPetAllTypeBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LCYPetAllTypeBase

@synthesize fatherStyle = _fatherStyle;


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
    NSObject *receivedLCYPetAllTypeFatherStyle = [dict objectForKey:kLCYPetAllTypeBaseFatherStyle];
    NSMutableArray *parsedLCYPetAllTypeFatherStyle = [NSMutableArray array];
    if ([receivedLCYPetAllTypeFatherStyle isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLCYPetAllTypeFatherStyle) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLCYPetAllTypeFatherStyle addObject:[LCYPetAllTypeFatherStyle modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLCYPetAllTypeFatherStyle isKindOfClass:[NSDictionary class]]) {
       [parsedLCYPetAllTypeFatherStyle addObject:[LCYPetAllTypeFatherStyle modelObjectWithDictionary:(NSDictionary *)receivedLCYPetAllTypeFatherStyle]];
    }

    self.fatherStyle = [NSArray arrayWithArray:parsedLCYPetAllTypeFatherStyle];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForFatherStyle = [NSMutableArray array];
    for (NSObject *subArrayObject in self.fatherStyle) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForFatherStyle addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForFatherStyle addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForFatherStyle] forKey:kLCYPetAllTypeBaseFatherStyle];

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

    self.fatherStyle = [aDecoder decodeObjectForKey:kLCYPetAllTypeBaseFatherStyle];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_fatherStyle forKey:kLCYPetAllTypeBaseFatherStyle];
}

- (id)copyWithZone:(NSZone *)zone
{
    LCYPetAllTypeBase *copy = [[LCYPetAllTypeBase alloc] init];
    
    if (copy) {

        copy.fatherStyle = [self.fatherStyle copyWithZone:zone];
    }
    
    return copy;
}


@end
