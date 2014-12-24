//
//  CommonUploadBase.h
//
//  Created by 超逸 李 on 14/12/24
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CommonUploadBase : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) BOOL result;
@property (nonatomic, strong) NSArray *images;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
