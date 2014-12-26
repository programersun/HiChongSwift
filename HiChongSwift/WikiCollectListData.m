//
//  WikiCollectListData.m
//
//  Created by 超逸 李 on 14/12/26
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import "WikiCollectListData.h"


NSString *const kWikiCollectListDataAuthor = @"author";
NSString *const kWikiCollectListDataCateId = @"cate_id";
NSString *const kWikiCollectListDataEncyCollect = @"ency_collect";
NSString *const kWikiCollectListDataTypeId = @"type_id";
NSString *const kWikiCollectListDataTitle = @"title";
NSString *const kWikiCollectListDataEncyId = @"ency_id";
NSString *const kWikiCollectListDataKeyword = @"keyword";
NSString *const kWikiCollectListDataUserName = @"user_name";
NSString *const kWikiCollectListDataHeadImg = @"head_img";
NSString *const kWikiCollectListDataCateName = @"cate_name";
NSString *const kWikiCollectListDataEncyRead = @"ency_read";


@interface WikiCollectListData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WikiCollectListData

@synthesize author = _author;
@synthesize cateId = _cateId;
@synthesize encyCollect = _encyCollect;
@synthesize typeId = _typeId;
@synthesize title = _title;
@synthesize encyId = _encyId;
@synthesize keyword = _keyword;
@synthesize userName = _userName;
@synthesize headImg = _headImg;
@synthesize cateName = _cateName;
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
            self.author = [self objectOrNilForKey:kWikiCollectListDataAuthor fromDictionary:dict];
            self.cateId = [self objectOrNilForKey:kWikiCollectListDataCateId fromDictionary:dict];
            self.encyCollect = [self objectOrNilForKey:kWikiCollectListDataEncyCollect fromDictionary:dict];
            self.typeId = [self objectOrNilForKey:kWikiCollectListDataTypeId fromDictionary:dict];
            self.title = [self objectOrNilForKey:kWikiCollectListDataTitle fromDictionary:dict];
            self.encyId = [self objectOrNilForKey:kWikiCollectListDataEncyId fromDictionary:dict];
            self.keyword = [self objectOrNilForKey:kWikiCollectListDataKeyword fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kWikiCollectListDataUserName fromDictionary:dict];
            self.headImg = [self objectOrNilForKey:kWikiCollectListDataHeadImg fromDictionary:dict];
            self.cateName = [self objectOrNilForKey:kWikiCollectListDataCateName fromDictionary:dict];
            self.encyRead = [self objectOrNilForKey:kWikiCollectListDataEncyRead fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.author forKey:kWikiCollectListDataAuthor];
    [mutableDict setValue:self.cateId forKey:kWikiCollectListDataCateId];
    [mutableDict setValue:self.encyCollect forKey:kWikiCollectListDataEncyCollect];
    [mutableDict setValue:self.typeId forKey:kWikiCollectListDataTypeId];
    [mutableDict setValue:self.title forKey:kWikiCollectListDataTitle];
    [mutableDict setValue:self.encyId forKey:kWikiCollectListDataEncyId];
    [mutableDict setValue:self.keyword forKey:kWikiCollectListDataKeyword];
    [mutableDict setValue:self.userName forKey:kWikiCollectListDataUserName];
    [mutableDict setValue:self.headImg forKey:kWikiCollectListDataHeadImg];
    [mutableDict setValue:self.cateName forKey:kWikiCollectListDataCateName];
    [mutableDict setValue:self.encyRead forKey:kWikiCollectListDataEncyRead];

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

    self.author = [aDecoder decodeObjectForKey:kWikiCollectListDataAuthor];
    self.cateId = [aDecoder decodeObjectForKey:kWikiCollectListDataCateId];
    self.encyCollect = [aDecoder decodeObjectForKey:kWikiCollectListDataEncyCollect];
    self.typeId = [aDecoder decodeObjectForKey:kWikiCollectListDataTypeId];
    self.title = [aDecoder decodeObjectForKey:kWikiCollectListDataTitle];
    self.encyId = [aDecoder decodeObjectForKey:kWikiCollectListDataEncyId];
    self.keyword = [aDecoder decodeObjectForKey:kWikiCollectListDataKeyword];
    self.userName = [aDecoder decodeObjectForKey:kWikiCollectListDataUserName];
    self.headImg = [aDecoder decodeObjectForKey:kWikiCollectListDataHeadImg];
    self.cateName = [aDecoder decodeObjectForKey:kWikiCollectListDataCateName];
    self.encyRead = [aDecoder decodeObjectForKey:kWikiCollectListDataEncyRead];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_author forKey:kWikiCollectListDataAuthor];
    [aCoder encodeObject:_cateId forKey:kWikiCollectListDataCateId];
    [aCoder encodeObject:_encyCollect forKey:kWikiCollectListDataEncyCollect];
    [aCoder encodeObject:_typeId forKey:kWikiCollectListDataTypeId];
    [aCoder encodeObject:_title forKey:kWikiCollectListDataTitle];
    [aCoder encodeObject:_encyId forKey:kWikiCollectListDataEncyId];
    [aCoder encodeObject:_keyword forKey:kWikiCollectListDataKeyword];
    [aCoder encodeObject:_userName forKey:kWikiCollectListDataUserName];
    [aCoder encodeObject:_headImg forKey:kWikiCollectListDataHeadImg];
    [aCoder encodeObject:_cateName forKey:kWikiCollectListDataCateName];
    [aCoder encodeObject:_encyRead forKey:kWikiCollectListDataEncyRead];
}

- (id)copyWithZone:(NSZone *)zone
{
    WikiCollectListData *copy = [[WikiCollectListData alloc] init];
    
    if (copy) {

        copy.author = [self.author copyWithZone:zone];
        copy.cateId = [self.cateId copyWithZone:zone];
        copy.encyCollect = [self.encyCollect copyWithZone:zone];
        copy.typeId = [self.typeId copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.encyId = [self.encyId copyWithZone:zone];
        copy.keyword = [self.keyword copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.headImg = [self.headImg copyWithZone:zone];
        copy.cateName = [self.cateName copyWithZone:zone];
        copy.encyRead = [self.encyRead copyWithZone:zone];
    }
    
    return copy;
}


@end
