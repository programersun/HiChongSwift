//
//  TwitterCommentListMsg.h
//
//  Created by 超逸 李 on 15/1/14
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TwitterCommentListMsg : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *starList;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *starCount;
@property (nonatomic, strong) NSString *twitterLocation;
@property (nonatomic, strong) NSString *twitterId;
@property (nonatomic, strong) NSString *twitterLongitude;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *twitterKeeper;
@property (nonatomic, strong) NSArray *comment;
@property (nonatomic, strong) NSString *twitterContent;
@property (nonatomic, strong) NSString *twitterType;
@property (nonatomic, strong) NSString *twitterLatitude;
@property (nonatomic, strong) NSArray *image;
@property (nonatomic, strong) NSString *twitterPet;
@property (nonatomic, strong) NSString *addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
