//
//  WikiGetADData.h
//
//  Created by 超逸 李 on 15/1/13
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WikiGetADData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *adId;
@property (nonatomic, strong) NSString *encyId;
@property (nonatomic, strong) NSString *image;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
