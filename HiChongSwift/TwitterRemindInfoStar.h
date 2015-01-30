//
//  TwitterRemindInfoStar.h
//
//  Created by 超逸 李 on 15/1/30
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TwitterRemindInfoStar : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *twitterId;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *keeperId;
@property (nonatomic, strong) NSString *headImage;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
