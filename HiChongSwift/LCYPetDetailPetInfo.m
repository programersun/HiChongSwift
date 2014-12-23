//
//  LCYPetDetailPetInfo.m
//
//  Created by 超逸 李 on 14/12/24
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import "LCYPetDetailPetInfo.h"


NSString *const kLCYPetDetailPetInfoPetName = @"pet_name";
NSString *const kLCYPetDetailPetInfoSign = @"sign";
NSString *const kLCYPetDetailPetInfoIsEntrust = @"is_entrust";
NSString *const kLCYPetDetailPetInfoHeadImage = @"head_image";
NSString *const kLCYPetDetailPetInfoAge = @"age";
NSString *const kLCYPetDetailPetInfoPetCode = @"pet_code";
NSString *const kLCYPetDetailPetInfoUserId = @"user_id";
NSString *const kLCYPetDetailPetInfoPetSex = @"pet_sex";
NSString *const kLCYPetDetailPetInfoCateName = @"cate_name";
NSString *const kLCYPetDetailPetInfoFHybridization = @"f_hybridization";
NSString *const kLCYPetDetailPetInfoPetId = @"pet_id";
NSString *const kLCYPetDetailPetInfoFAdopt = @"f_adopt";


@interface LCYPetDetailPetInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LCYPetDetailPetInfo

@synthesize petName = _petName;
@synthesize sign = _sign;
@synthesize isEntrust = _isEntrust;
@synthesize headImage = _headImage;
@synthesize age = _age;
@synthesize petCode = _petCode;
@synthesize userId = _userId;
@synthesize petSex = _petSex;
@synthesize cateName = _cateName;
@synthesize fHybridization = _fHybridization;
@synthesize petId = _petId;
@synthesize fAdopt = _fAdopt;


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
            self.petName = [self objectOrNilForKey:kLCYPetDetailPetInfoPetName fromDictionary:dict];
            self.sign = [self objectOrNilForKey:kLCYPetDetailPetInfoSign fromDictionary:dict];
            self.isEntrust = [self objectOrNilForKey:kLCYPetDetailPetInfoIsEntrust fromDictionary:dict];
            self.headImage = [self objectOrNilForKey:kLCYPetDetailPetInfoHeadImage fromDictionary:dict];
            self.age = [self objectOrNilForKey:kLCYPetDetailPetInfoAge fromDictionary:dict];
            self.petCode = [self objectOrNilForKey:kLCYPetDetailPetInfoPetCode fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kLCYPetDetailPetInfoUserId fromDictionary:dict];
            self.petSex = [self objectOrNilForKey:kLCYPetDetailPetInfoPetSex fromDictionary:dict];
            self.cateName = [self objectOrNilForKey:kLCYPetDetailPetInfoCateName fromDictionary:dict];
            self.fHybridization = [self objectOrNilForKey:kLCYPetDetailPetInfoFHybridization fromDictionary:dict];
            self.petId = [self objectOrNilForKey:kLCYPetDetailPetInfoPetId fromDictionary:dict];
            self.fAdopt = [self objectOrNilForKey:kLCYPetDetailPetInfoFAdopt fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.petName forKey:kLCYPetDetailPetInfoPetName];
    [mutableDict setValue:self.sign forKey:kLCYPetDetailPetInfoSign];
    [mutableDict setValue:self.isEntrust forKey:kLCYPetDetailPetInfoIsEntrust];
    [mutableDict setValue:self.headImage forKey:kLCYPetDetailPetInfoHeadImage];
    [mutableDict setValue:self.age forKey:kLCYPetDetailPetInfoAge];
    [mutableDict setValue:self.petCode forKey:kLCYPetDetailPetInfoPetCode];
    [mutableDict setValue:self.userId forKey:kLCYPetDetailPetInfoUserId];
    [mutableDict setValue:self.petSex forKey:kLCYPetDetailPetInfoPetSex];
    [mutableDict setValue:self.cateName forKey:kLCYPetDetailPetInfoCateName];
    [mutableDict setValue:self.fHybridization forKey:kLCYPetDetailPetInfoFHybridization];
    [mutableDict setValue:self.petId forKey:kLCYPetDetailPetInfoPetId];
    [mutableDict setValue:self.fAdopt forKey:kLCYPetDetailPetInfoFAdopt];

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

    self.petName = [aDecoder decodeObjectForKey:kLCYPetDetailPetInfoPetName];
    self.sign = [aDecoder decodeObjectForKey:kLCYPetDetailPetInfoSign];
    self.isEntrust = [aDecoder decodeObjectForKey:kLCYPetDetailPetInfoIsEntrust];
    self.headImage = [aDecoder decodeObjectForKey:kLCYPetDetailPetInfoHeadImage];
    self.age = [aDecoder decodeObjectForKey:kLCYPetDetailPetInfoAge];
    self.petCode = [aDecoder decodeObjectForKey:kLCYPetDetailPetInfoPetCode];
    self.userId = [aDecoder decodeObjectForKey:kLCYPetDetailPetInfoUserId];
    self.petSex = [aDecoder decodeObjectForKey:kLCYPetDetailPetInfoPetSex];
    self.cateName = [aDecoder decodeObjectForKey:kLCYPetDetailPetInfoCateName];
    self.fHybridization = [aDecoder decodeObjectForKey:kLCYPetDetailPetInfoFHybridization];
    self.petId = [aDecoder decodeObjectForKey:kLCYPetDetailPetInfoPetId];
    self.fAdopt = [aDecoder decodeObjectForKey:kLCYPetDetailPetInfoFAdopt];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_petName forKey:kLCYPetDetailPetInfoPetName];
    [aCoder encodeObject:_sign forKey:kLCYPetDetailPetInfoSign];
    [aCoder encodeObject:_isEntrust forKey:kLCYPetDetailPetInfoIsEntrust];
    [aCoder encodeObject:_headImage forKey:kLCYPetDetailPetInfoHeadImage];
    [aCoder encodeObject:_age forKey:kLCYPetDetailPetInfoAge];
    [aCoder encodeObject:_petCode forKey:kLCYPetDetailPetInfoPetCode];
    [aCoder encodeObject:_userId forKey:kLCYPetDetailPetInfoUserId];
    [aCoder encodeObject:_petSex forKey:kLCYPetDetailPetInfoPetSex];
    [aCoder encodeObject:_cateName forKey:kLCYPetDetailPetInfoCateName];
    [aCoder encodeObject:_fHybridization forKey:kLCYPetDetailPetInfoFHybridization];
    [aCoder encodeObject:_petId forKey:kLCYPetDetailPetInfoPetId];
    [aCoder encodeObject:_fAdopt forKey:kLCYPetDetailPetInfoFAdopt];
}

- (id)copyWithZone:(NSZone *)zone
{
    LCYPetDetailPetInfo *copy = [[LCYPetDetailPetInfo alloc] init];
    
    if (copy) {

        copy.petName = [self.petName copyWithZone:zone];
        copy.sign = [self.sign copyWithZone:zone];
        copy.isEntrust = [self.isEntrust copyWithZone:zone];
        copy.headImage = [self.headImage copyWithZone:zone];
        copy.age = [self.age copyWithZone:zone];
        copy.petCode = [self.petCode copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.petSex = [self.petSex copyWithZone:zone];
        copy.cateName = [self.cateName copyWithZone:zone];
        copy.fHybridization = [self.fHybridization copyWithZone:zone];
        copy.petId = [self.petId copyWithZone:zone];
        copy.fAdopt = [self.fAdopt copyWithZone:zone];
    }
    
    return copy;
}


@end
