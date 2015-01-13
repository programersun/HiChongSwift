//
//  TwitterCommentListComment.h
//
//  Created by 超逸 李 on 15/1/14
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TwitterCommentListComment : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *commentId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *receiveKeeper;
@property (nonatomic, strong) NSString *keeperId;
@property (nonatomic, strong) NSString *receiverName;
@property (nonatomic, strong) NSString *keeperName;
@property (nonatomic, strong) NSString *twitterId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
