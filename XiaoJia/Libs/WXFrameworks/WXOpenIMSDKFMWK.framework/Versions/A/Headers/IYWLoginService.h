//
//  IYWLoginService.h
//
//
//  Created by huanglei on 14/12/11.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YWServiceDef.h"
#import "YWLoginServiceDef.h"
#import "YWPerson.h"

#pragma mark - 服务接口定义

/**
 * 登录相关服务提供
 */
@protocol IYWLoginService <NSObject>

/**
 *  当前IM是否已登录某个帐号
 */
@property (nonatomic, assign, readonly) BOOL isCurrentLogined;

/**
 *  当前用户的连接状态
 */
@property (nonatomic, assign, readonly) YWIMConnectionStatus connectionStatus;

/**
 *  当前登录Id
 */
@property (nonatomic, readonly) NSString *currentLoginedUserId;

/**
 *  当前登录用户的显示名称
 */
@property (nonatomic, copy, readwrite) NSString *currentLoginedUserDisplayName;

/**
 *  当前登录的用户
 */
- (YWPerson *)currentLoginedUser;

@property (nonatomic, copy, readonly) YWFetchLoginInfoBlock fetchLoginInfoBlock;
@property (nonatomic, copy, readonly) YWFetchLoginInfoBlockV2 fetchLoginInfoBlockV2;
/**
 *  设置登录能力
 */
- (void)setFetchLoginInfoBlock:(YWFetchLoginInfoBlock)fetchLoginInfoBlock;
- (void)setFetchLoginInfoBlockV2:(YWFetchLoginInfoBlockV2)fetchLoginInfoBlock;

/**
 *  获取最后一次连接时的Error信息，如果为nil，则表示还没有连接过或者连接为成功
 */
@property (nonatomic, copy, readonly) NSError *lastConnectionError;

/**
 *  设置固定的登录额外信息。例如与TAE SDK等集成使用时，可以传递额外信息。
 *  一般来说，ISV不需要特别关注这个字段。
 */
@property (nonatomic, copy) NSDictionary *defaultLoginClientData;

/// 设置IM长连接状态变更回调
/// @param aKey 用来区分不同的监听者，一般可以使用监听对象的description
/// @param aPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriority
- (void)addConnectionStatusChangedBlock:(YWIMConnectionStatusChangedBlock)connectionStatusChangedBlock forKey:(NSString *)aKey ofPriority:(YWBlockPriority)aPriority;
/// 移除IM长连接状态变更回调
- (void)removeConnectionStatusChangedBlockForKey:(NSString *)aKey;

/**
 *  预登陆，用于上次登陆成功并未退出的用户在登录成功之前显示历史数据
 *  @param person,预登陆的用户
 *  @ret   返回值，成功返回YES，否则返回NO。
 */
- (BOOL)preLoginWithPerson:(YWPerson *)person;

/**
 *  清理预登录信息
 */
- (void)resetPreLogin;

/**
 *  发起异步登录
 *  @param aCompletionBlock 登录结果回调，如果成功则aError返回nil
 *  @return 如果没能发起登陆请求，则直接返回NO
 */
- (BOOL)asyncLoginWithCompletionBlock:(YWCompletionBlock)aCompletionBlock;

/**
 * 异步登出
 * @param aCompletionBlock 登出结果回调，如果成功则aError返回nil
 */
- (void)asyncLogoutWithCompletionBlock:(YWCompletionBlock)aCompletionBlock;

/**
 * 断开与服务器的连接，但仍然可以收到push
 */
- (void)mannualDisconnect;

/**
 *  当前是否已有登录线程
 */
- (BOOL)hasLoginThread;


#pragma mark - 其他接口

/**
 *  是否可以使用WXToken登录。
 *  目前WXToken仅用于淘系二方App登录
 */
- (BOOL)isWXTokenAvailableForUserId:(NSString *)aUserId;

/**
 *  只有在需要强制关闭push时调用
 *  在asyncLogin之前调用，设置为YES，强制关闭push
 */
@property (nonatomic, assign) BOOL needClosePush;

/**
 *  只有在需要强制关闭自动绑定昵称时调用
 *  在asyncLogin之前调用，设置为YES，强制关闭xpush的自动昵称绑定
 */
@property (nonatomic, assign) BOOL needCloseAutoBindAlias;

@end


#pragma mark - 用于调试等

/// 即将上传DeviceToken
FOUNDATION_EXTERN NSString *const YWLoginServiceNotificationUploadDeviceTokenBegin;
/// YWLoginServiceNotificationUploadDeviceTokenBegin通知中使用这个key传递devicetoken，为@""的话表示清除
FOUNDATION_EXTERN NSString *const YWLoginServiceNotificationUploadDeviceTokenBeginKeyDT;
/// DeviceToken上传结束
FOUNDATION_EXTERN NSString *const YWLoginServiceNotificationUploadDeviceTokenEnd;
/// YWLoginServiceNotificationUploadDeviceTokenEnd通知的UserInfo中使用这个key传递NSError对象。为nil或者code为0表示成功
FOUNDATION_EXTERN NSString *const YWLoginServiceNotificationUploadDeviceTokenEndKeyError;



