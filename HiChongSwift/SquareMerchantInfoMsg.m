//
//  SquareMerchantInfoMsg.m
//
//  Created by 超逸 李 on 15/1/5
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "SquareMerchantInfoMsg.h"


NSString *const kSquareMerchantInfoMsgBusinessDetail = @"business_detail";
NSString *const kSquareMerchantInfoMsgCommentCount = @"comment_count";
NSString *const kSquareMerchantInfoMsgBusinessPhone = @"business_phone";
NSString *const kSquareMerchantInfoMsgBusinessMapNote = @"business_map_note";
NSString *const kSquareMerchantInfoMsgProvince = @"province";
NSString *const kSquareMerchantInfoMsgBusinessLongitude = @"business_longitude";
NSString *const kSquareMerchantInfoMsgBusinessImage = @"business_image";
NSString *const kSquareMerchantInfoMsgTown = @"town";
NSString *const kSquareMerchantInfoMsgBusinessLatitude = @"business_latitude";
NSString *const kSquareMerchantInfoMsgBusinessName = @"business_name";
NSString *const kSquareMerchantInfoMsgBusinessId = @"business_id";
NSString *const kSquareMerchantInfoMsgBusinessScore = @"business_score";
NSString *const kSquareMerchantInfoMsgCity = @"city";
NSString *const kSquareMerchantInfoMsgBusinessBrief = @"business_brief";
NSString *const kSquareMerchantInfoMsgBusinessLocation = @"business_location";
NSString *const kSquareMerchantInfoMsgAddTime = @"add_time";


@interface SquareMerchantInfoMsg ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SquareMerchantInfoMsg

@synthesize businessDetail = _businessDetail;
@synthesize commentCount = _commentCount;
@synthesize businessPhone = _businessPhone;
@synthesize businessMapNote = _businessMapNote;
@synthesize province = _province;
@synthesize businessLongitude = _businessLongitude;
@synthesize businessImage = _businessImage;
@synthesize town = _town;
@synthesize businessLatitude = _businessLatitude;
@synthesize businessName = _businessName;
@synthesize businessId = _businessId;
@synthesize businessScore = _businessScore;
@synthesize city = _city;
@synthesize businessBrief = _businessBrief;
@synthesize businessLocation = _businessLocation;
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
            self.businessDetail = [self objectOrNilForKey:kSquareMerchantInfoMsgBusinessDetail fromDictionary:dict];
            self.commentCount = [self objectOrNilForKey:kSquareMerchantInfoMsgCommentCount fromDictionary:dict];
            self.businessPhone = [self objectOrNilForKey:kSquareMerchantInfoMsgBusinessPhone fromDictionary:dict];
            self.businessMapNote = [self objectOrNilForKey:kSquareMerchantInfoMsgBusinessMapNote fromDictionary:dict];
            self.province = [self objectOrNilForKey:kSquareMerchantInfoMsgProvince fromDictionary:dict];
            self.businessLongitude = [self objectOrNilForKey:kSquareMerchantInfoMsgBusinessLongitude fromDictionary:dict];
            self.businessImage = [self objectOrNilForKey:kSquareMerchantInfoMsgBusinessImage fromDictionary:dict];
            self.town = [self objectOrNilForKey:kSquareMerchantInfoMsgTown fromDictionary:dict];
            self.businessLatitude = [self objectOrNilForKey:kSquareMerchantInfoMsgBusinessLatitude fromDictionary:dict];
            self.businessName = [self objectOrNilForKey:kSquareMerchantInfoMsgBusinessName fromDictionary:dict];
            self.businessId = [self objectOrNilForKey:kSquareMerchantInfoMsgBusinessId fromDictionary:dict];
            self.businessScore = [self objectOrNilForKey:kSquareMerchantInfoMsgBusinessScore fromDictionary:dict];
            self.city = [self objectOrNilForKey:kSquareMerchantInfoMsgCity fromDictionary:dict];
            self.businessBrief = [self objectOrNilForKey:kSquareMerchantInfoMsgBusinessBrief fromDictionary:dict];
            self.businessLocation = [self objectOrNilForKey:kSquareMerchantInfoMsgBusinessLocation fromDictionary:dict];
            self.addTime = [self objectOrNilForKey:kSquareMerchantInfoMsgAddTime fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.businessDetail forKey:kSquareMerchantInfoMsgBusinessDetail];
    [mutableDict setValue:self.commentCount forKey:kSquareMerchantInfoMsgCommentCount];
    [mutableDict setValue:self.businessPhone forKey:kSquareMerchantInfoMsgBusinessPhone];
    [mutableDict setValue:self.businessMapNote forKey:kSquareMerchantInfoMsgBusinessMapNote];
    [mutableDict setValue:self.province forKey:kSquareMerchantInfoMsgProvince];
    [mutableDict setValue:self.businessLongitude forKey:kSquareMerchantInfoMsgBusinessLongitude];
    [mutableDict setValue:self.businessImage forKey:kSquareMerchantInfoMsgBusinessImage];
    [mutableDict setValue:self.town forKey:kSquareMerchantInfoMsgTown];
    [mutableDict setValue:self.businessLatitude forKey:kSquareMerchantInfoMsgBusinessLatitude];
    [mutableDict setValue:self.businessName forKey:kSquareMerchantInfoMsgBusinessName];
    [mutableDict setValue:self.businessId forKey:kSquareMerchantInfoMsgBusinessId];
    [mutableDict setValue:self.businessScore forKey:kSquareMerchantInfoMsgBusinessScore];
    [mutableDict setValue:self.city forKey:kSquareMerchantInfoMsgCity];
    [mutableDict setValue:self.businessBrief forKey:kSquareMerchantInfoMsgBusinessBrief];
    [mutableDict setValue:self.businessLocation forKey:kSquareMerchantInfoMsgBusinessLocation];
    [mutableDict setValue:self.addTime forKey:kSquareMerchantInfoMsgAddTime];

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

    self.businessDetail = [aDecoder decodeObjectForKey:kSquareMerchantInfoMsgBusinessDetail];
    self.commentCount = [aDecoder decodeObjectForKey:kSquareMerchantInfoMsgCommentCount];
    self.businessPhone = [aDecoder decodeObjectForKey:kSquareMerchantInfoMsgBusinessPhone];
    self.businessMapNote = [aDecoder decodeObjectForKey:kSquareMerchantInfoMsgBusinessMapNote];
    self.province = [aDecoder decodeObjectForKey:kSquareMerchantInfoMsgProvince];
    self.businessLongitude = [aDecoder decodeObjectForKey:kSquareMerchantInfoMsgBusinessLongitude];
    self.businessImage = [aDecoder decodeObjectForKey:kSquareMerchantInfoMsgBusinessImage];
    self.town = [aDecoder decodeObjectForKey:kSquareMerchantInfoMsgTown];
    self.businessLatitude = [aDecoder decodeObjectForKey:kSquareMerchantInfoMsgBusinessLatitude];
    self.businessName = [aDecoder decodeObjectForKey:kSquareMerchantInfoMsgBusinessName];
    self.businessId = [aDecoder decodeObjectForKey:kSquareMerchantInfoMsgBusinessId];
    self.businessScore = [aDecoder decodeObjectForKey:kSquareMerchantInfoMsgBusinessScore];
    self.city = [aDecoder decodeObjectForKey:kSquareMerchantInfoMsgCity];
    self.businessBrief = [aDecoder decodeObjectForKey:kSquareMerchantInfoMsgBusinessBrief];
    self.businessLocation = [aDecoder decodeObjectForKey:kSquareMerchantInfoMsgBusinessLocation];
    self.addTime = [aDecoder decodeObjectForKey:kSquareMerchantInfoMsgAddTime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_businessDetail forKey:kSquareMerchantInfoMsgBusinessDetail];
    [aCoder encodeObject:_commentCount forKey:kSquareMerchantInfoMsgCommentCount];
    [aCoder encodeObject:_businessPhone forKey:kSquareMerchantInfoMsgBusinessPhone];
    [aCoder encodeObject:_businessMapNote forKey:kSquareMerchantInfoMsgBusinessMapNote];
    [aCoder encodeObject:_province forKey:kSquareMerchantInfoMsgProvince];
    [aCoder encodeObject:_businessLongitude forKey:kSquareMerchantInfoMsgBusinessLongitude];
    [aCoder encodeObject:_businessImage forKey:kSquareMerchantInfoMsgBusinessImage];
    [aCoder encodeObject:_town forKey:kSquareMerchantInfoMsgTown];
    [aCoder encodeObject:_businessLatitude forKey:kSquareMerchantInfoMsgBusinessLatitude];
    [aCoder encodeObject:_businessName forKey:kSquareMerchantInfoMsgBusinessName];
    [aCoder encodeObject:_businessId forKey:kSquareMerchantInfoMsgBusinessId];
    [aCoder encodeObject:_businessScore forKey:kSquareMerchantInfoMsgBusinessScore];
    [aCoder encodeObject:_city forKey:kSquareMerchantInfoMsgCity];
    [aCoder encodeObject:_businessBrief forKey:kSquareMerchantInfoMsgBusinessBrief];
    [aCoder encodeObject:_businessLocation forKey:kSquareMerchantInfoMsgBusinessLocation];
    [aCoder encodeObject:_addTime forKey:kSquareMerchantInfoMsgAddTime];
}

- (id)copyWithZone:(NSZone *)zone
{
    SquareMerchantInfoMsg *copy = [[SquareMerchantInfoMsg alloc] init];
    
    if (copy) {

        copy.businessDetail = [self.businessDetail copyWithZone:zone];
        copy.commentCount = [self.commentCount copyWithZone:zone];
        copy.businessPhone = [self.businessPhone copyWithZone:zone];
        copy.businessMapNote = [self.businessMapNote copyWithZone:zone];
        copy.province = [self.province copyWithZone:zone];
        copy.businessLongitude = [self.businessLongitude copyWithZone:zone];
        copy.businessImage = [self.businessImage copyWithZone:zone];
        copy.town = [self.town copyWithZone:zone];
        copy.businessLatitude = [self.businessLatitude copyWithZone:zone];
        copy.businessName = [self.businessName copyWithZone:zone];
        copy.businessId = [self.businessId copyWithZone:zone];
        copy.businessScore = [self.businessScore copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.businessBrief = [self.businessBrief copyWithZone:zone];
        copy.businessLocation = [self.businessLocation copyWithZone:zone];
        copy.addTime = [self.addTime copyWithZone:zone];
    }
    
    return copy;
}


@end
