//
//  SquareGetListBase.m
//
//  Created by 超逸 李 on 15/1/5
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "SquareGetListBase.h"
#import "SquareGetListMsg.h"


NSString *const kSquareGetListBaseResult = @"result";
NSString *const kSquareGetListBaseMsg = @"msg";


@interface SquareGetListBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SquareGetListBase

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
            self.result = [[self objectOrNilForKey:kSquareGetListBaseResult fromDictionary:dict] boolValue];
    NSObject *receivedSquareGetListMsg = [dict objectForKey:kSquareGetListBaseMsg];
    NSMutableArray *parsedSquareGetListMsg = [NSMutableArray array];
    if ([receivedSquareGetListMsg isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSquareGetListMsg) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSquareGetListMsg addObject:[SquareGetListMsg modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSquareGetListMsg isKindOfClass:[NSDictionary class]]) {
       [parsedSquareGetListMsg addObject:[SquareGetListMsg modelObjectWithDictionary:(NSDictionary *)receivedSquareGetListMsg]];
    }

    self.msg = [NSArray arrayWithArray:parsedSquareGetListMsg];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.result] forKey:kSquareGetListBaseResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMsg] forKey:kSquareGetListBaseMsg];

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

    self.result = [aDecoder decodeBoolForKey:kSquareGetListBaseResult];
    self.msg = [aDecoder decodeObjectForKey:kSquareGetListBaseMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_result forKey:kSquareGetListBaseResult];
    [aCoder encodeObject:_msg forKey:kSquareGetListBaseMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    SquareGetListBase *copy = [[SquareGetListBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
