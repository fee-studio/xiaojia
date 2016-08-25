//
//  IYWConversationService.h
//  
//
//  Created by huanglei on 14/12/11.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "YWServiceDef.h"
#import "YWConversationServiceDef.h"

#import "YWConversation.h"
#import "YWP2PConversation.h"

#import "IYWMessage.h"
#import "YWMessageBody.h"
#import "YWMessageBodyText.h"
#import "YWMessageBodyImage.h"
#import "YWMessageBodyVoice.h"
#import "YWMessageBodyLocation.h"
#import "YWMessageBodyCustomize.h"
#import "YWMessageBodyTemplate.h"
#import "YWMessageBodySystemNotify.h"
#import "YWMessageBodyTribeSystem.h"
#import "YWMessageBodyUnsupported.h"
#import "YWMessageBodyShortVideo.h"
#import "YWPerson.h"


#pragma mark - 常量定义

/**
 *  会话服务错误定义
 */
typedef NS_ENUM(NSUInteger, YWConversationErrorCode) {
    /// 操作失败
    YWConversationErrorCodeOperationFailed = 1,
    /// 参数不正确
    YWConversationErrorCodeParamInvalid,
    
    /// 数据库操作错误
    YWConversationErrorCodeDBError,
    
    /// 向黑名单中的用户发送消息
    YWConversationErrorSendToBlackListMember,

    /// 消息包含敏感字符
    YWConversationErrorForbiddenContent,
    
    /// 不支持漫游或者漫游功能未开启
    YWConversationErrorRoamingError,
};

/**
 *  消息总未读数的计算方式
 */
typedef NS_ENUM(NSUInteger, YWConversationUnreadMessagesCountingMode) {
    /**
     *  对所有会话的未读数进行求和
     */
    YWConversationUnreadMessagesCountingModeAll = 0,
    /**
     *  仅对接收并提醒会话的未读数进行求和
     */
    YWConversationUnreadMessagesCountingModePartial,
};

/// 错误域
FOUNDATION_EXTERN NSString *const YWConversationServiceDomain;



#pragma mark - 服务接口提供

/**
 * 会话管理服务提供
 */

@protocol IYWConversationService <NSObject>

#pragma mark - 会话管理

/**
 *  获取某个本地会话
 *  @param aConversationId 会话Id
 *  @return 需要获取的会话，不存在则返回nil
 */
- (YWConversation *)fetchConversationByConversationId:(NSString *)aConversationId;

/**
 * 删除单个会话
 * @param aConversationId 需要删除的会话Id
 * @param aError 错误信息
 */
- (BOOL)removeConversationByConversationId:(NSString *)aConversationId error:(NSError **)aError;

/*
 * 异步删除所有会话及消息
 * @param completion 结果回调
 */
- (void)asyncRemoveAllConversationAndMessage:(void(^)(NSError *error))completion;
/*
 * 除指定排除的会话外，异步删除其他所有会话及消息
 * @param exceptConversationIds 指定排除在外的会话id的数组（NSString in array）,如果传入nil，效果等同于asyncRemoveAllConversationAndMessage：
 * @param completion 结果回调
 */
- (void)asyncRemoveAllConversationAndMessageExcept:(NSArray *)exceptConversationIds completion:(void(^)(NSError *error))completion;

/**
 *  异步获取所有本地会话的回调
 *  @param aConversationsArray 包含所有会话对象的NSArray
 */
typedef void(^YWFetchConversationsCompletion)(NSArray *aConversationsArray);

/**
 * 异步加载所有会话
 * @param aCompletionBlock 结果回调
 */
- (void)asyncFetchAllConversationsWithCompletionBlock:(YWFetchConversationsCompletion)aCompletionBlock;

/**
 * 同步加载所有会话
 * @param aCompletionBlock 结果回调
 */
- (NSArray *)fetchAllConversation;

/**
 * 同步加载所有单聊会话
 * @param aCompletionBlock 结果回调
 */
- (NSArray *)fetchAllP2PConversation;

/**
 * 异步标记所以会话为已读状态
 */
- (void)asyncMarkAllConversationAsRead:(void(^)(void))completion;
/**
 * 除了指定排除的会话，异步标记其他所有会话为已读状态
 *
 * @param exceptConversationIds 需要排除的会话id的数据（YWConversation in array）,如果传入nil,等同于asyncMarkAllConversationAsRead：
 * @param completion 结果回调
 */
- (void)asyncMarkAllConversationAsReadExcept:(NSArray *)exceptConversationIds completion:(void(^)(void))completion;

/// 是否禁止输入状态功能
/// 默认为NO，即不禁用
@property (nonatomic, readonly) BOOL disableInputStatus;
- (void)setDisableInputStatus:(BOOL)disableInputStatus;

/**
 *  发送输入状态，该状态只起到通知的作用，不做存储
 *  @param inputStatu 输入状态
 *  注意，当 disableContactInputStatus 为 YES 时无效
 */
- (void)sendUserInputStatus:(YWConversationInputStatus)inputStatus forConversation:(YWConversation *)conversation;

/**
 *  所有会话的未读消息数
 */
@property (nonatomic, readonly) NSUInteger countOfUnreadMessages;

/**
 *  消息总未读数的计算方式，默认值 YWConversationUnreadMessagesCountingModeAll
 */
@property (nonatomic, assign) YWConversationUnreadMessagesCountingMode unreadMessagesCountingMode;

#pragma mark - 事件监听


/**
 *  会话变更的回调
 *  @param aConversationsArray 会话数组
 */
typedef void(^YWConversationChangedBlock)(NSArray *aConversationsArray);

/// 设置会话变更的回调
/// @param aKey 用来区分不同的监听者，一般可以使用监听对象的description
/// @param aPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriority
- (void)addConversationChangedBlock:(YWConversationChangedBlock)conversationChangedBlock forKey:(NSString *)aKey ofPriority:(YWBlockPriority)aPriority;
/// 移除会话变更的回调
- (void)removeConversationChangedBlockForKey:(NSString *)aKey;

/**
 *  总的未读数变更的回调
 *  @param aCount 总的未读数
 */
typedef void(^YWConversationTotalUnreadChangedBlock)(NSUInteger aCount);

/// 设置总的未读数变更的回调
/// @param aKey 用来区分不同的监听者，一般可以使用监听对象的description
/// @param aPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriority
- (void)addConversationTotalUnreadChangedBlock:(YWConversationTotalUnreadChangedBlock)conversationTotalUnreadChangedBlock forKey:(NSString *)aKey ofPriority:(YWBlockPriority)aPriority;
/// 移除未读数变更的回调
- (void)removeConversationTotalUnreadChangedBlockForKey:(NSString *)aKey;


// 设置收到新消息的回调，V1版本，没有是否离线消息的标记
/// @param aKey 用来区分不同的监听者，一般可以使用监听对象的description
/// @param aPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriority
- (void)addOnNewMessageBlock:(YWConversationOnNewMessageBlock)onNewMessageBlock forKey:(NSString *)aKey ofPriority:(YWBlockPriority)aPriority;
/// 移除收到新消息的回调
- (void)removeOnNewMessageBlockForKey:(NSString *)aKey;

// 设置收到新消息的回调，V2版本，带有是否离线消息的标记
/// @param aKey 用来区分不同的监听者，一般可以使用监听对象的description
/// @param aPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriority
- (void)addOnNewMessageBlockV2:(YWConversationOnNewMessageBlockV2)onNewMessageBlockV2 forKey:(NSString *)aKey ofPriority:(YWBlockPriority)aPriority;
/// 移除收到新消息的回调
- (void)removeOnNewMessageBlockV2ForKey:(NSString *)aKey;

/// 设置收到输入状态变化的回调
- (void)addConversationInputStatusChangeBlock:(YWConversationInputStatusChangeBlock)inputStatusChangeBlock forPerson:(YWPerson *)person ofPriority:(YWBlockPriority)aPriority;
/// 移除输入状态变化的回调
- (void)removeConversationInputStatusChangeBlockForPerson:(YWPerson *)aPerson;

#pragma mark - 会话列表数据完全同步

/**
 *  内容即将发生变更时的回调 block
 */
@property (copy, nonatomic, readonly) YWContentChangeBlock willChangeContentBlock;

- (void)setWillChangeContentBlock:(YWContentChangeBlock)willChangeContentBlock;

/**
 *  具体消息变更的回调 block
 */
@property (copy, nonatomic, readonly) YWContentChangeBlock didChangeContentBlock;

- (void)setDidChangeContentBlock:(YWContentChangeBlock)didChangeContentBlock;

/**
 *  内容已经完成变更的回调 block
 */
@property (copy, nonatomic, readonly) YWObjectChangeBlock objectDidChangeBlock;

- (void)setObjectDidChangeBlock:(YWObjectChangeBlock)objectDidChangeBlock;


/**
 *  内容重置的回调 block
 */
@property (copy, nonatomic, readonly) YWResetContentBlock resetContentBlock;

- (void)setResetContentBlock:(YWResetContentBlock)resetContentBlock;

/**
 *  所加载的数据，内部包含YWConversation对象
 */
@property (readonly, nonatomic) NSArray *fetchedObjects;

/*
 * 所加载数据的数量
 * 建议使用这个属性，这个属性的效率高，而不是使用[fetchedObjects count](效率低)
 */
@property (readonly, nonatomic) NSUInteger countOfFetchedObjects;

/**
 *  fetchedObjects 与 indexPath 间的映射关系，
 */
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  fetchedObjects 与 indexPath 间的映射关系
 */
- (NSIndexPath *)indexPathForObject:(id)object;


#pragma mark - 单条消息已读未读功能
/**
 *  是否启用p
 *  默认为NO，即不启用
 */
@property (nonatomic, assign) BOOL enableMessageReadFlag;
- (void)setEnableMessageReadFlag:(BOOL)enableMessageReadFlag;


#pragma mark - 消息生命周期

/**
 *  可以通过实现 YWMessageLifeControlDelegate 协议，来得到消息生命周期的回调
 *  例如，可以在消息发送前，改变消息内容或者取消发送
 *  或者，可以在消息发送完，播放特定提示音等等
 
 *  详细请参考：YWMessageLifeControlDelegate 的定义
 */

- (void)addMessageLifeDelegate:(id<YWMessageLifeDelegate>)aDelegate forPriority:(YWBlockPriority)aPriority;

- (void)removeMessageLifeDelegate:(id<YWMessageLifeDelegate>)aDelegate;

/// 注意不要强引用住返回的数组及其中的对象，按照优先级排序
- (NSArray *)messageLifeDelegatesArray;


#pragma mark - deprecated

/**
 *  获取最近联系的客服
 */
- (YWPerson *)getLastEHelper:(YWPerson *)eHelper __attribute__((deprecated("请使用IYWEHelperService.h中的接口")));

@end



