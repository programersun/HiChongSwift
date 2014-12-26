//
//  WikiMoreData.m
//
//  Created by 超逸 李 on 14/12/26
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import "WikiMoreData.h"


NSString *const kWikiMoreDataAuthor = @"author";
NSString *const kWikiMoreDataCateId = @"cate_id";
NSString *const kWikiMoreDataEncyCollect = @"ency_collect";
NSString *const kWikiMoreDataTypeId = @"type_id";
NSString *const kWikiMoreDataTitle = @"title";
NSString *const kWikiMoreDataEncyId = @"ency_id";
NSString *const kWikiMoreDataKeyword = @"keyword";
NSString *const kWikiMoreDataCateName = @"cate_name";
NSString *const kWikiMoreDataHeadImg = @"head_img";
NSString *const kWikiMoreDataEncyRead = @"ency_read";


@interface WikiMoreData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WikiMoreData

@synthesize author = _author;
@synthesize cateId = _cateId;
@synthesize encyCollect = _encyCollect;
@synthesize typeId = _typeId;
@synthesize title = _title;
@synthesize encyId = _encyId;
@synthesize keyword = _keyword;
@synthesize cateName = _cateName;
@synthesize headImg = _headImg;
@synthesize encyRead = _encyRead;


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
            self.author = [self objectOrNilForKey:kWikiMoreDataAuthor fromDictionary:dict];
            self.cateId = [self objectOrNilForKey:kWikiMoreDataCateId fromDictionary:dict];
            self.encyCollect = [self objectOrNilForKey:kWikiMoreDataEncyCollect fromDictionary:dict];
            self.typeId = [self objectOrNilForKey:kWikiMoreDataTypeId fromDictionary:dict];
            self.title = [self objectOrNilForKey:kWikiMoreDataTitle fromDictionary:dict];
            self.encyId = [self objectOrNilForKey:kWikiMoreDataEncyId fromDictionary:dict];
            self.keyword = [self objectOrNilForKey:kWikiMoreDataKeyword fromDictionary:dict];
            self.cateName = [self objectOrNilForKey:kWikiMoreDataCateName fromDictionary:dict];
            self.headImg = [self objectOrNilForKey:kWikiMoreDataHeadImg fromDictionary:dict];
            self.encyRead = [self objectOrNilForKey:kWikiMoreDataEncyRead fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.author forKey:kWikiMoreDataAuthor];
    [mutableDict setValue:self.cateId forKey:kWikiMoreDataCateId];
    [mutableDict setValue:self.encyCollect forKey:kWikiMoreDataEncyCollect];
    [mutableDict setValue:self.typeId forKey:kWikiMoreDataTypeId];
    [mutableDict setValue:self.title forKey:kWikiMoreDataTitle];
    [mutableDict setValue:self.encyId forKey:kWikiMoreDataEncyId];
    [mutableDict setValue:self.keyword forKey:kWikiMoreDataKeyword];
    [mutableDict setValue:self.cateName forKey:kWikiMoreDataCateName];
    [mutableDict setValue:self.headImg forKey:kWikiMoreDataHeadImg];
    [mutableDict setValue:self.encyRead forKey:kWikiMoreDataEncyRead];

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

    self.author = [aDecoder decodeObjectForKey:kWikiMoreDataAuthor];
    self.cateId = [aDecoder decodeObjectForKey:kWikiMoreDataCateId];
    self.encyCollect = [aDecoder decodeObjectForKey:kWikiMoreDataEncyCollect];
    self.typeId = [aDecoder decodeObjectForKey:kWikiMoreDataTypeId];
    self.title = [aDecoder decodeObjectForKey:kWikiMoreDataTitle];
    self.encyId = [aDecoder decodeObjectForKey:kWikiMoreDataEncyId];
    self.keyword = [aDecoder decodeObjectForKey:kWikiMoreDataKeyword];
    self.cateName = [aDecoder decodeObjectForKey:kWikiMoreDataCateName];
    self.headImg = [aDecoder decodeObjectForKey:kWikiMoreDataHeadImg];
    self.encyRead = [aDecoder decodeObjectForKey:kWikiMoreDataEncyRead];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_author forKey:kWikiMoreDataAuthor];
    [aCoder encodeObject:_cateId forKey:kWikiMoreDataCateId];
    [aCoder encodeObject:_encyCollect forKey:kWikiMoreDataEncyCollect];
    [aCoder encodeObject:_typeId forKey:kWikiMoreDataTypeId];
    [aCoder encodeObject:_title forKey:kWikiMoreDataTitle];
    [aCoder encodeObject:_encyId forKey:kWikiMoreDataEncyId];
    [aCoder encodeObject:_keyword forKey:kWikiMoreDataKeyword];
    [aCoder encodeObject:_cateName forKey:kWikiMoreDataCateName];
    [aCoder encodeObject:_headImg forKey:kWikiMoreDataHeadImg];
    [aCoder encodeObject:_encyRead forKey:kWikiMoreDataEncyRead];
}

- (id)copyWithZone:(NSZone *)zone
{
    WikiMoreData *copy = [[WikiMoreData alloc] init];
    
    if (copy) {

        copy.author = [self.author copyWithZone:zone];
        copy.cateId = [self.cateId copyWithZone:zone];
        copy.encyCollect = [self.encyCollect copyWithZone:zone];
        copy.typeId = [self.typeId copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.encyId = [self.encyId copyWithZone:zone];
        copy.keyword = [self.keyword copyWithZone:zone];
        copy.cateName = [self.cateName copyWithZone:zone];
        copy.headImg = [self.headImg copyWithZone:zone];
        copy.encyRead = [self.encyRead copyWithZone:zone];
    }
    
    return copy;
}


@end
