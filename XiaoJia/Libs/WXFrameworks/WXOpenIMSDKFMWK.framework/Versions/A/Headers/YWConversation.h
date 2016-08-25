//
//  YWConversation.h
//  
//
//  Created by huanglei on 14/12/17.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YWServiceDef.h"
#import "YWConversationServiceDef.h"

@protocol IYWMessage;

@class YWMessageBody;
@class YWIMCore;


/**
 * 会话基类
 */

@interface YWConversation : NSObject

#pragma mark - 会话基本信息

/**
 *  @virtual
 *  会话Id
 */
@property (nonatomic, readonly) NSString *conversationId;

/**
 *  @virtual
 *  会话最后消息
 */
@property (nonatomic, readonly) NSString *conversationLatestMessageContent;

/**
 *  @virtual
 *  会话最后消息
 */
@property (nonatomic, readonly) id<IYWMessage> conversationLatestMessage;

/**
 *  @virtual
 *  会话最后消息时间
 */
@property (nonatomic, readonly) NSDate *conversationLatestMessageTime;

/**
 *  @virtual
 *  会话未读消息数
 */
@property (nonatomic, readonly) NSNumber *conversationUnreadMessagesCount;

@property (nonatomic, readonly) YWConversationType conversationType;

/**
 *  会话未发送的草稿
 */
@property (nonatomic, copy) NSString *conversationDraft;

/**
 *  会话未发送的草稿更新时间
 */
@property (nonatomic, readonly) NSDate *conversationDraftUpdateTime;

#pragma mark - 会话操作

/**
 * 将会话标记为已读
 */
- (void)markConversationAsRead;

/**
 *  将会话置顶或者取消置顶，请在主线程调用
 *  如果是置顶，则以某个时间为置顶时间，注意，越是大的时间，越是在前面
 *  @param aTime 置顶时间，比如[date timeIntervalSince1970]
 */
- (BOOL)markConversationOnTop:(BOOL)aOnTop time:(NSTimeInterval)aTime getError:(NSError **)aError;
/**
 *  将会话置顶或者取消置顶，请在主线程调用
 *  如果是置顶，以当前时间为置顶时间
 */
- (BOOL)markConversationOnTop:(BOOL)aOnTop getError:(NSError **)aError;

/// 置顶时间，可用于排序，为0则为不置顶
- (NSTimeInterval)markedOnTopTime;

/**
 *  @virtual 子类需要实现
 *  类方法，获取一个Conversation
 *  @param aConversationId 会话Id
 *  @param aCreateIfNotExsit 如果会话不存在，是否创建会话。如果不存在且不创建，则返回nil
 *  @param aBaseContext 用户上下文对象。
 */

+ (instancetype)fetchConversationByConversationId:(NSString *)aConversationId
                                  creatIfNotExist:(BOOL)aCreateIfNotExist
                                      baseContext:(YWIMCore *)aBaseContext;
#pragma mark - 消息发送

/**
 *  异步发送一条消息
 *  @param aMessageBody 消息体
 *  @param aControlParameters 消息控制参数，key的定义请参考：YWConversationServiceDef.h
 *  @param aProgress 消息发送进度的回调
 *  @param aCompletion 消息发送结束的回调
 */

- (void)asyncSendMessageBody:(YWMessageBody *)aMessageBody
           controlParameters:(NSDictionary *)aControlParameters
                    progress:(YWMessageSendingProgressBlock)aProgress
                  completion:(YWMessageSendingCompletionBlock)aCompletion;

/**
 *  异步转发一条消息到本会话
 *  @param aMessage 需要转发的消息
 *  @param aControlParameters 消息控制参数，key的定义请参考：YWConversationServiceDef.h
 *  @param aProgress 消息发送进度的回调
 *  @param aCompletion 消息发送结束的回调
 */
- (void)asyncForwardMessage:(id<IYWMessage>)aMessage
          controlParameters:(NSDictionary *)aControlParameters
                   progress:(YWMessageSendingProgressBlock)aProgress
                 completion:(YWMessageSendingCompletionBlock)aCompletion;

/**
 *  异步发送一条消息
 *  @param aMessageBody 消息体
 *  @param aProgress 消息发送进度的回调
 *  @param aCompletion 消息发送结束的回调
 */

- (void)asyncSendMessageBody:(YWMessageBody *)aMessageBody
                    progress:(YWMessageSendingProgressBlock)aProgress
                  completion:(YWMessageSendingCompletionBlock)aCompletion;

/**
 *  @virtual 子类需要实现
 *  异步重发一条消息
 *  @param aMessage 需要重发的消息
 *  @param aProgress 消息发送进度的回调
 *  @param aCompletion 消息发送结束的回调
 */
- (void)asyncResendMessage:(id<IYWMessage>)aMessage
                  progress:(YWMessageSendingProgressBlock)aProgress
                completion:(YWMessageSendingCompletionBlock)aCompletion;

/**
 *  异步转发一条消息到本会话
 *  @param aMessage 需要转发的消息
 *  @param aProgress 消息发送进度的回调
 *  @param aCompletion 消息发送结束的回调
 */
- (void)asyncForwardMessage:(id<IYWMessage>)aMessage
                   progress:(YWMessageSendingProgressBlock)aProgress
                 completion:(YWMessageSendingCompletionBlock)aCompletion;



/**
 *  @virtual 子类需要实现
 *  获取某条消息
 */
- (id<IYWMessage>)fetchMessageWithMessageId:(NSString *)aMessageId;

/**
 *  @virtual 子类需要实现
 *  删除某一条消息
 */
- (void)removeMessageWithMessageId:(NSString *)aMessageId;

/**
 *  清空该会话已有的本地消息，被清空的消息不会再被漫游下来。
 *  @note 还没有被漫游下来的云端消息，仍然会被漫游下来
 *  @note 云端消息不会受影响，即如果在其他设备登录，这些消息仍会漫游
 */
- (void)removeAllLocalMessages;

#pragma mark - 消息管理
/// 会话消息加载完成的回调，通过参数返回是否还存在更多消息
typedef void(^YWConversationLoadMessagesCompletion)(BOOL existMore);

/**
 *  开始会话,进入聊天窗口首次加载消息，可以使用这个函数
 *  首次加载可以替代loadMoreMessages使用，需要加载更多的时候，再使用loadMoreMessages
 *  本地数据加载完成了，会收到didResetContentBlock回调
 *
 *  @param count 开始会话的时候，加载本地消息的数量,count取值范围:1~30
 */
- (void)startConversationWithMessageCount:(NSUInteger)count completion:(YWConversationLoadMessagesCompletion)completion;
/**
 *  结束会话，退出聊天窗口结束会话的时候，使用这个函数
 */
- (void)stopConversation;

/**
 *  加载消息
 *  加载消息同时增加内容变更的监听，当不再需要监听内容变更时需要调用 -[YWConversation clearContentChangeBlocks] 取消监听
 *  @param moreCount  额外加载的消息条目数，根据当先加载的消息数量加上 moreCount 为最终加载的条目数，该方法加载后会全量重新加载数据
 *  @param completion 完成回调 block，通过参数返回是否还存在更多消息
 */
- (void)loadMoreMessages:(NSUInteger)moreCount completion:(YWConversationLoadMessagesCompletion)completion;

/**
 *  加载未读消息，当会话有未读消息数的时候，有可能消息未完全加载到本地，此时，调用这个接口可以从服务端获取未读消息
 *  注意：漫游功能需要开启，否则会报错
 *
 *  @param count      未读消息数量，count需大于0，如果count=0,则无效果
 *  @param completion 完成回调block
 */
- (void)loadUnreadMessages:(NSUInteger)count completion:(void(^)(NSError *error))completion;

/**
 *  清除 willChangeContentBlock、didChangeContentBlock、objectDidChangeBlock，停止内容变更的监听
 */
- (void)clearContentChangeBlocks;

/**
 *  当前所加载的消息，最近一次调用 -[WXOConversation loadMoreMessages:completion:] 所加载的数据
 *  数组中包含的对象都遵循 IYWMessage 协议，您可以直接访问 IYWMessage 中的方法
 */
@property (readonly, nonatomic) NSArray *fetchedObjects;

/**
 *  当前所加载消息的总数，该方法比 fetchedObjects.count 的效率更高
 */
@property (nonatomic, readonly) NSUInteger countOfFetchedObjects;


/**
 *  fetchedObjects 与 indexPath 间的映射关系，
 */
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  fetchedObjects 与 indexPath 间的映射关系
 */
- (NSIndexPath *)indexPathForObject:(id)object;

/**
 *  fetchedObjects重新fetch的时候，回调该block(fetchedObjects里面的对象有可能重新构造了)
 */
@property (copy, nonatomic) YWContentChangeBlock didResetContentBlock;
- (void)setDidResetContentBlock:(YWContentChangeBlock)didResetContentBlock;

/**
 *  内容即将发生变更时的回调 block
 */
@property (copy, nonatomic) YWContentChangeBlock willChangeContentBlock;
- (void)setWillChangeContentBlock:(YWContentChangeBlock)willChangeContentBlock;

/**
 *  具体消息变更的回调 block
 */
@property (copy, nonatomic) YWContentChangeBlock didChangeContentBlock;
- (void)setDidChangeContentBlock:(YWContentChangeBlock)didChangeContentBlock;

/**
 *  内容已经完成变更的回调 block
 */
@property (copy, nonatomic) YWObjectChangeBlock objectDidChangeBlock;
- (void)setObjectDidChangeBlock:(YWObjectChangeBlock)objectDidChangeBlock;

/**
 *  @virtual
 *  标识某消息为已读
 */
- (void)markMessageAsReadWithMessageIds:(NSArray *)messageIds;

#pragma mark - 事件监听

@property (nonatomic, copy, readonly) YWConversationOnNewMessageBlock onNewMessageBlock;
/// 设置新消息回调
- (void)setOnNewMessageBlock:(YWConversationOnNewMessageBlock)onNewMessageBlock;

@property (nonatomic, copy, readonly) YWConversationOnNewMessageBlockV2 onNewMessageBlockV2;
/// 设置新消息回调
- (void)setOnNewMessageBlockV2:(YWConversationOnNewMessageBlockV2)onNewMessageBlockV2;

@end



@interface YWConversation ()

/**
 *  清空该会话已有的本地消息，被清空的消息可以再被漫游下来。
 */
- (void)removeAllLocalMessagesFromDB;

/**
 *  获取某个conversation的某一种消息体的所有本地消息记录
 *  @virtual  子类实现
 *
 *  @param className 消息体类型名，例如YWMessageBodyText
 *
 *  @return 指定消息体类型的消息对象(id<IYWMessage>)
 */
- (NSArray *)fetchMessagesThatMessageBodyIsKindOfClass:(NSString *)className;

@end


@interface YWConversation (MessageSearch)

/**
 *  根据关键字搜索会话消息
 *  @virtual
 */
- (NSArray *)searchMessagesWithKeyword:(NSString *)keyword;

@end