//
//  LCYPetSubTypeBase.h
//
//  Created by 超逸 李 on 14/12/24
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LCYPetSubTypeBase : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *childStyle;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
