//
//  TwitterRemindInfoComment.h
//
//  Created by 超逸 李 on 15/1/30
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TwitterRemindInfoComment : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *twitterId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *receiveKeeper;
@property (nonatomic, strong) NSString *keeperId;
@property (nonatomic, strong) NSString *addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
