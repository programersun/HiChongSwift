//
//  TwitterListMsg.h
//
//  Created by 超逸 李 on 15/1/19
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TwitterListMsg : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *twitterLatitude;
@property (nonatomic, strong) NSString *twitterType;
@property (nonatomic, strong) NSString *twitterId;
@property (nonatomic, strong) NSString *catId;
@property (nonatomic, strong) NSString *twitterPet;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSString *twitterLongitude;
@property (nonatomic, strong) NSString *keeperImage;
@property (nonatomic, strong) NSString *cateName;
@property (nonatomic, assign) double isStar;
@property (nonatomic, strong) NSString *petName;
@property (nonatomic, strong) NSString *twitterContent;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *twitterLocation;
@property (nonatomic, strong) NSString *petImage;
@property (nonatomic, strong) NSString *starCount;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSArray *starList;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *twitterKeeper;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
