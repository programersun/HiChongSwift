//
//  TwitterCommentListImage.m
//
//  Created by 超逸 李 on 15/2/9
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterCommentListImage.h"


NSString *const kTwitterCommentListImageImagePath = @"image_path";
NSString *const kTwitterCommentListImageAddTime = @"add_time";
NSString *const kTwitterCommentListImageImageWidth = @"image_width";
NSString *const kTwitterCommentListImageImageId = @"image_id";
NSString *const kTwitterCommentListImageCutPath = @"cut_path";
NSString *const kTwitterCommentListImageImageHeight = @"image_height";
NSString *const kTwitterCommentListImageCutWidth = @"cut_width";
NSString *const kTwitterCommentListImageTwitterId = @"twitter_id";
NSString *const kTwitterCommentListImageCutHeight = @"cut_height";


@interface TwitterCommentListImage ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterCommentListImage

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
            self.imagePath = [self objectOrNilForKey:kTwitterCommentListImageImagePath fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kTwitterCommentListImageAddTime fromDictionary:dict];
            self.imageWidth = [self objectOrNilForKey:kTwitterCommentListImageImageWidth fromDictionary:dict];
            self.imageId = [self objectOrNilForKey:kTwitterCommentListImageImageId fromDictionary:dict];
            self.cutPath = [self objectOrNilForKey:kTwitterCommentListImageCutPath fromDictionary:dict];
            self.imageHeight = [self objectOrNilForKey:kTwitterCommentListImageImageHeight fromDictionary:dict];
            self.cutWidth = [self objectOrNilForKey:kTwitterCommentListImageCutWidth fromDictionary:dict];
            self.twitterId = [self objectOrNilForKey:kTwitterCommentListImageTwitterId fromDictionary:dict];
            self.cutHeight = [self objectOrNilForKey:kTwitterCommentListImageCutHeight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imagePath forKey:kTwitterCommentListImageImagePath];
    [mutableDict setValue:self.addTime forKey:kTwitterCommentListImageAddTime];
    [mutableDict setValue:self.imageWidth forKey:kTwitterCommentListImageImageWidth];
    [mutableDict setValue:self.imageId forKey:kTwitterCommentListImageImageId];
    [mutableDict setValue:self.cutPath forKey:kTwitterCommentListImageCutPath];
    [mutableDict setValue:self.imageHeight forKey:kTwitterCommentListImageImageHeight];
    [mutableDict setValue:self.cutWidth forKey:kTwitterCommentListImageCutWidth];
    [mutableDict setValue:self.twitterId forKey:kTwitterCommentListImageTwitterId];
    [mutableDict setValue:self.cutHeight forKey:kTwitterCommentListImageCutHeight];

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

    self.imagePath = [aDecoder decodeObjectForKey:kTwitterCommentListImageImagePath];
    self.addTime = [aDecoder decodeObjectForKey:kTwitterCommentListImageAddTime];
    self.imageWidth = [aDecoder decodeObjectForKey:kTwitterCommentListImageImageWidth];
    self.imageId = [aDecoder decodeObjectForKey:kTwitterCommentListImageImageId];
    self.cutPath = [aDecoder decodeObjectForKey:kTwitterCommentListImageCutPath];
    self.imageHeight = [aDecoder decodeObjectForKey:kTwitterCommentListImageImageHeight];
    self.cutWidth = [aDecoder decodeObjectForKey:kTwitterCommentListImageCutWidth];
    self.twitterId = [aDecoder decodeObjectForKey:kTwitterCommentListImageTwitterId];
    self.cutHeight = [aDecoder decodeObjectForKey:kTwitterCommentListImageCutHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imagePath forKey:kTwitterCommentListImageImagePath];
    [aCoder encodeObject:_addTime forKey:kTwitterCommentListImageAddTime];
    [aCoder encodeObject:_imageWidth forKey:kTwitterCommentListImageImageWidth];
    [aCoder encodeObject:_imageId forKey:kTwitterCommentListImageImageId];
    [aCoder encodeObject:_cutPath forKey:kTwitterCommentListImageCutPath];
    [aCoder encodeObject:_imageHeight forKey:kTwitterCommentListImageImageHeight];
    [aCoder encodeObject:_cutWidth forKey:kTwitterCommentListImageCutWidth];
    [aCoder encodeObject:_twitterId forKey:kTwitterCommentListImageTwitterId];
    [aCoder encodeObject:_cutHeight forKey:kTwitterCommentListImageCutHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterCommentListImage *copy = [[TwitterCommentListImage alloc] init];
    
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
