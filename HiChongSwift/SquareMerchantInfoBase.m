//
//  SquareMerchantInfoBase.m
//
//  Created by 超逸 李 on 15/1/5
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "SquareMerchantInfoBase.h"
#import "SquareMerchantInfoMsg.h"


NSString *const kSquareMerchantInfoBaseResult = @"result";
NSString *const kSquareMerchantInfoBaseMsg = @"msg";


@interface SquareMerchantInfoBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SquareMerchantInfoBase

@synthesize result = _result;
@synthesize msg = _msg;


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
            self.result = [[self objectOrNilForKey:kSquareMerchantInfoBaseResult fromDictionary:dict] boolValue];
            self.msg = [SquareMerchantInfoMsg modelObjectWithDictionary:[dict objectForKey:kSquareMerchantInfoBaseMsg]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.result] forKey:kSquareMerchantInfoBaseResult];
    [mutableDict setValue:[self.msg dictionaryRepresentation] forKey:kSquareMerchantInfoBaseMsg];

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

    self.result = [aDecoder decodeBoolForKey:kSquareMerchantInfoBaseResult];
    self.msg = [aDecoder decodeObjectForKey:kSquareMerchantInfoBaseMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_result forKey:kSquareMerchantInfoBaseResult];
    [aCoder encodeObject:_msg forKey:kSquareMerchantInfoBaseMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    SquareMerchantInfoBase *copy = [[SquareMerchantInfoBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
