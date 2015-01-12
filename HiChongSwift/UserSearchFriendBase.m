//
//  UserSearchFriendBase.m
//
//  Created by 超逸 李 on 15/1/13
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "UserSearchFriendBase.h"
#import "UserSearchFriendMsg.h"


NSString *const kUserSearchFriendBaseResult = @"result";
NSString *const kUserSearchFriendBaseMsg = @"msg";


@interface UserSearchFriendBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserSearchFriendBase

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
            self.result = [[self objectOrNilForKey:kUserSearchFriendBaseResult fromDictionary:dict] boolValue];
    NSObject *receivedUserSearchFriendMsg = [dict objectForKey:kUserSearchFriendBaseMsg];
    NSMutableArray *parsedUserSearchFriendMsg = [NSMutableArray array];
    if ([receivedUserSearchFriendMsg isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedUserSearchFriendMsg) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedUserSearchFriendMsg addObject:[UserSearchFriendMsg modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedUserSearchFriendMsg isKindOfClass:[NSDictionary class]]) {
       [parsedUserSearchFriendMsg addObject:[UserSearchFriendMsg modelObjectWithDictionary:(NSDictionary *)receivedUserSearchFriendMsg]];
    }

    self.msg = [NSArray arrayWithArray:parsedUserSearchFriendMsg];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.result] forKey:kUserSearchFriendBaseResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMsg] forKey:kUserSearchFriendBaseMsg];

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

    self.result = [aDecoder decodeBoolForKey:kUserSearchFriendBaseResult];
    self.msg = [aDecoder decodeObjectForKey:kUserSearchFriendBaseMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_result forKey:kUserSearchFriendBaseResult];
    [aCoder encodeObject:_msg forKey:kUserSearchFriendBaseMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserSearchFriendBase *copy = [[UserSearchFriendBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
