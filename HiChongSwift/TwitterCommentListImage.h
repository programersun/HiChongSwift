//
//  TwitterCommentListImage.h
//
//  Created by 超逸 李 on 15/2/9
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TwitterCommentListImage : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *imageWidth;
@property (nonatomic, strong) NSString *imageId;
@property (nonatomic, strong) NSString *cutPath;
@property (nonatomic, strong) NSString *imageHeight;
@property (nonatomic, strong) NSString *cutWidth;
@property (nonatomic, strong) NSString *twitterId;
@property (nonatomic, strong) NSString *cutHeight;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
