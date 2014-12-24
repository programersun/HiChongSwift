//
//  CommonUploadImages.h
//
//  Created by 超逸 李 on 14/12/24
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CommonUploadImages : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *savepath;
@property (nonatomic, strong) NSString *hash;
@property (nonatomic, strong) NSString *savename;
@property (nonatomic, assign) double size;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *extension;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
