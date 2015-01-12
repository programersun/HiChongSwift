//
//  UserFansFriendsBase.m
//
//  Created by 超逸 李 on 15/1/12
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "UserFansFriendsBase.h"
#import "UserFansFriendsMsg.h"


NSString *const kUserFansFriendsBaseResult = @"result";
NSString *const kUserFansFriendsBaseMsg = @"msg";


@interface UserFansFriendsBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserFansFriendsBase

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
            self.result = [[self objectOrNilForKey:kUserFansFriendsBaseResult fromDictionary:dict] boolValue];
    NSObject *receivedUserFansFriendsMsg = [dict objectForKey:kUserFansFriendsBaseMsg];
    NSMutableArray *parsedUserFansFriendsMsg = [NSMutableArray array];
    if ([receivedUserFansFriendsMsg isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedUserFansFriendsMsg) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedUserFansFriendsMsg addObject:[UserFansFriendsMsg modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedUserFansFriendsMsg isKindOfClass:[NSDictionary class]]) {
       [parsedUserFansFriendsMsg addObject:[UserFansFriendsMsg modelObjectWithDictionary:(NSDictionary *)receivedUserFansFriendsMsg]];
    }

    self.msg = [NSArray arrayWithArray:parsedUserFansFriendsMsg];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.result] forKey:kUserFansFriendsBaseResult];
    NSMutableArray *tempArrayForMsg = [NSMutableArray array];
    for (NSObject *subArrayObject in self.msg) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMsg addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMsg addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMsg] forKey:kUserFansFriendsBaseMsg];

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

    self.result = [aDecoder decodeBoolForKey:kUserFansFriendsBaseResult];
    self.msg = [aDecoder decodeObjectForKey:kUserFansFriendsBaseMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_result forKey:kUserFansFriendsBaseResult];
    [aCoder encodeObject:_msg forKey:kUserFansFriendsBaseMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserFansFriendsBase *copy = [[UserFansFriendsBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
