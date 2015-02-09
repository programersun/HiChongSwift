//
//  TwitterCommentListBase.m
//
//  Created by 超逸 李 on 15/2/9
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "TwitterCommentListBase.h"
#import "TwitterCommentListMsg.h"


NSString *const kTwitterCommentListBaseResult = @"result";
NSString *const kTwitterCommentListBaseMsg = @"msg";


@interface TwitterCommentListBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TwitterCommentListBase

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
            self.result = [[self objectOrNilForKey:kTwitterCommentListBaseResult fromDictionary:dict] boolValue];
            self.msg = [TwitterCommentListMsg modelObjectWithDictionary:[dict objectForKey:kTwitterCommentListBaseMsg]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.result] forKey:kTwitterCommentListBaseResult];
    [mutableDict setValue:[self.msg dictionaryRepresentation] forKey:kTwitterCommentListBaseMsg];

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

    self.result = [aDecoder decodeBoolForKey:kTwitterCommentListBaseResult];
    self.msg = [aDecoder decodeObjectForKey:kTwitterCommentListBaseMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_result forKey:kTwitterCommentListBaseResult];
    [aCoder encodeObject:_msg forKey:kTwitterCommentListBaseMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    TwitterCommentListBase *copy = [[TwitterCommentListBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
