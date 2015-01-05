//
//  SquareGetListMsg.h
//
//  Created by 超逸 李 on 15/1/5
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SquareGetListMsg : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *businessBrief;
@property (nonatomic, strong) NSString *businessImage;
@property (nonatomic, assign) double businessId;
@property (nonatomic, strong) NSString *businessName;
@property (nonatomic, assign) double distance;
@property (nonatomic, assign) double businessScore;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
