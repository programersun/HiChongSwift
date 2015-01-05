//
//  SquareHomeMsg.h
//
//  Created by 超逸 李 on 15/1/4
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SquareHomeMsg : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *ad;
@property (nonatomic, strong) NSArray *category;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
