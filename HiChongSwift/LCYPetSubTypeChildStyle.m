//
//  LCYPetSubTypeChildStyle.m
//
//  Created by 超逸 李 on 14/12/24
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import "LCYPetSubTypeChildStyle.h"


NSString *const kLCYPetSubTypeChildStyleSpell = @"spell";
NSString *const kLCYPetSubTypeChildStyleHeadImg = @"head_img";
NSString *const kLCYPetSubTypeChildStyleCatId = @"cat_id";
NSString *const kLCYPetSubTypeChildStyleFId = @"f_id";
NSString *const kLCYPetSubTypeChildStyleName = @"name";


@interface LCYPetSubTypeChildStyle ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LCYPetSubTypeChildStyle

@synthesize spell = _spell;
@synthesize headImg = _headImg;
@synthesize catId = _catId;
@synthesize fId = _fId;
@synthesize name = _name;


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
            self.spell = [self objectOrNilForKey:kLCYPetSubTypeChildStyleSpell fromDictionary:dict];
            self.headImg = [self objectOrNilForKey:kLCYPetSubTypeChildStyleHeadImg fromDictionary:dict];
            self.catId = [self objectOrNilForKey:kLCYPetSubTypeChildStyleCatId fromDictionary:dict];
            self.fId = [self objectOrNilForKey:kLCYPetSubTypeChildStyleFId fromDictionary:dict];
            self.name = [self objectOrNilForKey:kLCYPetSubTypeChildStyleName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.spell forKey:kLCYPetSubTypeChildStyleSpell];
    [mutableDict setValue:self.headImg forKey:kLCYPetSubTypeChildStyleHeadImg];
    [mutableDict setValue:self.catId forKey:kLCYPetSubTypeChildStyleCatId];
    [mutableDict setValue:self.fId forKey:kLCYPetSubTypeChildStyleFId];
    [mutableDict setValue:self.name forKey:kLCYPetSubTypeChildStyleName];

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

    self.spell = [aDecoder decodeObjectForKey:kLCYPetSubTypeChildStyleSpell];
    self.headImg = [aDecoder decodeObjectForKey:kLCYPetSubTypeChildStyleHeadImg];
    self.catId = [aDecoder decodeObjectForKey:kLCYPetSubTypeChildStyleCatId];
    self.fId = [aDecoder decodeObjectForKey:kLCYPetSubTypeChildStyleFId];
    self.name = [aDecoder decodeObjectForKey:kLCYPetSubTypeChildStyleName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_spell forKey:kLCYPetSubTypeChildStyleSpell];
    [aCoder encodeObject:_headImg forKey:kLCYPetSubTypeChildStyleHeadImg];
    [aCoder encodeObject:_catId forKey:kLCYPetSubTypeChildStyleCatId];
    [aCoder encodeObject:_fId forKey:kLCYPetSubTypeChildStyleFId];
    [aCoder encodeObject:_name forKey:kLCYPetSubTypeChildStyleName];
}

- (id)copyWithZone:(NSZone *)zone
{
    LCYPetSubTypeChildStyle *copy = [[LCYPetSubTypeChildStyle alloc] init];
    
    if (copy) {

        copy.spell = [self.spell copyWithZone:zone];
        copy.headImg = [self.headImg copyWithZone:zone];
        copy.catId = [self.catId copyWithZone:zone];
        copy.fId = [self.fId copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
