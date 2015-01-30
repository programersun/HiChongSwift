//
//  TwitterRemindInfoMsg.h
//
//  Created by 超逸 李 on 15/1/30
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TwitterRemindInfoMsg : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *comment;
@property (nonatomic, strong) NSArray *star;
@property (nonatomic, strong) NSString *headImage;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
