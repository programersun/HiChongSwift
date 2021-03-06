//
//  MessageSender.h
//  HiChongSwift
//
//  Created by eagle on 15/2/6.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "lib/WeiboSDK.h"

@interface MessageSender : NSObject

- (void)sendAppContent;

- (void)sendWeiboContent:(WBBaseMediaObject *)message;

@end
