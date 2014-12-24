//
//  CommonUploadImages.m
//
//  Created by 超逸 李 on 14/12/24
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import "CommonUploadImages.h"


NSString *const kCommonUploadImagesSavepath = @"savepath";
NSString *const kCommonUploadImagesHash = @"hash";
NSString *const kCommonUploadImagesSavename = @"savename";
NSString *const kCommonUploadImagesSize = @"size";
NSString *const kCommonUploadImagesType = @"type";
NSString *const kCommonUploadImagesExtension = @"extension";
NSString *const kCommonUploadImagesName = @"name";


@interface CommonUploadImages ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CommonUploadImages

@synthesize savepath = _savepath;
@synthesize hash = _hash;
@synthesize savename = _savename;
@synthesize size = _size;
@synthesize type = _type;
@synthesize extension = _extension;
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
            self.savepath = [self objectOrNilForKey:kCommonUploadImagesSavepath fromDictionary:dict];
            self.hash = [self objectOrNilForKey:kCommonUploadImagesHash fromDictionary:dict];
            self.savename = [self objectOrNilForKey:kCommonUploadImagesSavename fromDictionary:dict];
            self.size = [[self objectOrNilForKey:kCommonUploadImagesSize fromDictionary:dict] doubleValue];
            self.type = [self objectOrNilForKey:kCommonUploadImagesType fromDictionary:dict];
            self.extension = [self objectOrNilForKey:kCommonUploadImagesExtension fromDictionary:dict];
            self.name = [self objectOrNilForKey:kCommonUploadImagesName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.savepath forKey:kCommonUploadImagesSavepath];
    [mutableDict setValue:self.hash forKey:kCommonUploadImagesHash];
    [mutableDict setValue:self.savename forKey:kCommonUploadImagesSavename];
    [mutableDict setValue:[NSNumber numberWithDouble:self.size] forKey:kCommonUploadImagesSize];
    [mutableDict setValue:self.type forKey:kCommonUploadImagesType];
    [mutableDict setValue:self.extension forKey:kCommonUploadImagesExtension];
    [mutableDict setValue:self.name forKey:kCommonUploadImagesName];

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

    self.savepath = [aDecoder decodeObjectForKey:kCommonUploadImagesSavepath];
    self.hash = [aDecoder decodeObjectForKey:kCommonUploadImagesHash];
    self.savename = [aDecoder decodeObjectForKey:kCommonUploadImagesSavename];
    self.size = [aDecoder decodeDoubleForKey:kCommonUploadImagesSize];
    self.type = [aDecoder decodeObjectForKey:kCommonUploadImagesType];
    self.extension = [aDecoder decodeObjectForKey:kCommonUploadImagesExtension];
    self.name = [aDecoder decodeObjectForKey:kCommonUploadImagesName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_savepath forKey:kCommonUploadImagesSavepath];
    [aCoder encodeObject:_hash forKey:kCommonUploadImagesHash];
    [aCoder encodeObject:_savename forKey:kCommonUploadImagesSavename];
    [aCoder encodeDouble:_size forKey:kCommonUploadImagesSize];
    [aCoder encodeObject:_type forKey:kCommonUploadImagesType];
    [aCoder encodeObject:_extension forKey:kCommonUploadImagesExtension];
    [aCoder encodeObject:_name forKey:kCommonUploadImagesName];
}

- (id)copyWithZone:(NSZone *)zone
{
    CommonUploadImages *copy = [[CommonUploadImages alloc] init];
    
    if (copy) {

        copy.savepath = [self.savepath copyWithZone:zone];
        copy.hash = [self.hash copyWithZone:zone];
        copy.savename = [self.savename copyWithZone:zone];
        copy.size = self.size;
        copy.type = [self.type copyWithZone:zone];
        copy.extension = [self.extension copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
