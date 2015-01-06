//
//  SquareCommentListMsg.h
//
//  Created by 超逸 李 on 15/1/6
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SquareCommentListMsg : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *commentScore;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
