//
//  SquareGetListMsg.m
//
//  Created by 超逸 李 on 15/1/5
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "SquareGetListMsg.h"


NSString *const kSquareGetListMsgBusinessBrief = @"business_brief";
NSString *const kSquareGetListMsgBusinessImage = @"business_image";
NSString *const kSquareGetListMsgBusinessId = @"business_id";
NSString *const kSquareGetListMsgBusinessName = @"business_name";
NSString *const kSquareGetListMsgDistance = @"distance";
NSString *const kSquareGetListMsgBusinessScore = @"business_score";


@interface SquareGetListMsg ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SquareGetListMsg

@synthesize businessBrief = _businessBrief;
@synthesize businessImage = _businessImage;
@synthesize businessId = _businessId;
@synthesize businessName = _businessName;
@synthesize distance = _distance;
@synthesize businessScore = _businessScore;


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
            self.businessBrief = [self objectOrNilForKey:kSquareGetListMsgBusinessBrief fromDictionary:dict];
            self.businessImage = [self objectOrNilForKey:kSquareGetListMsgBusinessImage fromDictionary:dict];
            self.businessId = [[self objectOrNilForKey:kSquareGetListMsgBusinessId fromDictionary:dict] doubleValue];
            self.businessName = [self objectOrNilForKey:kSquareGetListMsgBusinessName fromDictionary:dict];
            self.distance = [[self objectOrNilForKey:kSquareGetListMsgDistance fromDictionary:dict] doubleValue];
            self.businessScore = [[self objectOrNilForKey:kSquareGetListMsgBusinessScore fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.businessBrief forKey:kSquareGetListMsgBusinessBrief];
    [mutableDict setValue:self.businessImage forKey:kSquareGetListMsgBusinessImage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.businessId] forKey:kSquareGetListMsgBusinessId];
    [mutableDict setValue:self.businessName forKey:kSquareGetListMsgBusinessName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.distance] forKey:kSquareGetListMsgDistance];
    [mutableDict setValue:[NSNumber numberWithDouble:self.businessScore] forKey:kSquareGetListMsgBusinessScore];

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

    self.businessBrief = [aDecoder decodeObjectForKey:kSquareGetListMsgBusinessBrief];
    self.businessImage = [aDecoder decodeObjectForKey:kSquareGetListMsgBusinessImage];
    self.businessId = [aDecoder decodeDoubleForKey:kSquareGetListMsgBusinessId];
    self.businessName = [aDecoder decodeObjectForKey:kSquareGetListMsgBusinessName];
    self.distance = [aDecoder decodeDoubleForKey:kSquareGetListMsgDistance];
    self.businessScore = [aDecoder decodeDoubleForKey:kSquareGetListMsgBusinessScore];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_businessBrief forKey:kSquareGetListMsgBusinessBrief];
    [aCoder encodeObject:_businessImage forKey:kSquareGetListMsgBusinessImage];
    [aCoder encodeDouble:_businessId forKey:kSquareGetListMsgBusinessId];
    [aCoder encodeObject:_businessName forKey:kSquareGetListMsgBusinessName];
    [aCoder encodeDouble:_distance forKey:kSquareGetListMsgDistance];
    [aCoder encodeDouble:_businessScore forKey:kSquareGetListMsgBusinessScore];
}

- (id)copyWithZone:(NSZone *)zone
{
    SquareGetListMsg *copy = [[SquareGetListMsg alloc] init];
    
    if (copy) {

        copy.businessBrief = [self.businessBrief copyWithZone:zone];
        copy.businessImage = [self.businessImage copyWithZone:zone];
        copy.businessId = self.businessId;
        copy.businessName = [self.businessName copyWithZone:zone];
        copy.distance = self.distance;
        copy.businessScore = self.businessScore;
    }
    
    return copy;
}


@end
