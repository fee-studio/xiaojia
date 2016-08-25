//
//  YWAPI.h
//
//
//  Created by huanglei on 15/1/12.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YWServiceDef.h"

@protocol IYWPushService;
@protocol IYWExtensionService;
@protocol IYWActionService;
@protocol IYWHybridService;

@protocol IYWUtilService4Cache, IYWUtilService4Network, IYWUtilService4Security, IYWUtilService4UT, IYWUtilService4MandarinLatin;
@protocol IYWUtilService4Zip;
@protocol IYWLogService;

@class YWIMCore;

/**
 *  开发环境
 */
typedef enum {
    YWEnvironmentRelease = 1, // 开发者的线上环境
    YWEnvironmentPreRelease = 2, // 阿里巴巴内网预发环境
    YWEnvironmentDailyForTester = 3, // 阿里巴巴内网87环境，稳定
    YWEnvironmentDailyForDeveloper = 4, // 阿里巴巴内网88环境，开发中
    YWEnvironmentSandBox = 5, // 开发者的沙箱环境
}YWEnvironment;

/**
 *  WXOSdk错误域
 */
FOUNDATION_EXTERN NSString *const YWSdkDomain;

typedef NS_ENUM(NSUInteger, YWSdkInitErrorCode) {
    /// 已经被初始化
    YWSdkInitErrorCodeAlreadyInited = 100,
    /// 获取AppInfo失败
    YWSdkInitErrorCodeGetAppInfoFailed,
    /// AppKey为空
    YWSdkInitErrorCodeAppKeyNULL,
};

@interface YWAPI : NSObject

+ (instancetype)sharedInstance;

/**
 *  异步初始化
 *  @param aOwnAppKey 自身的appkey
 *  @param aCompletionBlock 初始化结果，错误的类型见 WXOSdkErrorCode 定义
 */
- (void)asyncInitWithOwnAppKey:(NSString *)aOwnAppKey
               completionBlock:(YWCompletionBlock)aCompletionBlock;


/**
 *  同步初始化，首次初始化会发起网络请求，获取你的应用信息，所以可能被阻塞，最长阻塞时间为5秒。初始化成功一次后，后面的初始化不会被阻塞。
 *  @param aOwnAppKey 自身的appkey
 */
- (BOOL)syncInitWithOwnAppKey:(NSString *)aOwnAppKey
                     getError:(NSError **)aGetError;

/**
 *  云旺AppKey。
 *  如果您收到的消息来自于客服YWPerson，那么该YWPerson对象的appKey为YWSDKAppKey
 */
FOUNDATION_EXTERN NSString *const YWSDKAppKey;

/**
 *  appkey
 */
@property (nonatomic, copy, readonly) NSString *appKey;


/// appkey被设置的通知，开发者调用syncInit时，IMSDK会抛出此通知
FOUNDATION_EXTERN NSString *const YWAPINotificationSetAppkey;

@end


#pragma mark - IMKit for OpenIM

@class YWIMKit;

@interface YWAPI ()

/**
 *  初始化IMKit实例，类型为OpenIM。
 *  您获取该实例后，需要retain住该实例，建议将其作为全局单例使用
 *
 *  注意：目前暂不支持获取多个IMKit实例同时使用
 *  注意：获取IMKit实例后，您无需再获取YWIMCore实例，您可以从IMKit实例中得到YWIMCore实例
 */
- (YWIMKit *)fetchIMKitForOpenIM;

- (YWIMKit *)fetchNewIMKit;

@end


#pragma mark - UserContext

@interface YWAPI ()

/**
 *  获取一个OpenIM的YWIMCore实例。
 *  建议在获取一个YWIMCore后，将其保存为全局单例使用。
 */
- (YWIMCore *)fetchNewIMCoreForOpenIM;

/// YWIMCore被新建的通知
typedef void (^YWSDKIMCoreCreatedBlock)(YWIMCore *aIMCore);

/**
 *  监听新的YWIMCore被生成
 *  @param aKey 用来区分不同的监听者，一般可以使用监听对象的description
 *  @param aPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriority
 */
- (void)addIMCoreCreatedBlock:(YWSDKIMCoreCreatedBlock)aBlock forKey:(NSString *)aKey priority:(YWBlockPriority)aPriority;

- (void)removeIMCoreCreatedBlockForKey:(NSString *)aKey;


@end


@interface YWAPI (GlobalServices)

/**
 *  获取PushService
 */
- (id<IYWPushService>)getGlobalPushService;

/**
 *  获取ExtensionService
 */
- (id<IYWExtensionService>)getGlobalExtensionService;

/**
 *  获取ActionService
 */
- (id<IYWActionService>)getGlobalActionService;

/**
 *  获取HybridService
 */
- (id<IYWHybridService>)getGlobalHybridService;

@end

@interface YWAPI (OpenUtilServices)

/**
 *  获取cacheService
 */
- (id<IYWUtilService4Cache>)getGlobalUtilService4Cache;

/**
 *  获取UtilService4Network
 */
- (id<IYWUtilService4Network>)getGlobalUtilService4Network;

/**
 *  获取UtilService4Security
 */
- (id<IYWUtilService4Security>)getGlobalUtilService4Security;

/**
 *  获取UtilService4UT
 */
- (id<IYWUtilService4UT>)getGlobalUtilService4UT;

/**
 *  获取UtilService4MandarinLatin
 */
- (id<IYWUtilService4MandarinLatin>)getGlobalUtilService4MandarinLatin;

/**
 *  获取UtilService4Zip
 */
- (id<IYWUtilService4Zip>)getGlobalUtilService4Zip;

/**
 *  获取日志服务
 */
- (id<IYWLogService>)getGlobalLogService;

@end

#pragma mark - 配置信息

@interface YWAPI ()

/**
 *  YW SDK版本信息
 */
@property (nonatomic, readonly) NSString *YWSDKIdentifier;

@property (nonatomic, readonly) NSString *YWSDKCompileDate;

/**
 *  网络环境，可以通过这个属性，在初始化WXOSdk之前设置网络环境的初始值
 *  热切换网络环境功能暂时不支持。（即如果已经初始化Sdk，则无法切换）
 */
@property (nonatomic, assign, readwrite) YWEnvironment environment;

/**
 *  切换网络环境，此功能暂不支持。
 *  如果需要不同的网络环境，需要在初始化Sdk之前，设置上面的environment属性。
 */
- (void)changeEnvironment:(YWEnvironment)aEnvironment;


/// 网络环境切换的回调（暂不支持）
typedef void(^YWSdkEnvironmentChangedBlock)(YWEnvironment aEnvironment);

/**
 *  添加网络环境切换的监听（暂不支持）
 *  @param aKey 用来区分不同的监听者，一般可以使用监听对象的description
 *  @param aPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriority
 */
- (void)addEnvironmentChangedBlock:(YWSdkEnvironmentChangedBlock)aBlock forKey:(NSString *)aKey ofPriority:(YWBlockPriority)aPriority;

/**
 *  移除网络环境切换的监听（暂不支持）
 */
- (void)removeEnvironmentChangedBlockForKey:(NSString *)aKey;

/**
 *  外部指定接入服务器
 */
@property (nonatomic, copy) NSString *externalAccessIP;

/**
 *  日志开关
 */
@property (nonatomic, assign) BOOL logEnabled;


/**
 *  Crash收集开关，三方开发者接入时默认为开启。如果三方开发者自己具备Crash收集机制，则需要在初始化Sdk前关闭此开关
 *  淘宝二方开发者接入时默认为关闭。
 */
- (void)closeCrashCollector;


@end

#pragma mark - IMKit for Wangwang

@interface YWAPI ()

/**
 *  初始化IMKit实例，类型为旺旺帐号
 *  您获取该实例后，需要retain住该实例，建议将其作为全局单例使用
 *
 *  注意：目前暂不支持获取多个IMKit实例同时使用
 *  注意：获取IMKit实例后，您无需再获取WXOBaseContext实例，您可以从IMKit实例中得到WXOBaseContext实例
 */
- (YWIMKit *)fetchIMKitForWangwang;
- (YWIMKit *)fetchIMKitForWangxin;

/**
 *  获取一个IMKit，不指定SDK类型
 */
- (YWIMKit *)fetchIMKit;


/**
 *  获取一个新的YWIMCore对象。
 *  建议在获取一个YWIMCore后，将其保存为全局单例使用。
 */
- (YWIMCore *)fetchNewIMCore;

/// 获取一个旺旺IMCore实例
- (YWIMCore *)fetchNewIMCoreForWangwang;

/**
 *  最近获取的IMCore和IMKit，用于某些老接口获取上下文
 */
@property (nonatomic, weak) YWIMKit *lastFetchedIMKit;
@property (nonatomic, weak) YWIMCore *lastFetchedIMCore;


@end

@interface YWAPI ()

/**
 *  如果你需要使用多个不同的IMCore，你需要在初始化YWAPI前，主动修改此属性为YES
 *  默认为NO，即你多次调用fetchIMKit或者IMCore，均获得相同对象
 *  除非必须使用多个IMCore来同时登录多个不同帐号，否则请谨慎开启
 *  注意，使用不同的IMCore登录相同相同帐号会导致未知的错误。多IMCore模式下，请注意维持账号与IMCore的对应关系。
 */
@property (nonatomic, assign) BOOL enableMultiCoreMode;

@end



/// 其他域的appkey定义
FOUNDATION_EXTERN NSString *const YWCHAppKey;
FOUNDATION_EXTERN NSString *const YWINTAppKey;

#pragma mark - 已废弃 deprecated

@interface YWAPI ()

/**
 *  异步初始化，此函数已经废弃。互通appkey不需要传入
 *  @param aOwnAppKey 自身的appkey
 *  @param aInteractedAppKeys 需要进行互通的AppKey字符串数组
 *  @param aCompletionBlock 初始化结果，错误的类型见 WXOSdkErrorCode 定义
 */
- (void)asyncInitWithOwnAppKey:(NSString *)aOwnAppKey
             interactedAppKeys:(NSArray *)aInteractedAppKeys
               completionBlock:(YWCompletionBlock)aCompletionBlock __attribute__((deprecated("如果您基于OpenIM的UI接口进行开发，您不需要再获取YWIMCore实例，您可以直接从YWAPI中使用fetchIMKitForOpenIM方法获取YWIMKit并持有该实例，详见注释")));


@end


