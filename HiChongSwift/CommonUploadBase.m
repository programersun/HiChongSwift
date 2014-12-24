//
//  CommonUploadBase.m
//
//  Created by 超逸 李 on 14/12/24
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import "CommonUploadBase.h"
#import "CommonUploadImages.h"


NSString *const kCommonUploadBaseResult = @"result";
NSString *const kCommonUploadBaseImages = @"images";


@interface CommonUploadBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CommonUploadBase

@synthesize result = _result;
@synthesize images = _images;


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
            self.result = [[self objectOrNilForKey:kCommonUploadBaseResult fromDictionary:dict] boolValue];
    NSObject *receivedCommonUploadImages = [dict objectForKey:kCommonUploadBaseImages];
    NSMutableArray *parsedCommonUploadImages = [NSMutableArray array];
    if ([receivedCommonUploadImages isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCommonUploadImages) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCommonUploadImages addObject:[CommonUploadImages modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCommonUploadImages isKindOfClass:[NSDictionary class]]) {
       [parsedCommonUploadImages addObject:[CommonUploadImages modelObjectWithDictionary:(NSDictionary *)receivedCommonUploadImages]];
    }

    self.images = [NSArray arrayWithArray:parsedCommonUploadImages];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.result] forKey:kCommonUploadBaseResult];
    NSMutableArray *tempArrayForImages = [NSMutableArray array];
    for (NSObject *subArrayObject in self.images) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImages addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImages addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImages] forKey:kCommonUploadBaseImages];

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

    self.result = [aDecoder decodeBoolForKey:kCommonUploadBaseResult];
    self.images = [aDecoder decodeObjectForKey:kCommonUploadBaseImages];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_result forKey:kCommonUploadBaseResult];
    [aCoder encodeObject:_images forKey:kCommonUploadBaseImages];
}

- (id)copyWithZone:(NSZone *)zone
{
    CommonUploadBase *copy = [[CommonUploadBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.images = [self.images copyWithZone:zone];
    }
    
    return copy;
}


@end
