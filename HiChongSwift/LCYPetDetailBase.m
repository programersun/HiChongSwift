//
//  LCYPetDetailBase.m
//
//  Created by 超逸 李 on 14/12/24
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import "LCYPetDetailBase.h"
#import "LCYPetDetailPetImages.h"
#import "LCYPetDetailPetInfo.h"


NSString *const kLCYPetDetailBaseResult = @"result";
NSString *const kLCYPetDetailBasePetImages = @"pet_images";
NSString *const kLCYPetDetailBasePetInfo = @"pet_info";


@interface LCYPetDetailBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LCYPetDetailBase

@synthesize result = _result;
@synthesize petImages = _petImages;
@synthesize petInfo = _petInfo;


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
            self.result = [[self objectOrNilForKey:kLCYPetDetailBaseResult fromDictionary:dict] boolValue];
    NSObject *receivedLCYPetDetailPetImages = [dict objectForKey:kLCYPetDetailBasePetImages];
    NSMutableArray *parsedLCYPetDetailPetImages = [NSMutableArray array];
    if ([receivedLCYPetDetailPetImages isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLCYPetDetailPetImages) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLCYPetDetailPetImages addObject:[LCYPetDetailPetImages modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLCYPetDetailPetImages isKindOfClass:[NSDictionary class]]) {
       [parsedLCYPetDetailPetImages addObject:[LCYPetDetailPetImages modelObjectWithDictionary:(NSDictionary *)receivedLCYPetDetailPetImages]];
    }

    self.petImages = [NSArray arrayWithArray:parsedLCYPetDetailPetImages];
            self.petInfo = [LCYPetDetailPetInfo modelObjectWithDictionary:[dict objectForKey:kLCYPetDetailBasePetInfo]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.result] forKey:kLCYPetDetailBaseResult];
    NSMutableArray *tempArrayForPetImages = [NSMutableArray array];
    for (NSObject *subArrayObject in self.petImages) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPetImages addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPetImages addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPetImages] forKey:kLCYPetDetailBasePetImages];
    [mutableDict setValue:[self.petInfo dictionaryRepresentation] forKey:kLCYPetDetailBasePetInfo];

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

    self.result = [aDecoder decodeBoolForKey:kLCYPetDetailBaseResult];
    self.petImages = [aDecoder decodeObjectForKey:kLCYPetDetailBasePetImages];
    self.petInfo = [aDecoder decodeObjectForKey:kLCYPetDetailBasePetInfo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_result forKey:kLCYPetDetailBaseResult];
    [aCoder encodeObject:_petImages forKey:kLCYPetDetailBasePetImages];
    [aCoder encodeObject:_petInfo forKey:kLCYPetDetailBasePetInfo];
}

- (id)copyWithZone:(NSZone *)zone
{
    LCYPetDetailBase *copy = [[LCYPetDetailBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.petImages = [self.petImages copyWithZone:zone];
        copy.petInfo = [self.petInfo copyWithZone:zone];
    }
    
    return copy;
}


@end
