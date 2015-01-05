//
//  SquareHomeAd.h
//
//  Created by 超逸 李 on 15/1/4
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SquareHomeAd : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *adId;
@property (nonatomic, strong) NSString *businessId;
@property (nonatomic, strong) NSString *webUrl;
@property (nonatomic, strong) NSString *typeId;
@property (nonatomic, strong) NSString *adImage;
@property (nonatomic, strong) NSString *isShow;
@property (nonatomic, strong) NSString *sortKey;
@property (nonatomic, strong) NSString *addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
