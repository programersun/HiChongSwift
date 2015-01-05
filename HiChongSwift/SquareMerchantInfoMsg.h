//
//  SquareMerchantInfoMsg.h
//
//  Created by 超逸 李 on 15/1/5
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SquareMerchantInfoMsg : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *businessDetail;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *businessPhone;
@property (nonatomic, strong) NSString *businessMapNote;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *businessLongitude;
@property (nonatomic, strong) NSString *businessImage;
@property (nonatomic, strong) NSString *town;
@property (nonatomic, strong) NSString *businessLatitude;
@property (nonatomic, strong) NSString *businessName;
@property (nonatomic, strong) NSString *businessId;
@property (nonatomic, strong) NSString *businessScore;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *businessBrief;
@property (nonatomic, strong) NSString *businessLocation;
@property (nonatomic, strong) NSString *addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
