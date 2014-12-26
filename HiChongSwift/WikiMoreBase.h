//
//  WikiMoreBase.h
//
//  Created by 超逸 李 on 14/12/26
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WikiMoreBase : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *data;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
