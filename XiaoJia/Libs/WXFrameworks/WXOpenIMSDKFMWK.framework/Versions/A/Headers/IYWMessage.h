//
//  IYWMessage.h
//
//
//  Created by huanglei on 14/12/11.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YWPerson.h"
#import "YWMessageBody.h"

/**
 * 消息发送状态
 */
typedef NS_ENUM(NSUInteger, YWMessageSendStatus) {
    /// 待发送
    YWMessageSendStatusPending = 1,
    /// 发送消息内容
    YWMessageSendStatusSendingContent,
    /// 发送消息信息
    YWMessageSendStatusSendingMsg,
    /// 发送成功
    YWMessageSendStatusSuccess,
    /// 发送失败
    YWMessageSendStatusFailed
};

@protocol IYWMessage <NSObject>

/**
 *  消息Id
 */
@property (nonatomic, copy, readonly) NSString *messageId;

/**
 * 发送者
 */
@property (nonatomic, strong, readonly) YWPerson *messageFromPerson;

/**
 * 接收者
 */
@property (nonatomic, strong, readonly) YWPerson *messageToPerson;

/**
 * 消息发送状态
 */
@property (nonatomic, assign, readonly) YWMessageSendStatus messageSendStatus;

/**
 * 所属会话
 */
@property (nonatomic, copy, readonly) NSString *conversationId;


/**
 * 消息内容
 */
@property (nonatomic, strong, readonly) YWMessageBody *messageBody;

/**
 * 消息发送的时间
 */
@property (nonatomic, strong, readonly) NSDate *time;

/**
 * 消息是否是对外发送
 */
@property (nonatomic, assign, readonly) BOOL outgoing;

/**
 * 消息自己是否已读
 */
@property (nonatomic, assign, readonly) BOOL hasReaded;

/**
 * 消息接收者是否已读
 */
@property (nonatomic, assign, readonly) BOOL receiverHasReaded;

/**
 * 消息内容来源
 */
@property (nonatomic, strong, readonly) NSString *ownerName;

@end
