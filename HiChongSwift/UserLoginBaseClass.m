//
//  UserLoginBaseClass.m
//
//  Created by 超逸 李 on 14/12/19
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import "UserLoginBaseClass.h"


NSString *const kUserLoginBaseClassResult = @"result";
NSString *const kUserLoginBaseClassMsg = @"msg";
NSString *const kUserLoginBaseClassUserName = @"user_name";


@interface UserLoginBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserLoginBaseClass

@synthesize result = _result;
@synthesize msg = _msg;
@synthesize userName = _userName;


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
            self.result = [[self objectOrNilForKey:kUserLoginBaseClassResult fromDictionary:dict] boolValue];
            self.msg = [self objectOrNilForKey:kUserLoginBaseClassMsg fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kUserLoginBaseClassUserName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.result] forKey:kUserLoginBaseClassResult];
    [mutableDict setValue:self.msg forKey:kUserLoginBaseClassMsg];
    [mutableDict setValue:self.userName forKey:kUserLoginBaseClassUserName];

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

    self.result = [aDecoder decodeBoolForKey:kUserLoginBaseClassResult];
    self.msg = [aDecoder decodeObjectForKey:kUserLoginBaseClassMsg];
    self.userName = [aDecoder decodeObjectForKey:kUserLoginBaseClassUserName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_result forKey:kUserLoginBaseClassResult];
    [aCoder encodeObject:_msg forKey:kUserLoginBaseClassMsg];
    [aCoder encodeObject:_userName forKey:kUserLoginBaseClassUserName];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserLoginBaseClass *copy = [[UserLoginBaseClass alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.msg = [self.msg copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
    }
    
    return copy;
}


@end
