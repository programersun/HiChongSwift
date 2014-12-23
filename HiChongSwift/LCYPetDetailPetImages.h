//
//  LCYPetDetailPetImages.h
//
//  Created by 超逸 李 on 14/12/24
//  Copyright (c) 2014 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LCYPetDetailPetImages : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *petId;
@property (nonatomic, strong) NSString *cutHeight;
@property (nonatomic, strong) NSString *petImg;
@property (nonatomic, strong) NSString *petImagesIdentifier;
@property (nonatomic, strong) NSString *cutImg;
@property (nonatomic, strong) NSString *imgWidth;
@property (nonatomic, strong) NSString *imgHeight;
@property (nonatomic, strong) NSString *cutWidth;
@property (nonatomic, strong) NSString *addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
