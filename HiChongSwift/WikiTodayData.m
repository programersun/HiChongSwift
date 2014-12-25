//
//  WikiTodayData.m
//
//  Created by 超逸 李 on 14/12/25
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import "WikiTodayData.h"


NSString *const kWikiTodayDataAuthor = @"author";
NSString *const kWikiTodayDataCateId = @"cate_id";
NSString *const kWikiTodayDataEncyCollect = @"ency_collect";
NSString *const kWikiTodayDataTypeId = @"type_id";
NSString *const kWikiTodayDataTitle = @"title";
NSString *const kWikiTodayDataEncyId = @"ency_id";
NSString *const kWikiTodayDataKeyword = @"keyword";
NSString *const kWikiTodayDataCateName = @"cate_name";
NSString *const kWikiTodayDataHeadImg = @"head_img";
NSString *const kWikiTodayDataEncyRead = @"ency_read";


@interface WikiTodayData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WikiTodayData

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
            self.author = [self objectOrNilForKey:kWikiTodayDataAuthor fromDictionary:dict];
            self.cateId = [self objectOrNilForKey:kWikiTodayDataCateId fromDictionary:dict];
            self.encyCollect = [self objectOrNilForKey:kWikiTodayDataEncyCollect fromDictionary:dict];
            self.typeId = [self objectOrNilForKey:kWikiTodayDataTypeId fromDictionary:dict];
            self.title = [self objectOrNilForKey:kWikiTodayDataTitle fromDictionary:dict];
            self.encyId = [self objectOrNilForKey:kWikiTodayDataEncyId fromDictionary:dict];
            self.keyword = [self objectOrNilForKey:kWikiTodayDataKeyword fromDictionary:dict];
            self.cateName = [self objectOrNilForKey:kWikiTodayDataCateName fromDictionary:dict];
            self.headImg = [self objectOrNilForKey:kWikiTodayDataHeadImg fromDictionary:dict];
            self.encyRead = [self objectOrNilForKey:kWikiTodayDataEncyRead fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.author forKey:kWikiTodayDataAuthor];
    [mutableDict setValue:self.cateId forKey:kWikiTodayDataCateId];
    [mutableDict setValue:self.encyCollect forKey:kWikiTodayDataEncyCollect];
    [mutableDict setValue:self.typeId forKey:kWikiTodayDataTypeId];
    [mutableDict setValue:self.title forKey:kWikiTodayDataTitle];
    [mutableDict setValue:self.encyId forKey:kWikiTodayDataEncyId];
    [mutableDict setValue:self.keyword forKey:kWikiTodayDataKeyword];
    [mutableDict setValue:self.cateName forKey:kWikiTodayDataCateName];
    [mutableDict setValue:self.headImg forKey:kWikiTodayDataHeadImg];
    [mutableDict setValue:self.encyRead forKey:kWikiTodayDataEncyRead];

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

    self.author = [aDecoder decodeObjectForKey:kWikiTodayDataAuthor];
    self.cateId = [aDecoder decodeObjectForKey:kWikiTodayDataCateId];
    self.encyCollect = [aDecoder decodeObjectForKey:kWikiTodayDataEncyCollect];
    self.typeId = [aDecoder decodeObjectForKey:kWikiTodayDataTypeId];
    self.title = [aDecoder decodeObjectForKey:kWikiTodayDataTitle];
    self.encyId = [aDecoder decodeObjectForKey:kWikiTodayDataEncyId];
    self.keyword = [aDecoder decodeObjectForKey:kWikiTodayDataKeyword];
    self.cateName = [aDecoder decodeObjectForKey:kWikiTodayDataCateName];
    self.headImg = [aDecoder decodeObjectForKey:kWikiTodayDataHeadImg];
    self.encyRead = [aDecoder decodeObjectForKey:kWikiTodayDataEncyRead];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_author forKey:kWikiTodayDataAuthor];
    [aCoder encodeObject:_cateId forKey:kWikiTodayDataCateId];
    [aCoder encodeObject:_encyCollect forKey:kWikiTodayDataEncyCollect];
    [aCoder encodeObject:_typeId forKey:kWikiTodayDataTypeId];
    [aCoder encodeObject:_title forKey:kWikiTodayDataTitle];
    [aCoder encodeObject:_encyId forKey:kWikiTodayDataEncyId];
    [aCoder encodeObject:_keyword forKey:kWikiTodayDataKeyword];
    [aCoder encodeObject:_cateName forKey:kWikiTodayDataCateName];
    [aCoder encodeObject:_headImg forKey:kWikiTodayDataHeadImg];
    [aCoder encodeObject:_encyRead forKey:kWikiTodayDataEncyRead];
}

- (id)copyWithZone:(NSZone *)zone
{
    WikiTodayData *copy = [[WikiTodayData alloc] init];
    
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
