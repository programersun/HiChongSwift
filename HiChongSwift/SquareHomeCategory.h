//
//  SquareHomeCategory.h
//
//  Created by 超逸 李 on 15/1/4
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SquareHomeCategory : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *cateId;
@property (nonatomic, strong) NSString *cateName;
@property (nonatomic, strong) NSString *isLock;
@property (nonatomic, strong) NSString *sortKey;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
