//
//  TwitterRemindInfoBase.m
//
//  Created by 超逸 李 on 15/1/30
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterRemindInfoBase.h"
#import "TwitterRemindInfoMsg.h"


NSString *const kTwitterRemindInfoBaseResult = @"result";
NSString *const kTwitterRemindInfoBaseMsg = @"msg";


@interface TwitterRemindInfoBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterRemindInfoBase

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
            self.result = [[self objectOrNilForKey:kTwitterRemindInfoBaseResult fromDictionary:dict] boolValue];
            self.msg = [TwitterRemindInfoMsg modelObjectWithDictionary:[dict objectForKey:kTwitterRemindInfoBaseMsg]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.result] forKey:kTwitterRemindInfoBaseResult];
    [mutableDict setValue:[self.msg dictionaryRepresentation] forKey:kTwitterRemindInfoBaseMsg];

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

    self.result = [aDecoder decodeBoolForKey:kTwitterRemindInfoBaseResult];
    self.msg = [aDecoder decodeObjectForKey:kTwitterRemindInfoBaseMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_result forKey:kTwitterRemindInfoBaseResult];
    [aCoder encodeObject:_msg forKey:kTwitterRemindInfoBaseMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterRemindInfoBase *copy = [[TwitterRemindInfoBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
