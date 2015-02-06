//
//  MessageSender.m
//  HiChongSwift
//
//  Created by eagle on 15/2/6.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

#import "MessageSender.h"
#import "lib/WXApi.h"


@interface MessageSender ()
{
    enum WXScene _scene;
}
@end

@implementation MessageSender

- (instancetype)init {
    if (self = [super init]){
        _scene = WXSceneSession;
    }
    return self;
}

#define BUFFER_SIZE 1024 * 100

- (void)sendAppContent {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"App消息";
    message.description = @"这种消息只有App自己才能理解，由App指定打开方式！";
    [message setThumbImage:[UIImage imageNamed:@"res2.jpg"]];
    message.messageExt = @"这是第三方带的测试字段";
    message.messageAction = @"<action>dotaliTest</action>";
    
    WXAppExtendObject *ext = [WXAppExtendObject object];
    ext.extInfo = @"<xml>extend info</xml>";
    ext.url = @"http://weixin.qq.com";
    
//    Byte* pBuffer = (Byte *)malloc(BUFFER_SIZE);
//    memset(pBuffer, 0, BUFFER_SIZE);
//    NSData* data = [NSData dataWithBytes:pBuffer length:BUFFER_SIZE];
//    free(pBuffer);
//    
//    ext.fileData = data;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;
    
    [WXApi sendReq:req];
}

- (void)sendWeiboContent:(WBMessageObject *)message {
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = @"";
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:@"3704764004"];
    request.userInfo = @{@"zombieKey": @"zombieValue"};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}

@end
