//
//  CCPSysMessage.h
//  CloudPushSDK
//
//  Created by wuxiang on 15/8/6.
//  Copyright © 2015年 aliyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCPSysMessage : NSObject

@property UInt8 messageType;// 消息类型
@property NSData *title; // 标题
@property NSData *body; // 内容

@end
