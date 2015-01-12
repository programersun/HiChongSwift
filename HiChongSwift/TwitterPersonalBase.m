//
//  TwitterPersonalBase.m
//
//  Created by 超逸 李 on 15/1/12
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterPersonalBase.h"
#import "TwitterPersonalMsg.h"


NSString *const kTwitterPersonalBaseResult = @"result";
NSString *const kTwitterPersonalBaseMsg = @"msg";


@interface TwitterPersonalBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterPersonalBase

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
            self.result = [[self objectOrNilForKey:kTwitterPersonalBaseResult fromDictionary:dict] boolValue];
    NSObject *receivedTwitterPersonalMsg = [dict objectForKey:kTwitterPersonalBaseMsg];
    NSMutableArray *parsedTwitterPersonalMsg = [NSMutableArray array];
    if ([receivedTwitterPersonalMsg isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTwitterPersonalMsg) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTwitterPersonalMsg addObject:[TwitterPersonalMsg modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTwitterPersonalMsg isKindOfClass:[NSDictionary class]]) {
       [parsedTwitterPersonalMsg addObject:[TwitterPersonalMsg modelObjectWithDictionary:(NSDictionary *)receivedTwitterPersonalMsg]];
    }

    self.msg = [NSArray arrayWithArray:parsedTwitterPersonalMsg];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.result] forKey:kTwitterPersonalBaseResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMsg] forKey:kTwitterPersonalBaseMsg];

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

    self.result = [aDecoder decodeBoolForKey:kTwitterPersonalBaseResult];
    self.msg = [aDecoder decodeObjectForKey:kTwitterPersonalBaseMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_result forKey:kTwitterPersonalBaseResult];
    [aCoder encodeObject:_msg forKey:kTwitterPersonalBaseMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterPersonalBase *copy = [[TwitterPersonalBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
