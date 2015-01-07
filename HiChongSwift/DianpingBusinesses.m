//
//  DianpingBusinesses.m
//
//  Created by 超逸 李 on 15/1/7
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import "DianpingBusinesses.h"
#import "DianpingDeals.h"


NSString *const kDianpingBusinessesBranchName = @"branch_name";
NSString *const kDianpingBusinessesRatingSImgUrl = @"rating_s_img_url";
NSString *const kDianpingBusinessesDealCount = @"deal_count";
NSString *const kDianpingBusinessesTelephone = @"telephone";
NSString *const kDianpingBusinessesHasDeal = @"has_deal";
NSString *const kDianpingBusinessesCouponUrl = @"coupon_url";
NSString *const kDianpingBusinessesProductScore = @"product_score";
NSString *const kDianpingBusinessesAddress = @"address";
NSString *const kDianpingBusinessesOnlineReservationUrl = @"online_reservation_url";
NSString *const kDianpingBusinessesReviewListUrl = @"review_list_url";
NSString *const kDianpingBusinessesCouponDescription = @"coupon_description";
NSString *const kDianpingBusinessesProductGrade = @"product_grade";
NSString *const kDianpingBusinessesBusinessUrl = @"business_url";
NSString *const kDianpingBusinessesPhotoListUrl = @"photo_list_url";
NSString *const kDianpingBusinessesDistance = @"distance";
NSString *const kDianpingBusinessesAvgRating = @"avg_rating";
NSString *const kDianpingBusinessesName = @"name";
NSString *const kDianpingBusinessesHasOnlineReservation = @"has_online_reservation";
NSString *const kDianpingBusinessesLongitude = @"longitude";
NSString *const kDianpingBusinessesRatingImgUrl = @"rating_img_url";
NSString *const kDianpingBusinessesCity = @"city";
NSString *const kDianpingBusinessesServiceScore = @"service_score";
NSString *const kDianpingBusinessesHasCoupon = @"has_coupon";
NSString *const kDianpingBusinessesBusinessId = @"business_id";
NSString *const kDianpingBusinessesDeals = @"deals";
NSString *const kDianpingBusinessesCouponId = @"coupon_id";
NSString *const kDianpingBusinessesDecorationGrade = @"decoration_grade";
NSString *const kDianpingBusinessesServiceGrade = @"service_grade";
NSString *const kDianpingBusinessesPhotoUrl = @"photo_url";
NSString *const kDianpingBusinessesCategories = @"categories";
NSString *const kDianpingBusinessesReviewCount = @"review_count";
NSString *const kDianpingBusinessesRegions = @"regions";
NSString *const kDianpingBusinessesAvgPrice = @"avg_price";
NSString *const kDianpingBusinessesSPhotoUrl = @"s_photo_url";
NSString *const kDianpingBusinessesPhotoCount = @"photo_count";
NSString *const kDianpingBusinessesDecorationScore = @"decoration_score";
NSString *const kDianpingBusinessesLatitude = @"latitude";


@interface DianpingBusinesses ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DianpingBusinesses

@synthesize branchName = _branchName;
@synthesize ratingSImgUrl = _ratingSImgUrl;
@synthesize dealCount = _dealCount;
@synthesize telephone = _telephone;
@synthesize hasDeal = _hasDeal;
@synthesize couponUrl = _couponUrl;
@synthesize productScore = _productScore;
@synthesize address = _address;
@synthesize onlineReservationUrl = _onlineReservationUrl;
@synthesize reviewListUrl = _reviewListUrl;
@synthesize couponDescription = _couponDescription;
@synthesize productGrade = _productGrade;
@synthesize businessUrl = _businessUrl;
@synthesize photoListUrl = _photoListUrl;
@synthesize distance = _distance;
@synthesize avgRating = _avgRating;
@synthesize name = _name;
@synthesize hasOnlineReservation = _hasOnlineReservation;
@synthesize longitude = _longitude;
@synthesize ratingImgUrl = _ratingImgUrl;
@synthesize city = _city;
@synthesize serviceScore = _serviceScore;
@synthesize hasCoupon = _hasCoupon;
@synthesize businessId = _businessId;
@synthesize deals = _deals;
@synthesize couponId = _couponId;
@synthesize decorationGrade = _decorationGrade;
@synthesize serviceGrade = _serviceGrade;
@synthesize photoUrl = _photoUrl;
@synthesize categories = _categories;
@synthesize reviewCount = _reviewCount;
@synthesize regions = _regions;
@synthesize avgPrice = _avgPrice;
@synthesize sPhotoUrl = _sPhotoUrl;
@synthesize photoCount = _photoCount;
@synthesize decorationScore = _decorationScore;
@synthesize latitude = _latitude;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.branchName = [self objectOrNilForKey:kDianpingBusinessesBranchName fromDictionary:dict];
            self.ratingSImgUrl = [self objectOrNilForKey:kDianpingBusinessesRatingSImgUrl fromDictionary:dict];
            self.dealCount = [[self objectOrNilForKey:kDianpingBusinessesDealCount fromDictionary:dict] doubleValue];
            self.telephone = [self objectOrNilForKey:kDianpingBusinessesTelephone fromDictionary:dict];
            self.hasDeal = [[self objectOrNilForKey:kDianpingBusinessesHasDeal fromDictionary:dict] doubleValue];
            self.couponUrl = [self objectOrNilForKey:kDianpingBusinessesCouponUrl fromDictionary:dict];
            self.productScore = [[self objectOrNilForKey:kDianpingBusinessesProductScore fromDictionary:dict] doubleValue];
            self.address = [self objectOrNilForKey:kDianpingBusinessesAddress fromDictionary:dict];
            self.onlineReservationUrl = [self objectOrNilForKey:kDianpingBusinessesOnlineReservationUrl fromDictionary:dict];
            self.reviewListUrl = [self objectOrNilForKey:kDianpingBusinessesReviewListUrl fromDictionary:dict];
            self.couponDescription = [self objectOrNilForKey:kDianpingBusinessesCouponDescription fromDictionary:dict];
            self.productGrade = [[self objectOrNilForKey:kDianpingBusinessesProductGrade fromDictionary:dict] doubleValue];
            self.businessUrl = [self objectOrNilForKey:kDianpingBusinessesBusinessUrl fromDictionary:dict];
            self.photoListUrl = [self objectOrNilForKey:kDianpingBusinessesPhotoListUrl fromDictionary:dict];
            self.distance = [[self objectOrNilForKey:kDianpingBusinessesDistance fromDictionary:dict] doubleValue];
            self.avgRating = [[self objectOrNilForKey:kDianpingBusinessesAvgRating fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kDianpingBusinessesName fromDictionary:dict];
            self.hasOnlineReservation = [[self objectOrNilForKey:kDianpingBusinessesHasOnlineReservation fromDictionary:dict] doubleValue];
            self.longitude = [[self objectOrNilForKey:kDianpingBusinessesLongitude fromDictionary:dict] doubleValue];
            self.ratingImgUrl = [self objectOrNilForKey:kDianpingBusinessesRatingImgUrl fromDictionary:dict];
            self.city = [self objectOrNilForKey:kDianpingBusinessesCity fromDictionary:dict];
            self.serviceScore = [[self objectOrNilForKey:kDianpingBusinessesServiceScore fromDictionary:dict] doubleValue];
            self.hasCoupon = [[self objectOrNilForKey:kDianpingBusinessesHasCoupon fromDictionary:dict] doubleValue];
            self.businessId = [[self objectOrNilForKey:kDianpingBusinessesBusinessId fromDictionary:dict] doubleValue];
    NSObject *receivedDianpingDeals = [dict objectForKey:kDianpingBusinessesDeals];
    NSMutableArray *parsedDianpingDeals = [NSMutableArray array];
    if ([receivedDianpingDeals isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedDianpingDeals) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedDianpingDeals addObject:[DianpingDeals modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedDianpingDeals isKindOfClass:[NSDictionary class]]) {
       [parsedDianpingDeals addObject:[DianpingDeals modelObjectWithDictionary:(NSDictionary *)receivedDianpingDeals]];
    }

    self.deals = [NSArray arrayWithArray:parsedDianpingDeals];
            self.couponId = [[self objectOrNilForKey:kDianpingBusinessesCouponId fromDictionary:dict] doubleValue];
            self.decorationGrade = [[self objectOrNilForKey:kDianpingBusinessesDecorationGrade fromDictionary:dict] doubleValue];
            self.serviceGrade = [[self objectOrNilForKey:kDianpingBusinessesServiceGrade fromDictionary:dict] doubleValue];
            self.photoUrl = [self objectOrNilForKey:kDianpingBusinessesPhotoUrl fromDictionary:dict];
            self.categories = [self objectOrNilForKey:kDianpingBusinessesCategories fromDictionary:dict];
            self.reviewCount = [[self objectOrNilForKey:kDianpingBusinessesReviewCount fromDictionary:dict] doubleValue];
            self.regions = [self objectOrNilForKey:kDianpingBusinessesRegions fromDictionary:dict];
            self.avgPrice = [[self objectOrNilForKey:kDianpingBusinessesAvgPrice fromDictionary:dict] doubleValue];
            self.sPhotoUrl = [self objectOrNilForKey:kDianpingBusinessesSPhotoUrl fromDictionary:dict];
            self.photoCount = [[self objectOrNilForKey:kDianpingBusinessesPhotoCount fromDictionary:dict] doubleValue];
            self.decorationScore = [[self objectOrNilForKey:kDianpingBusinessesDecorationScore fromDictionary:dict] doubleValue];
            self.latitude = [[self objectOrNilForKey:kDianpingBusinessesLatitude fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.branchName forKey:kDianpingBusinessesBranchName];
    [mutableDict setValue:self.ratingSImgUrl forKey:kDianpingBusinessesRatingSImgUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dealCount] forKey:kDianpingBusinessesDealCount];
    [mutableDict setValue:self.telephone forKey:kDianpingBusinessesTelephone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.hasDeal] forKey:kDianpingBusinessesHasDeal];
    [mutableDict setValue:self.couponUrl forKey:kDianpingBusinessesCouponUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productScore] forKey:kDianpingBusinessesProductScore];
    [mutableDict setValue:self.address forKey:kDianpingBusinessesAddress];
    [mutableDict setValue:self.onlineReservationUrl forKey:kDianpingBusinessesOnlineReservationUrl];
    [mutableDict setValue:self.reviewListUrl forKey:kDianpingBusinessesReviewListUrl];
    [mutableDict setValue:self.couponDescription forKey:kDianpingBusinessesCouponDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.productGrade] forKey:kDianpingBusinessesProductGrade];
    [mutableDict setValue:self.businessUrl forKey:kDianpingBusinessesBusinessUrl];
    [mutableDict setValue:self.photoListUrl forKey:kDianpingBusinessesPhotoListUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.distance] forKey:kDianpingBusinessesDistance];
    [mutableDict setValue:[NSNumber numberWithDouble:self.avgRating] forKey:kDianpingBusinessesAvgRating];
    [mutableDict setValue:self.name forKey:kDianpingBusinessesName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.hasOnlineReservation] forKey:kDianpingBusinessesHasOnlineReservation];
    [mutableDict setValue:[NSNumber numberWithDouble:self.longitude] forKey:kDianpingBusinessesLongitude];
    [mutableDict setValue:self.ratingImgUrl forKey:kDianpingBusinessesRatingImgUrl];
    [mutableDict setValue:self.city forKey:kDianpingBusinessesCity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.serviceScore] forKey:kDianpingBusinessesServiceScore];
    [mutableDict setValue:[NSNumber numberWithDouble:self.hasCoupon] forKey:kDianpingBusinessesHasCoupon];
    [mutableDict setValue:[NSNumber numberWithDouble:self.businessId] forKey:kDianpingBusinessesBusinessId];
    NSMutableArray *tempArrayForDeals = [NSMutableArray array];
    for (NSObject *subArrayObject in self.deals) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForDeals addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForDeals addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForDeals] forKey:kDianpingBusinessesDeals];
    [mutableDict setValue:[NSNumber numberWithDouble:self.couponId] forKey:kDianpingBusinessesCouponId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.decorationGrade] forKey:kDianpingBusinessesDecorationGrade];
    [mutableDict setValue:[NSNumber numberWithDouble:self.serviceGrade] forKey:kDianpingBusinessesServiceGrade];
    [mutableDict setValue:self.photoUrl forKey:kDianpingBusinessesPhotoUrl];
    NSMutableArray *tempArrayForCategories = [NSMutableArray array];
    for (NSObject *subArrayObject in self.categories) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCategories addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCategories addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCategories] forKey:kDianpingBusinessesCategories];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewCount] forKey:kDianpingBusinessesReviewCount];
    NSMutableArray *tempArrayForRegions = [NSMutableArray array];
    for (NSObject *subArrayObject in self.regions) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRegions addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRegions addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRegions] forKey:kDianpingBusinessesRegions];
    [mutableDict setValue:[NSNumber numberWithDouble:self.avgPrice] forKey:kDianpingBusinessesAvgPrice];
    [mutableDict setValue:self.sPhotoUrl forKey:kDianpingBusinessesSPhotoUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.photoCount] forKey:kDianpingBusinessesPhotoCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.decorationScore] forKey:kDianpingBusinessesDecorationScore];
    [mutableDict setValue:[NSNumber numberWithDouble:self.latitude] forKey:kDianpingBusinessesLatitude];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.branchName = [aDecoder decodeObjectForKey:kDianpingBusinessesBranchName];
    self.ratingSImgUrl = [aDecoder decodeObjectForKey:kDianpingBusinessesRatingSImgUrl];
    self.dealCount = [aDecoder decodeDoubleForKey:kDianpingBusinessesDealCount];
    self.telephone = [aDecoder decodeObjectForKey:kDianpingBusinessesTelephone];
    self.hasDeal = [aDecoder decodeDoubleForKey:kDianpingBusinessesHasDeal];
    self.couponUrl = [aDecoder decodeObjectForKey:kDianpingBusinessesCouponUrl];
    self.productScore = [aDecoder decodeDoubleForKey:kDianpingBusinessesProductScore];
    self.address = [aDecoder decodeObjectForKey:kDianpingBusinessesAddress];
    self.onlineReservationUrl = [aDecoder decodeObjectForKey:kDianpingBusinessesOnlineReservationUrl];
    self.reviewListUrl = [aDecoder decodeObjectForKey:kDianpingBusinessesReviewListUrl];
    self.couponDescription = [aDecoder decodeObjectForKey:kDianpingBusinessesCouponDescription];
    self.productGrade = [aDecoder decodeDoubleForKey:kDianpingBusinessesProductGrade];
    self.businessUrl = [aDecoder decodeObjectForKey:kDianpingBusinessesBusinessUrl];
    self.photoListUrl = [aDecoder decodeObjectForKey:kDianpingBusinessesPhotoListUrl];
    self.distance = [aDecoder decodeDoubleForKey:kDianpingBusinessesDistance];
    self.avgRating = [aDecoder decodeDoubleForKey:kDianpingBusinessesAvgRating];
    self.name = [aDecoder decodeObjectForKey:kDianpingBusinessesName];
    self.hasOnlineReservation = [aDecoder decodeDoubleForKey:kDianpingBusinessesHasOnlineReservation];
    self.longitude = [aDecoder decodeDoubleForKey:kDianpingBusinessesLongitude];
    self.ratingImgUrl = [aDecoder decodeObjectForKey:kDianpingBusinessesRatingImgUrl];
    self.city = [aDecoder decodeObjectForKey:kDianpingBusinessesCity];
    self.serviceScore = [aDecoder decodeDoubleForKey:kDianpingBusinessesServiceScore];
    self.hasCoupon = [aDecoder decodeDoubleForKey:kDianpingBusinessesHasCoupon];
    self.businessId = [aDecoder decodeDoubleForKey:kDianpingBusinessesBusinessId];
    self.deals = [aDecoder decodeObjectForKey:kDianpingBusinessesDeals];
    self.couponId = [aDecoder decodeDoubleForKey:kDianpingBusinessesCouponId];
    self.decorationGrade = [aDecoder decodeDoubleForKey:kDianpingBusinessesDecorationGrade];
    self.serviceGrade = [aDecoder decodeDoubleForKey:kDianpingBusinessesServiceGrade];
    self.photoUrl = [aDecoder decodeObjectForKey:kDianpingBusinessesPhotoUrl];
    self.categories = [aDecoder decodeObjectForKey:kDianpingBusinessesCategories];
    self.reviewCount = [aDecoder decodeDoubleForKey:kDianpingBusinessesReviewCount];
    self.regions = [aDecoder decodeObjectForKey:kDianpingBusinessesRegions];
    self.avgPrice = [aDecoder decodeDoubleForKey:kDianpingBusinessesAvgPrice];
    self.sPhotoUrl = [aDecoder decodeObjectForKey:kDianpingBusinessesSPhotoUrl];
    self.photoCount = [aDecoder decodeDoubleForKey:kDianpingBusinessesPhotoCount];
    self.decorationScore = [aDecoder decodeDoubleForKey:kDianpingBusinessesDecorationScore];
    self.latitude = [aDecoder decodeDoubleForKey:kDianpingBusinessesLatitude];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_branchName forKey:kDianpingBusinessesBranchName];
    [aCoder encodeObject:_ratingSImgUrl forKey:kDianpingBusinessesRatingSImgUrl];
    [aCoder encodeDouble:_dealCount forKey:kDianpingBusinessesDealCount];
    [aCoder encodeObject:_telephone forKey:kDianpingBusinessesTelephone];
    [aCoder encodeDouble:_hasDeal forKey:kDianpingBusinessesHasDeal];
    [aCoder encodeObject:_couponUrl forKey:kDianpingBusinessesCouponUrl];
    [aCoder encodeDouble:_productScore forKey:kDianpingBusinessesProductScore];
    [aCoder encodeObject:_address forKey:kDianpingBusinessesAddress];
    [aCoder encodeObject:_onlineReservationUrl forKey:kDianpingBusinessesOnlineReservationUrl];
    [aCoder encodeObject:_reviewListUrl forKey:kDianpingBusinessesReviewListUrl];
    [aCoder encodeObject:_couponDescription forKey:kDianpingBusinessesCouponDescription];
    [aCoder encodeDouble:_productGrade forKey:kDianpingBusinessesProductGrade];
    [aCoder encodeObject:_businessUrl forKey:kDianpingBusinessesBusinessUrl];
    [aCoder encodeObject:_photoListUrl forKey:kDianpingBusinessesPhotoListUrl];
    [aCoder encodeDouble:_distance forKey:kDianpingBusinessesDistance];
    [aCoder encodeDouble:_avgRating forKey:kDianpingBusinessesAvgRating];
    [aCoder encodeObject:_name forKey:kDianpingBusinessesName];
    [aCoder encodeDouble:_hasOnlineReservation forKey:kDianpingBusinessesHasOnlineReservation];
    [aCoder encodeDouble:_longitude forKey:kDianpingBusinessesLongitude];
    [aCoder encodeObject:_ratingImgUrl forKey:kDianpingBusinessesRatingImgUrl];
    [aCoder encodeObject:_city forKey:kDianpingBusinessesCity];
    [aCoder encodeDouble:_serviceScore forKey:kDianpingBusinessesServiceScore];
    [aCoder encodeDouble:_hasCoupon forKey:kDianpingBusinessesHasCoupon];
    [aCoder encodeDouble:_businessId forKey:kDianpingBusinessesBusinessId];
    [aCoder encodeObject:_deals forKey:kDianpingBusinessesDeals];
    [aCoder encodeDouble:_couponId forKey:kDianpingBusinessesCouponId];
    [aCoder encodeDouble:_decorationGrade forKey:kDianpingBusinessesDecorationGrade];
    [aCoder encodeDouble:_serviceGrade forKey:kDianpingBusinessesServiceGrade];
    [aCoder encodeObject:_photoUrl forKey:kDianpingBusinessesPhotoUrl];
    [aCoder encodeObject:_categories forKey:kDianpingBusinessesCategories];
    [aCoder encodeDouble:_reviewCount forKey:kDianpingBusinessesReviewCount];
    [aCoder encodeObject:_regions forKey:kDianpingBusinessesRegions];
    [aCoder encodeDouble:_avgPrice forKey:kDianpingBusinessesAvgPrice];
    [aCoder encodeObject:_sPhotoUrl forKey:kDianpingBusinessesSPhotoUrl];
    [aCoder encodeDouble:_photoCount forKey:kDianpingBusinessesPhotoCount];
    [aCoder encodeDouble:_decorationScore forKey:kDianpingBusinessesDecorationScore];
    [aCoder encodeDouble:_latitude forKey:kDianpingBusinessesLatitude];
}

- (id)copyWithZone:(NSZone *)zone
{
    DianpingBusinesses *copy = [[DianpingBusinesses alloc] init];
    
    if (copy) {

        copy.branchName = [self.branchName copyWithZone:zone];
        copy.ratingSImgUrl = [self.ratingSImgUrl copyWithZone:zone];
        copy.dealCount = self.dealCount;
        copy.telephone = [self.telephone copyWithZone:zone];
        copy.hasDeal = self.hasDeal;
        copy.couponUrl = [self.couponUrl copyWithZone:zone];
        copy.productScore = self.productScore;
        copy.address = [self.address copyWithZone:zone];
        copy.onlineReservationUrl = [self.onlineReservationUrl copyWithZone:zone];
        copy.reviewListUrl = [self.reviewListUrl copyWithZone:zone];
        copy.couponDescription = [self.couponDescription copyWithZone:zone];
        copy.productGrade = self.productGrade;
        copy.businessUrl = [self.businessUrl copyWithZone:zone];
        copy.photoListUrl = [self.photoListUrl copyWithZone:zone];
        copy.distance = self.distance;
        copy.avgRating = self.avgRating;
        copy.name = [self.name copyWithZone:zone];
        copy.hasOnlineReservation = self.hasOnlineReservation;
        copy.longitude = self.longitude;
        copy.ratingImgUrl = [self.ratingImgUrl copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.serviceScore = self.serviceScore;
        copy.hasCoupon = self.hasCoupon;
        copy.businessId = self.businessId;
        copy.deals = [self.deals copyWithZone:zone];
        copy.couponId = self.couponId;
        copy.decorationGrade = self.decorationGrade;
        copy.serviceGrade = self.serviceGrade;
        copy.photoUrl = [self.photoUrl copyWithZone:zone];
        copy.categories = [self.categories copyWithZone:zone];
        copy.reviewCount = self.reviewCount;
        copy.regions = [self.regions copyWithZone:zone];
        copy.avgPrice = self.avgPrice;
        copy.sPhotoUrl = [self.sPhotoUrl copyWithZone:zone];
        copy.photoCount = self.photoCount;
        copy.decorationScore = self.decorationScore;
        copy.latitude = self.latitude;
    }
    
    return copy;
}


@end
