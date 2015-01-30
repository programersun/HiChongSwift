//
//  TwitterRemindInfoBase.h
//
//  Created by 超逸 李 on 15/1/30
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TwitterRemindInfoMsg;

@interface TwitterRemindInfoBase : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) BOOL result;
@property (nonatomic, strong) TwitterRemindInfoMsg *msg;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
