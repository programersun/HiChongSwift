//
//  UserSearchFriendPets.h
//
//  Created by 超逸 李 on 15/2/2
//  Copyright (c) 2015 Duostec. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserSearchFriendPets : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *petId;
@property (nonatomic, strong) NSString *petHeadImage;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
