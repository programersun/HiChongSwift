//
//  GetUserInfoPetInfo.h
//
//  Created by 超逸 李 on 15/1/6
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GetUserInfoPetInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *petId;
@property (nonatomic, strong) NSString *fAdopt;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *petSex;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *fHybridization;
@property (nonatomic, strong) NSString *petName;
@property (nonatomic, strong) NSString *isEntrust;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
