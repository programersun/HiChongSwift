//
//  DianpingBusinesses.h
//
//  Created by 超逸 李 on 15/1/7
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DianpingBusinesses : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *branchName;
@property (nonatomic, strong) NSString *ratingSImgUrl;
@property (nonatomic, assign) double dealCount;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, assign) double hasDeal;
@property (nonatomic, strong) NSString *couponUrl;
@property (nonatomic, assign) double productScore;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *onlineReservationUrl;
@property (nonatomic, strong) NSString *reviewListUrl;
@property (nonatomic, strong) NSString *couponDescription;
@property (nonatomic, assign) double productGrade;
@property (nonatomic, strong) NSString *businessUrl;
@property (nonatomic, strong) NSString *photoListUrl;
@property (nonatomic, assign) double distance;
@property (nonatomic, assign) double avgRating;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double hasOnlineReservation;
@property (nonatomic, assign) double longitude;
@property (nonatomic, strong) NSString *ratingImgUrl;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, assign) double serviceScore;
@property (nonatomic, assign) double hasCoupon;
@property (nonatomic, assign) double businessId;
@property (nonatomic, strong) NSArray *deals;
@property (nonatomic, assign) double couponId;
@property (nonatomic, assign) double decorationGrade;
@property (nonatomic, assign) double serviceGrade;
@property (nonatomic, strong) NSString *photoUrl;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, assign) double reviewCount;
@property (nonatomic, strong) NSArray *regions;
@property (nonatomic, assign) double avgPrice;
@property (nonatomic, strong) NSString *sPhotoUrl;
@property (nonatomic, assign) double photoCount;
@property (nonatomic, assign) double decorationScore;
@property (nonatomic, assign) double latitude;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
