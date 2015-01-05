//
//  SquareHomebase.m
//
//  Created by 超逸 李 on 15/1/4
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "SquareHomebase.h"
#import "SquareHomeMsg.h"


NSString *const kSquareHomebaseResult = @"result";
NSString *const kSquareHomebaseMsg = @"msg";


@interface SquareHomebase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SquareHomebase

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
            self.result = [[self objectOrNilForKey:kSquareHomebaseResult fromDictionary:dict] boolValue];
            self.msg = [SquareHomeMsg modelObjectWithDictionary:[dict objectForKey:kSquareHomebaseMsg]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.result] forKey:kSquareHomebaseResult];
    [mutableDict setValue:[self.msg dictionaryRepresentation] forKey:kSquareHomebaseMsg];

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

    self.result = [aDecoder decodeBoolForKey:kSquareHomebaseResult];
    self.msg = [aDecoder decodeObjectForKey:kSquareHomebaseMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_result forKey:kSquareHomebaseResult];
    [aCoder encodeObject:_msg forKey:kSquareHomebaseMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    SquareHomebase *copy = [[SquareHomebase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
