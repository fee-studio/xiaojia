//
//  YWLoginServiceDef.h
//
//
//  Created by huanglei on 14/12/16.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

/// LoginService的错误域
FOUNDATION_EXTERN NSString * __nonnull const YWLoginServiceDomain;

/**
 * 登录错误定义
 */
typedef NS_ENUM(NSUInteger, YWLoginErrorCode) {
    /// 没有这个用户
    YWLoginErrorCodeUserNotExsit = 1,
    /// 密码错误
    YWLoginErrorCodePasswordError = 2,
    /// 账号受限
    YWLoginErrorCodeAccountLimited = 3,
    /// 版本受限
    YWLoginErrorCodeVersionLimited = 10,
    /// 版本过老
    YWLoginErrorCodeVersionTooOld = 34,
    /// 淘系免登token失效
    YWLoginErrorCodePasswordInvalid = 41,
    
    /// 超时
    YWLoginErrorCodeTimeout = 100,
    /// 没有设置登陆信息
    YWLoginErrorCodeLoginInfoInvalid,
    /// 已有账号保持登录
    YWLoginErrorCodeAlreadyLogined,
    /// 版本需要强制更新
    YWLoginErrorCodeNeedUpdate,
    /// 应用信息获取失败
    YWLoginErrorCodeAppInfoFailed,
    /// 登陆信息与预登录信息不一致
    YWLoginErrorCodeLoginInfoNotMatch,
    /// 其他错误
    YWLoginErrorCodeOther,
};

/**
 *  IM长连接状态
 */
typedef NS_ENUM(NSUInteger, YWIMConnectionStatus) {
    /// 被踢
    YWIMConnectionStatusForceLogout = 1000,
    /// 手动登出
    YWIMConnectionStatusMannualLogout,
    
    
    /// IM长连接断开
    YWIMConnectionStatusDisconnected,
    /// IM长连接连接中
    YWIMConnectionStatusConnecting,
    /// IM长连接连接成功
    YWIMConnectionStatusConnected,
    /// IM长连接重连成功（不同于上面的长连接成功。这是底层在网络抖动等情况下，重连成功发出的状态。一般仅用于更新状态显示）
    YWIMConnectionStatusReconnected,
    /// IM长连接主动断开（不同于上面的长连接断开，这个是如果开发者主动调用disconnect，才会发出的状态）
    YWIMConnectionStatusMannualDisconnected,
    /// IM长连接自动连接失败
    YWIMConnectionStatusAutoConnectFailed,
    
    /// IM开发者调用asyncLogin主动登录成功（同时也会发出YWIMConnectionStatusConnected状态，但YWIMConnectionStatusConnected还包含前后台切换等自动连接的情况）
    YWIMConnectionStatusMannualLogined,
};

/**
 *  长连接状态变更的回调block定义
 *  @param aStatus 连接状态
 *  @param aError 如果是自动连接失败，则会携带error信息，errorCode由WXOLoginErrorCode定义
 */
typedef void(^YWIMConnectionStatusChangedBlock)(YWIMConnectionStatus aStatus, NSError * __nullable aError);

/**
 *  登录方式
 */
typedef enum : NSUInteger {
    /// 密码登录
    YWLoginTypeRawPassword,
    /// TrustLogin方式
    YWLoginTypeTrustLogin,
    /// 百川OpenID登录
    YWLoginTypeOpenID,
    /// 阿里巴巴统一登录
    YWLoginTypeHavana,
    
    /// OpenIM WXToken登录，目前只对二方开发者开放的登录方式
    YWLoginTypeWXToken = 10001,
    YWLoginTypeSSOToken = 10002,
    
    /// OpenIM反馈系统匿名登陆
    YWLoginTypeAnonAccount = 10010,
} YWLoginType;

/**
 *  成功获取到登录信息后，通过这个回调，通知IM
 *  @param aUserId 登录id
 *  @param aPassword 登录密码
 *  @param aDisplayName 帐号显示名称，用于发消息时在对方APNS通知中显示昵称。如果你已经将用户昵称导入到IM服务器，则直接传入nil。
 *  @param aExtraInfo 登录所需的额外信息
 */
typedef void(^YWFetchLoginInfoCompletionBlock)(BOOL aIsSuccess, NSString * __nonnull aUserId, NSString * __nullable aPassword, NSString * __nullable aDisplayName, NSDictionary * __nullable aExtraInfo);

typedef void(^YWFetchLoginInfoCompletionBlockV2)(BOOL aIsSuccess, NSString * __nonnull aUserId, NSString *__nullable aPassword, YWLoginType aLoginType,  NSString *__nullable aDisplayName, NSDictionary * __nullable aExtraInfo);

/**
 *  当IM需要登录信息时，会调用这个block，开发者需要在这个block中异步获取IM所需的用户名密码等登录信息，IM不会保存密码信息
 *  @param aCompletionBlock 当开发者获取登录信息完成后，调用这个block通知IM
 */
typedef void(^YWFetchLoginInfoBlock)(YWFetchLoginInfoCompletionBlock __nonnull aCompletionBlock);
typedef void(^YWFetchLoginInfoBlockV2)(YWFetchLoginInfoCompletionBlockV2 __nonnull aCompletionBlock);



#pragma mark - 额外定义

/**
 *  二方应用用来传递SSOToken MakeClientData的key
 */
FOUNDATION_EXTERN NSString * __nullable const kYWLoginExtraInfoKeyForSSOTokenBlock;

@interface YWLoginServiceDef : NSObject

@end
