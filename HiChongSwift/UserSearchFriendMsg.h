//
//  UserSearchFriendMsg.h
//
//  Created by 超逸 李 on 15/2/2
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserSearchFriendMsg : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSArray *pets;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *tip;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *petCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
