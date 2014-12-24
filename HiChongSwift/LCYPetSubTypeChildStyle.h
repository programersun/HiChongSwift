//
//  LCYPetSubTypeChildStyle.h
//
//  Created by 超逸 李 on 14/12/24
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LCYPetSubTypeChildStyle : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *spell;
@property (nonatomic, strong) NSString *headImg;
@property (nonatomic, strong) NSString *catId;
@property (nonatomic, strong) NSString *fId;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
