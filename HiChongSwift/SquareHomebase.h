//
//  SquareHomebase.h
//
//  Created by 超逸 李 on 15/1/4
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SquareHomeMsg;

@interface SquareHomebase : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) BOOL result;
@property (nonatomic, strong) SquareHomeMsg *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
