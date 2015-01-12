//
//  TwitterPersonalImages.m
//
//  Created by 超逸 李 on 15/1/12
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterPersonalImages.h"


NSString *const kTwitterPersonalImagesImagePath = @"image_path";
NSString *const kTwitterPersonalImagesAddTime = @"add_time";
NSString *const kTwitterPersonalImagesImageWidth = @"image_width";
NSString *const kTwitterPersonalImagesImageId = @"image_id";
NSString *const kTwitterPersonalImagesCutPath = @"cut_path";
NSString *const kTwitterPersonalImagesImageHeight = @"image_height";
NSString *const kTwitterPersonalImagesCutWidth = @"cut_width";
NSString *const kTwitterPersonalImagesTwitterId = @"twitter_id";
NSString *const kTwitterPersonalImagesCutHeight = @"cut_height";


@interface TwitterPersonalImages ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterPersonalImages

@synthesize imagePath = _imagePath;
@synthesize addTime = _addTime;
@synthesize imageWidth = _imageWidth;
@synthesize imageId = _imageId;
@synthesize cutPath = _cutPath;
@synthesize imageHeight = _imageHeight;
@synthesize cutWidth = _cutWidth;
@synthesize twitterId = _twitterId;
@synthesize cutHeight = _cutHeight;


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
            self.imagePath = [self objectOrNilForKey:kTwitterPersonalImagesImagePath fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kTwitterPersonalImagesAddTime fromDictionary:dict];
            self.imageWidth = [self objectOrNilForKey:kTwitterPersonalImagesImageWidth fromDictionary:dict];
            self.imageId = [self objectOrNilForKey:kTwitterPersonalImagesImageId fromDictionary:dict];
            self.cutPath = [self objectOrNilForKey:kTwitterPersonalImagesCutPath fromDictionary:dict];
            self.imageHeight = [self objectOrNilForKey:kTwitterPersonalImagesImageHeight fromDictionary:dict];
            self.cutWidth = [self objectOrNilForKey:kTwitterPersonalImagesCutWidth fromDictionary:dict];
            self.twitterId = [self objectOrNilForKey:kTwitterPersonalImagesTwitterId fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kTwitterPersonalImagesCutHeight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imagePath forKey:kTwitterPersonalImagesImagePath];
    [mutableDict setValue:self.addTime forKey:kTwitterPersonalImagesAddTime];
    [mutableDict setValue:self.imageWidth forKey:kTwitterPersonalImagesImageWidth];
    [mutableDict setValue:self.imageId forKey:kTwitterPersonalImagesImageId];
    [mutableDict setValue:self.cutPath forKey:kTwitterPersonalImagesCutPath];
    [mutableDict setValue:self.imageHeight forKey:kTwitterPersonalImagesImageHeight];
    [mutableDict setValue:self.cutWidth forKey:kTwitterPersonalImagesCutWidth];
    [mutableDict setValue:self.twitterId forKey:kTwitterPersonalImagesTwitterId];
    [mutableDict setValue:self.cutHeight forKey:kTwitterPersonalImagesCutHeight];

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

    self.imagePath = [aDecoder decodeObjectForKey:kTwitterPersonalImagesImagePath];
    self.addTime = [aDecoder decodeObjectForKey:kTwitterPersonalImagesAddTime];
    self.imageWidth = [aDecoder decodeObjectForKey:kTwitterPersonalImagesImageWidth];
    self.imageId = [aDecoder decodeObjectForKey:kTwitterPersonalImagesImageId];
    self.cutPath = [aDecoder decodeObjectForKey:kTwitterPersonalImagesCutPath];
    self.imageHeight = [aDecoder decodeObjectForKey:kTwitterPersonalImagesImageHeight];
    self.cutWidth = [aDecoder decodeObjectForKey:kTwitterPersonalImagesCutWidth];
    self.twitterId = [aDecoder decodeObjectForKey:kTwitterPersonalImagesTwitterId];
    self.cutHeight = [aDecoder decodeObjectForKey:kTwitterPersonalImagesCutHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imagePath forKey:kTwitterPersonalImagesImagePath];
    [aCoder encodeObject:_addTime forKey:kTwitterPersonalImagesAddTime];
    [aCoder encodeObject:_imageWidth forKey:kTwitterPersonalImagesImageWidth];
    [aCoder encodeObject:_imageId forKey:kTwitterPersonalImagesImageId];
    [aCoder encodeObject:_cutPath forKey:kTwitterPersonalImagesCutPath];
    [aCoder encodeObject:_imageHeight forKey:kTwitterPersonalImagesImageHeight];
    [aCoder encodeObject:_cutWidth forKey:kTwitterPersonalImagesCutWidth];
    [aCoder encodeObject:_twitterId forKey:kTwitterPersonalImagesTwitterId];
    [aCoder encodeObject:_cutHeight forKey:kTwitterPersonalImagesCutHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterPersonalImages *copy = [[TwitterPersonalImages alloc] init];
    
    if (copy) {

        copy.imagePath = [self.imagePath copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
        copy.imageWidth = [self.imageWidth copyWithZone:zone];
        copy.imageId = [self.imageId copyWithZone:zone];
        copy.cutPath = [self.cutPath copyWithZone:zone];
        copy.imageHeight = [self.imageHeight copyWithZone:zone];
        copy.cutWidth = [self.cutWidth copyWithZone:zone];
        copy.twitterId = [self.twitterId copyWithZone:zone];
        copy.cutHeight = [self.cutHeight copyWithZone:zone];
    }
    
    return copy;
}


@end
