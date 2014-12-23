//
//  LCYPetDetailPetInfo.h
//
//  Created by 超逸 李 on 14/12/24
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LCYPetDetailPetInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *petName;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *isEntrust;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *petCode;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *petSex;
@property (nonatomic, strong) NSString *cateName;
@property (nonatomic, strong) NSString *fHybridization;
@property (nonatomic, strong) NSString *petId;
@property (nonatomic, strong) NSString *fAdopt;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
