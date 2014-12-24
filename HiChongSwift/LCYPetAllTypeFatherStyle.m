//
//  LCYPetAllTypeFatherStyle.m
//
//  Created by 超逸 李 on 14/12/24
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import "LCYPetAllTypeFatherStyle.h"


NSString *const kLCYPetAllTypeFatherStyleSpell = @"spell";
NSString *const kLCYPetAllTypeFatherStyleHeadImg = @"head_img";
NSString *const kLCYPetAllTypeFatherStyleCatId = @"cat_id";
NSString *const kLCYPetAllTypeFatherStyleFId = @"f_id";
NSString *const kLCYPetAllTypeFatherStyleName = @"name";


@interface LCYPetAllTypeFatherStyle ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LCYPetAllTypeFatherStyle

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
            self.spell = [self objectOrNilForKey:kLCYPetAllTypeFatherStyleSpell fromDictionary:dict];
            self.headImg = [self objectOrNilForKey:kLCYPetAllTypeFatherStyleHeadImg fromDictionary:dict];
            self.catId = [self objectOrNilForKey:kLCYPetAllTypeFatherStyleCatId fromDictionary:dict];
            self.fId = [self objectOrNilForKey:kLCYPetAllTypeFatherStyleFId fromDictionary:dict];
            self.name = [self objectOrNilForKey:kLCYPetAllTypeFatherStyleName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.spell forKey:kLCYPetAllTypeFatherStyleSpell];
    [mutableDict setValue:self.headImg forKey:kLCYPetAllTypeFatherStyleHeadImg];
    [mutableDict setValue:self.catId forKey:kLCYPetAllTypeFatherStyleCatId];
    [mutableDict setValue:self.fId forKey:kLCYPetAllTypeFatherStyleFId];
    [mutableDict setValue:self.name forKey:kLCYPetAllTypeFatherStyleName];

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

    self.spell = [aDecoder decodeObjectForKey:kLCYPetAllTypeFatherStyleSpell];
    self.headImg = [aDecoder decodeObjectForKey:kLCYPetAllTypeFatherStyleHeadImg];
    self.catId = [aDecoder decodeObjectForKey:kLCYPetAllTypeFatherStyleCatId];
    self.fId = [aDecoder decodeObjectForKey:kLCYPetAllTypeFatherStyleFId];
    self.name = [aDecoder decodeObjectForKey:kLCYPetAllTypeFatherStyleName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_spell forKey:kLCYPetAllTypeFatherStyleSpell];
    [aCoder encodeObject:_headImg forKey:kLCYPetAllTypeFatherStyleHeadImg];
    [aCoder encodeObject:_catId forKey:kLCYPetAllTypeFatherStyleCatId];
    [aCoder encodeObject:_fId forKey:kLCYPetAllTypeFatherStyleFId];
    [aCoder encodeObject:_name forKey:kLCYPetAllTypeFatherStyleName];
}

- (id)copyWithZone:(NSZone *)zone
{
    LCYPetAllTypeFatherStyle *copy = [[LCYPetAllTypeFatherStyle alloc] init];
    
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
