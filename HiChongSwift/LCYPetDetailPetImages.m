//
//  LCYPetDetailPetImages.m
//
//  Created by 超逸 李 on 14/12/24
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import "LCYPetDetailPetImages.h"


NSString *const kLCYPetDetailPetImagesPetId = @"pet_id";
NSString *const kLCYPetDetailPetImagesCutHeight = @"cut_height";
NSString *const kLCYPetDetailPetImagesPetImg = @"pet_img";
NSString *const kLCYPetDetailPetImagesId = @"id";
NSString *const kLCYPetDetailPetImagesCutImg = @"cut_img";
NSString *const kLCYPetDetailPetImagesImgWidth = @"img_width";
NSString *const kLCYPetDetailPetImagesImgHeight = @"img_height";
NSString *const kLCYPetDetailPetImagesCutWidth = @"cut_width";
NSString *const kLCYPetDetailPetImagesAddTime = @"add_time";


@interface LCYPetDetailPetImages ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LCYPetDetailPetImages

@synthesize petId = _petId;
@synthesize cutHeight = _cutHeight;
@synthesize petImg = _petImg;
@synthesize petImagesIdentifier = _petImagesIdentifier;
@synthesize cutImg = _cutImg;
@synthesize imgWidth = _imgWidth;
@synthesize imgHeight = _imgHeight;
@synthesize cutWidth = _cutWidth;
@synthesize addTime = _addTime;


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
            self.petId = [self objectOrNilForKey:kLCYPetDetailPetImagesPetId fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kLCYPetDetailPetImagesCutHeight fromDictionary:dict];
            self.petImg = [self objectOrNilForKey:kLCYPetDetailPetImagesPetImg fromDictionary:dict];
            self.petImagesIdentifier = [self objectOrNilForKey:kLCYPetDetailPetImagesId fromDictionary:dict];
            self.cutImg = [self objectOrNilForKey:kLCYPetDetailPetImagesCutImg fromDictionary:dict];
            self.imgWidth = [self objectOrNilForKey:kLCYPetDetailPetImagesImgWidth fromDictionary:dict];
            self.imgHeight = [self objectOrNilForKey:kLCYPetDetailPetImagesImgHeight fromDictionary:dict];
            self.cutWidth = [self objectOrNilForKey:kLCYPetDetailPetImagesCutWidth fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kLCYPetDetailPetImagesAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.petId forKey:kLCYPetDetailPetImagesPetId];
    [mutableDict setValue:self.cutHeight forKey:kLCYPetDetailPetImagesCutHeight];
    [mutableDict setValue:self.petImg forKey:kLCYPetDetailPetImagesPetImg];
    [mutableDict setValue:self.petImagesIdentifier forKey:kLCYPetDetailPetImagesId];
    [mutableDict setValue:self.cutImg forKey:kLCYPetDetailPetImagesCutImg];
    [mutableDict setValue:self.imgWidth forKey:kLCYPetDetailPetImagesImgWidth];
    [mutableDict setValue:self.imgHeight forKey:kLCYPetDetailPetImagesImgHeight];
    [mutableDict setValue:self.cutWidth forKey:kLCYPetDetailPetImagesCutWidth];
    [mutableDict setValue:self.addTime forKey:kLCYPetDetailPetImagesAddTime];

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

    self.petId = [aDecoder decodeObjectForKey:kLCYPetDetailPetImagesPetId];
    self.cutHeight = [aDecoder decodeObjectForKey:kLCYPetDetailPetImagesCutHeight];
    self.petImg = [aDecoder decodeObjectForKey:kLCYPetDetailPetImagesPetImg];
    self.petImagesIdentifier = [aDecoder decodeObjectForKey:kLCYPetDetailPetImagesId];
    self.cutImg = [aDecoder decodeObjectForKey:kLCYPetDetailPetImagesCutImg];
    self.imgWidth = [aDecoder decodeObjectForKey:kLCYPetDetailPetImagesImgWidth];
    self.imgHeight = [aDecoder decodeObjectForKey:kLCYPetDetailPetImagesImgHeight];
    self.cutWidth = [aDecoder decodeObjectForKey:kLCYPetDetailPetImagesCutWidth];
    self.addTime = [aDecoder decodeObjectForKey:kLCYPetDetailPetImagesAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_petId forKey:kLCYPetDetailPetImagesPetId];
    [aCoder encodeObject:_cutHeight forKey:kLCYPetDetailPetImagesCutHeight];
    [aCoder encodeObject:_petImg forKey:kLCYPetDetailPetImagesPetImg];
    [aCoder encodeObject:_petImagesIdentifier forKey:kLCYPetDetailPetImagesId];
    [aCoder encodeObject:_cutImg forKey:kLCYPetDetailPetImagesCutImg];
    [aCoder encodeObject:_imgWidth forKey:kLCYPetDetailPetImagesImgWidth];
    [aCoder encodeObject:_imgHeight forKey:kLCYPetDetailPetImagesImgHeight];
    [aCoder encodeObject:_cutWidth forKey:kLCYPetDetailPetImagesCutWidth];
    [aCoder encodeObject:_addTime forKey:kLCYPetDetailPetImagesAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    LCYPetDetailPetImages *copy = [[LCYPetDetailPetImages alloc] init];
    
    if (copy) {

        copy.petId = [self.petId copyWithZone:zone];
        copy.cutHeight = [self.cutHeight copyWithZone:zone];
        copy.petImg = [self.petImg copyWithZone:zone];
        copy.petImagesIdentifier = [self.petImagesIdentifier copyWithZone:zone];
        copy.cutImg = [self.cutImg copyWithZone:zone];
        copy.imgWidth = [self.imgWidth copyWithZone:zone];
        copy.imgHeight = [self.imgHeight copyWithZone:zone];
        copy.cutWidth = [self.cutWidth copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
