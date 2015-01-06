//
//  SquareCommentListBase.m
//
//  Created by 超逸 李 on 15/1/6
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "SquareCommentListBase.h"
#import "SquareCommentListMsg.h"


NSString *const kSquareCommentListBaseResult = @"result";
NSString *const kSquareCommentListBaseMsg = @"msg";


@interface SquareCommentListBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SquareCommentListBase

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
            self.result = [[self objectOrNilForKey:kSquareCommentListBaseResult fromDictionary:dict] boolValue];
    NSObject *receivedSquareCommentListMsg = [dict objectForKey:kSquareCommentListBaseMsg];
    NSMutableArray *parsedSquareCommentListMsg = [NSMutableArray array];
    if ([receivedSquareCommentListMsg isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSquareCommentListMsg) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSquareCommentListMsg addObject:[SquareCommentListMsg modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSquareCommentListMsg isKindOfClass:[NSDictionary class]]) {
       [parsedSquareCommentListMsg addObject:[SquareCommentListMsg modelObjectWithDictionary:(NSDictionary *)receivedSquareCommentListMsg]];
    }

    self.msg = [NSArray arrayWithArray:parsedSquareCommentListMsg];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.result] forKey:kSquareCommentListBaseResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMsg] forKey:kSquareCommentListBaseMsg];

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

    self.result = [aDecoder decodeBoolForKey:kSquareCommentListBaseResult];
    self.msg = [aDecoder decodeObjectForKey:kSquareCommentListBaseMsg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_result forKey:kSquareCommentListBaseResult];
    [aCoder encodeObject:_msg forKey:kSquareCommentListBaseMsg];
}

- (id)copyWithZone:(NSZone *)zone
{
    SquareCommentListBase *copy = [[SquareCommentListBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.msg = [self.msg copyWithZone:zone];
    }
    
    return copy;
}


@end
