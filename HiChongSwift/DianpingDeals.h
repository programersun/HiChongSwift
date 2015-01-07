//
//  DianpingDeals.h
//
//  Created by 超逸 李 on 15/1/7
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DianpingDeals : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *dealsIdentifier;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *dealsDescription;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
