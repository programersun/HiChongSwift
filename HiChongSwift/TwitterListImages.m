//
//  TwitterListImages.m
//
//  Created by 超逸 李 on 15/1/9
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterListImages.h"


NSString *const kTwitterListImagesImagePath = @"image_path";
NSString *const kTwitterListImagesCutHeight = @"cut_height";
NSString *const kTwitterListImagesImageWidth = @"image_width";
NSString *const kTwitterListImagesImageId = @"image_id";
NSString *const kTwitterListImagesCutPath = @"cut_path";
NSString *const kTwitterListImagesImageHeight = @"image_height";
NSString *const kTwitterListImagesCutWidth = @"cut_width";
NSString *const kTwitterListImagesTwitterId = @"twitter_id";
NSString *const kTwitterListImagesAddTime = @"add_time";


@interface TwitterListImages ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterListImages

@synthesize imagePath = _imagePath;
@synthesize cutHeight = _cutHeight;
@synthesize imageWidth = _imageWidth;
@synthesize imageId = _imageId;
@synthesize cutPath = _cutPath;
@synthesize imageHeight = _imageHeight;
@synthesize cutWidth = _cutWidth;
@synthesize twitterId = _twitterId;
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
            self.imagePath = [self objectOrNilForKey:kTwitterListImagesImagePath fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kTwitterListImagesCutHeight fromDictionary:dict];
            self.imageWidth = [self objectOrNilForKey:kTwitterListImagesImageWidth fromDictionary:dict];
            self.imageId = [self objectOrNilForKey:kTwitterListImagesImageId fromDictionary:dict];
            self.cutPath = [self objectOrNilForKey:kTwitterListImagesCutPath fromDictionary:dict];
            self.imageHeight = [self objectOrNilForKey:kTwitterListImagesImageHeight fromDictionary:dict];
            self.cutWidth = [self objectOrNilForKey:kTwitterListImagesCutWidth fromDictionary:dict];
            self.twitterId = [self objectOrNilForKey:kTwitterListImagesTwitterId fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kTwitterListImagesAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imagePath forKey:kTwitterListImagesImagePath];
    [mutableDict setValue:self.cutHeight forKey:kTwitterListImagesCutHeight];
    [mutableDict setValue:self.imageWidth forKey:kTwitterListImagesImageWidth];
    [mutableDict setValue:self.imageId forKey:kTwitterListImagesImageId];
    [mutableDict setValue:self.cutPath forKey:kTwitterListImagesCutPath];
    [mutableDict setValue:self.imageHeight forKey:kTwitterListImagesImageHeight];
    [mutableDict setValue:self.cutWidth forKey:kTwitterListImagesCutWidth];
    [mutableDict setValue:self.twitterId forKey:kTwitterListImagesTwitterId];
    [mutableDict setValue:self.addTime forKey:kTwitterListImagesAddTime];

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

    self.imagePath = [aDecoder decodeObjectForKey:kTwitterListImagesImagePath];
    self.cutHeight = [aDecoder decodeObjectForKey:kTwitterListImagesCutHeight];
    self.imageWidth = [aDecoder decodeObjectForKey:kTwitterListImagesImageWidth];
    self.imageId = [aDecoder decodeObjectForKey:kTwitterListImagesImageId];
    self.cutPath = [aDecoder decodeObjectForKey:kTwitterListImagesCutPath];
    self.imageHeight = [aDecoder decodeObjectForKey:kTwitterListImagesImageHeight];
    self.cutWidth = [aDecoder decodeObjectForKey:kTwitterListImagesCutWidth];
    self.twitterId = [aDecoder decodeObjectForKey:kTwitterListImagesTwitterId];
    self.addTime = [aDecoder decodeObjectForKey:kTwitterListImagesAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imagePath forKey:kTwitterListImagesImagePath];
    [aCoder encodeObject:_cutHeight forKey:kTwitterListImagesCutHeight];
    [aCoder encodeObject:_imageWidth forKey:kTwitterListImagesImageWidth];
    [aCoder encodeObject:_imageId forKey:kTwitterListImagesImageId];
    [aCoder encodeObject:_cutPath forKey:kTwitterListImagesCutPath];
    [aCoder encodeObject:_imageHeight forKey:kTwitterListImagesImageHeight];
    [aCoder encodeObject:_cutWidth forKey:kTwitterListImagesCutWidth];
    [aCoder encodeObject:_twitterId forKey:kTwitterListImagesTwitterId];
    [aCoder encodeObject:_addTime forKey:kTwitterListImagesAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterListImages *copy = [[TwitterListImages alloc] init];
    
    if (copy) {

        copy.imagePath = [self.imagePath copyWithZone:zone];
        copy.cutHeight = [self.cutHeight copyWithZone:zone];
        copy.imageWidth = [self.imageWidth copyWithZone:zone];
        copy.imageId = [self.imageId copyWithZone:zone];
        copy.cutPath = [self.cutPath copyWithZone:zone];
        copy.imageHeight = [self.imageHeight copyWithZone:zone];
        copy.cutWidth = [self.cutWidth copyWithZone:zone];
        copy.twitterId = [self.twitterId copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
