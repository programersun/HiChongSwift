//
//  TwitterKeeperInfoBase.m
//
//  Created by 超逸 李 on 15/1/12
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterKeeperInfoBase.h"
#import "TwitterKeeperInfoMsg.h"


NSString *const kTwitterKeeperInfoBaseResult = @"result";
NSString *const kTwitterKeeperInfoBaseMsg = @"msg";


@interface TwitterKeeperInfoBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterKeeperInfoBase

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
            self.result = [[self objectOrNilForKey:kTwitterKeeperInfoBaseResult fromDictionary:dict] boolValue];
            self.msg = [TwitterKeeperInfoMsg modelObjectWithDictionary:[dict objectForKey:kTwitterKeeperInfoBaseMsg]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.result] forKey:kTwitterKeeperInfoBaseResult];
    [mutableDict setValue:[self.msg dictionaryRepresentation] forKey:kTwitterKeeperInfoBaseMsg];

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

    self.result = [aDecoder decodeBoolForKey:kTwitterKeeperInfoBaseResult];
    self.msg = [aDecoder decodeObjectForKey:kTwitterKeeperInfoBaseMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_result forKey:kTwitterKeeperInfoBaseResult];
    [aCoder encodeObject:_msg forKey:kTwitterKeeperInfoBaseMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterKeeperInfoBase *copy = [[TwitterKeeperInfoBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
