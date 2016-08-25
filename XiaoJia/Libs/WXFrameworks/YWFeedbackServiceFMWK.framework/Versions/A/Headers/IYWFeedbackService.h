//
//  IYWFeedbackService.h
//  WXOpenIMSDK
//
//  Created by 慕桥(黄玉坤) on 15/12/28.
//  Copyright © 2015年 taobao. All rights reserved.
//

#ifndef IYWFeedbackService_h
#define IYWFeedbackService_h

@class YWIMCore;
@class YWPerson;
@class YWFeedbackConversation;

#define YWAnonFeedbackService YWExtensionServiceFromProtocol(IYWFeedbackService)
#define YWFeedbackServiceForIMCore(imCore) YWIMCoreExtensionServiceFromProtocol(IYWFeedbackService, imCore)

#pragma mark - 服务接口定义

@protocol IYWFeedbackService <NSObject>

/// @brief App自定义扩展反馈数据，需在登陆前设置
@property (nonatomic, strong, readonly) NSDictionary *extInfo;
- (void)setExtInfo:(NSDictionary *)extInfo;

/// @brief 创建并初始化反馈会话回调Block
/// @param conversation 反馈会话
/// @param error 创建失败错误
typedef void (^YWMakeFeedbackConversationCompletionBlock) (YWFeedbackConversation *conversation, NSError *error);

/// @brief 创建并初始化反馈Conversation
- (void)makeFeedbackConversationWithCompletionBlock:(YWMakeFeedbackConversationCompletionBlock)completionBlock;

/// @brief 查询反馈未读消息回调Block
/// @param unreadCount 未读数
/// @param error 查询失败错误
typedef void (^YWGetUnreadCountCompletionBlock) (NSNumber *unreadCount, NSError *error);

/// @brief 查询反馈未读消息
- (void)getUnreadCountWithCompletionBlock:(YWGetUnreadCountCompletionBlock)completionBlock;

/// @brief 匿名反馈消息接收通知回调Block
/// @param aIsLaunching 是否点击Push启动的App
/// @param aState app当前状态，您可以判断是否是由于用户划开push，导致app从后台进入前台
typedef void(^YWFeedbackOnNewMessageBlock)(BOOL aIsLaunching, UIApplicationState aState);

/// @brief 反馈消息接收通知回调 App切后台可接收Push，点击Push或App在前台可通过该接口获取消息接收通知
/// 需要在程序启动后(application:didFinishLaunchingWithOptions:)调用该接口来接收消息接收通知
- (void)setOnNewMessageBlock:(YWFeedbackOnNewMessageBlock)onNewMessageBlock;

/// @brief 添加反馈消息接收通知回调
/// @param key 用来区分不同的监听者，一般可以使用监听对象的description
/// @param priority YWBlockPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriorityDeveloper
- (void)addOnNewMessageBlock:(YWFeedbackOnNewMessageBlock)onNewMessageBlock
                      forKey:(NSString *)key ofPriority:(YWBlockPriority)priority;

/// @brief 移除反馈消息接收通知回调
/// @param key 用来区分不同的监听者，一般可以使用监听对象的description
- (void)removeAddContactResponseBlockWithKey:(NSString *)key;

/// @brief 当需要自定义Profile时使用，用于判断是否是一个反馈接受账号。
/// @param aPerson YWPerson对象
- (BOOL)isFeedbackReceiver:(YWPerson *)aPerson;

/// @brief 当需要自定义Profile时使用，用于判断是否是一个反馈发送账号。
/// @param aPerson YWPerson对象
- (BOOL)isFeedbackSender:(YWPerson *)aPerson;

@end

#endif /* IYWFeedbackService_h */
