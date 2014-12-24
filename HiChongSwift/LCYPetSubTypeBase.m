//
//  LCYPetSubTypeBase.m
//
//  Created by 超逸 李 on 14/12/24
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import "LCYPetSubTypeBase.h"
#import "LCYPetSubTypeChildStyle.h"


NSString *const kLCYPetSubTypeBaseChildStyle = @"childStyle";


@interface LCYPetSubTypeBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LCYPetSubTypeBase

@synthesize childStyle = _childStyle;


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
    NSObject *receivedLCYPetSubTypeChildStyle = [dict objectForKey:kLCYPetSubTypeBaseChildStyle];
    NSMutableArray *parsedLCYPetSubTypeChildStyle = [NSMutableArray array];
    if ([receivedLCYPetSubTypeChildStyle isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLCYPetSubTypeChildStyle) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLCYPetSubTypeChildStyle addObject:[LCYPetSubTypeChildStyle modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLCYPetSubTypeChildStyle isKindOfClass:[NSDictionary class]]) {
       [parsedLCYPetSubTypeChildStyle addObject:[LCYPetSubTypeChildStyle modelObjectWithDictionary:(NSDictionary *)receivedLCYPetSubTypeChildStyle]];
    }

    self.childStyle = [NSArray arrayWithArray:parsedLCYPetSubTypeChildStyle];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForChildStyle = [NSMutableArray array];
    for (NSObject *subArrayObject in self.childStyle) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForChildStyle addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForChildStyle addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForChildStyle] forKey:kLCYPetSubTypeBaseChildStyle];

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

    self.childStyle = [aDecoder decodeObjectForKey:kLCYPetSubTypeBaseChildStyle];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_childStyle forKey:kLCYPetSubTypeBaseChildStyle];
}

- (id)copyWithZone:(NSZone *)zone
{
    LCYPetSubTypeBase *copy = [[LCYPetSubTypeBase alloc] init];
    
    if (copy) {

        copy.childStyle = [self.childStyle copyWithZone:zone];
    }
    
    return copy;
}


@end
