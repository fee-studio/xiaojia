//
//  YWP2PConversation.h
//  
//
//  Created by huanglei on 14/12/17.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "YWConversation.h"


@class YWPerson;
@class YWIMCore;
/**
 单聊会话
 */
@interface YWP2PConversation : YWConversation

/**
 *  获取某个单聊会话
 *  @param WXOPerson 会话对象
 *  @param aCreateIfNotExist 如果还不存在，则创建会话
 *  @return 需要获取的会话。如果本地不存在该会话且不需要新建，则返回nil
 */
+ (instancetype)fetchConversationByPerson:(YWPerson *)person creatIfNotExist:(BOOL)aCreateIfNotExist baseContext:(YWIMCore *)aBaseContext;

/**
 *  获取消息接收者的已读未读标记
 *  @param messageIds,需要获取的 id<IYWMessage> 数组
 *  @param completion,回调
 *  注意，启用已读未读功能需要将 IYWConversationService 中 enableMessageReadFlag 置为 YES
 */
- (void)roamingReceiverReadFlagForMessages:(NSArray *)messages withCompletionBlock:(YWCompletionBlock)completion;

/// 消息被对方读掉的通知，只有在线时收到的才会发出通知（漫游下来变更的不会通知）
FOUNDATION_EXTERN NSString *const YWP2PConversationNotificationReceiverHasRead;
/// 使用这个key传递ConversationId
FOUNDATION_EXTERN NSString *const YWP2PConversationNotificationReceiverHasReadKeyConversationId;
/// 使用这个key传递msgId的数组
FOUNDATION_EXTERN NSString *const YWP2PConversationNotificationReceiverHasReadKeyMsgIds;



/**
 *  该单聊会话的person对象
 */
@property (nonatomic, strong, readonly) YWPerson *person;

@end
