//
//  SquareMerchantInfoBase.h
//
//  Created by 超逸 李 on 15/1/5
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SquareMerchantInfoMsg;

@interface SquareMerchantInfoBase : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) BOOL result;
@property (nonatomic, strong) SquareMerchantInfoMsg *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
