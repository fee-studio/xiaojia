//
//  YWTribeConversation.h
//  
//
//  Created by Jai Chen on 15/1/21.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import "YWConversation.h"
#import "YWTribe.h"

/**
 *  群聊会话
 */
@interface YWTribeConversation : YWConversation

/**
*  获取某群聊会话
*
*  @param tribe            群对象
*  @param createIfNotExist 如果会话还不存在，是否创建新会话
*  @param baseContext      baseContext 对象
*
*  @return 群会话
*/
+ (instancetype)fetchConversationByTribe:(YWTribe *)tribe createIfNotExist:(BOOL)createIfNotExist baseContext:(YWIMCore *)baseContext;

/**
 *  该会话的群对象，由于群名称、群公告等信息需要从服务器中获取，当本地并未存储该群信息的情况下，将返回一个新建的 tribeName 为 tribeId 的 WXOTribe
 */
@property (readonly, nonatomic) YWTribe *tribe;




/**
 *  标识当前是否有新的@消息未读
 */
@property (readonly, nonatomic) BOOL newAtMessage;

/**
 *  获取的@消息的消息对象,目前@消息只支持文本消息体
 *  优先加载本地，如果需要刷新数据，请使用refreshFetcheAtMessageObjectWithCompletion:来刷新数据
 *  默认按时间排序，最近的消息排在最前面，包含了别人@我的消息和我@别人的消息
 */
@property (readonly, nonatomic, strong) NSArray *fetchedAtMessageObject;

/**
 * fetchedAtMessageObject里面对象发生变化后，产生回调
 * 注意，如果是refresh或者loadmore的则不产生回调
 */
@property (nonatomic, copy) YWContentChangeBlock fetchedAtMessageObjectDidChangeBlock;

/**
 * 检查fetchedAtMessageObject里面是否存在未读的@自己的消息
 */
- (BOOL)hasAnyUnreadAtMeMessageInFetchedAtMessageObject;

typedef void(^YWTribeAtMessageRefreshCompletionBlock)(void);
/**
 *  刷新fetchedAtMessageObject数据
 *
 *  @param completion 刷新完成后回调block
 */
- (void)refreshFetcheAtMessageObjectWithCompletion:(YWTribeAtMessageRefreshCompletionBlock)completion;

typedef void(^YWTribeFetchMoreAtMessageCompetionBlcok)(void);
/**
 *  加载更多的@消息对象
 *
 *  @param moreCount  新增数量，实际有可能返回的数量比这个值小
 *  @param completion 加载完成后回调的block
 */
- (void)loadMoreTribeAtMessages:(NSUInteger)moreCount completion:(YWTribeFetchMoreAtMessageCompetionBlcok)completion;


typedef void(^YWTribeAtMemberListBlock)(NSArray *readMembers, NSArray *unreadMembers);
/**
 *  获取某条at消息的具体的@成员列表
 *  目前只支持获取@别人的消息的@成员列表
 *
 *  @param message    @别人的消息
 *  @param completion fetch完成后的回调block
 */
- (void)fetchReadAndUnreadMemberListOfMessage:(id<IYWMessage>)message completion:(YWTribeAtMemberListBlock)completion;

/**
 * 是否为加载某条消息的上下文消息的模式，是返回YES,否则返回NO
 * 通过beginLoadContextMessagesOfMessage:completion:可以开启该模式
 */
@property (readonly, nonatomic, assign) BOOL isLoadContextMessagesMode;

/**
 *  开启某条消息上下文消息加载的模式，会影响到fetchedObjects里面的对象
 *  注意：如果当前的fetchedObjects已经存在message，则不会开启上下文模式
 *
 *  @param message    消息
 *  @param completion 完成后的回调block
 */
- (void)beginLoadContextMessagesOfMessage:(id<IYWMessage>)message completion:(YWConversationLoadMessagesCompletion)completion;

/**
 *  上下文消息加载模式下，加载更多的上下文消息，支持向前或向后加载更多
 *
 *  @param moreCount  加载更多的消息条数
 *  @param isBackward 是否向后加载，isBackward==YES，表示向后加载更多，isBackward==NO,表示向前加载更多
 *  @param completion 完成后的回调block
 */
- (void)loadMoreContextMessages:(NSUInteger)moreCount isBackward:(BOOL)isBackward completion:(YWConversationLoadMessagesCompletion)completion;

/**
 *  关闭上下文消息加载模式，恢复正常的消息加载模式
 */
- (void)endLoadContextMessages;

@end
