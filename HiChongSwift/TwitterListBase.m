//
//  TwitterListBase.m
//
//  Created by 超逸 李 on 15/1/26
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterListBase.h"
#import "TwitterListMsg.h"


NSString *const kTwitterListBaseResult = @"result";
NSString *const kTwitterListBaseMsg = @"msg";


@interface TwitterListBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterListBase

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
            self.result = [[self objectOrNilForKey:kTwitterListBaseResult fromDictionary:dict] boolValue];
    NSObject *receivedTwitterListMsg = [dict objectForKey:kTwitterListBaseMsg];
    NSMutableArray *parsedTwitterListMsg = [NSMutableArray array];
    if ([receivedTwitterListMsg isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTwitterListMsg) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTwitterListMsg addObject:[TwitterListMsg modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTwitterListMsg isKindOfClass:[NSDictionary class]]) {
       [parsedTwitterListMsg addObject:[TwitterListMsg modelObjectWithDictionary:(NSDictionary *)receivedTwitterListMsg]];
    }

    self.msg = [NSArray arrayWithArray:parsedTwitterListMsg];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.result] forKey:kTwitterListBaseResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMsg] forKey:kTwitterListBaseMsg];

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

    self.result = [aDecoder decodeBoolForKey:kTwitterListBaseResult];
    self.msg = [aDecoder decodeObjectForKey:kTwitterListBaseMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_result forKey:kTwitterListBaseResult];
    [aCoder encodeObject:_msg forKey:kTwitterListBaseMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterListBase *copy = [[TwitterListBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
