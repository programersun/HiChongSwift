//
//  GetUserInfoUserInfo.h
//
//  Created by 超逸 李 on 15/1/6
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GetUserInfoUserInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *fansCount;
@property (nonatomic, strong) NSString *wechat;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *friendCount;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *fQq;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *fTip;
@property (nonatomic, strong) NSString *fCellphone;
@property (nonatomic, strong) NSString *town;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *fTelephone;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *tip;
@property (nonatomic, strong) NSString *fWeibo;
@property (nonatomic, strong) NSString *weibo;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *fAddress;
@property (nonatomic, strong) NSString *qq;
@property (nonatomic, strong) NSString *fLocation;
@property (nonatomic, assign) double starCount;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *fWechat;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
