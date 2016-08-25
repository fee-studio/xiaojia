//
//  ALBBSDK.h
//  ALBBSDK
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 14-8-2.
//  Copyright (c) 2014年 com.taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaeWebViewUISettings.h"

#pragma mark version
/** 当前ALBB基础SDK版本 */
#define ALBBSDKVersion @"2.1"


#pragma mark - type define
/** SDK回调Code定义 */
typedef NS_ENUM (NSUInteger, ALBBSDKCode) {
    /** SDK初始化失败 */
    TAE_INIT_FAILED = 1000,
    /** 初始化下载服务端证书失败 */
    TAE_INIT_SERVER_CER_LOAD_FAILED = 1002,
    /** 服务端证书验证失败 */
    TAE_INIT_SERVER_CER_EVAL_FAIELD = 1003,
    /** 本地证书验证失败 */
    TAE_INIT_LOCAL_CER_EVAL_FAIELD = 1004,
    /** 刷新当前会话失败 */
    TAE_INIT_REFRESH_SESSION_FAIELD = 1005,
    
    /** 登录失败 */
    TAE_LOGIN_FAILED = 2001,
    /** 用户取消了登录 */
    TAE_LOGIN_CANCELLED = 2002,
    
    /** 交易链路失败 */
    TAE_TRADE_PROCESS_FAILED = 3001,
    /** 交易链路中用户取消了操作 */
    TAE_TRADE_PROCESS_CANCELLED = 3002,
    /** 交易链路中发生支付但是支付失败 */
    TAE_TRADE_PROCESS_PAY_FAILED = 3003,
    /** itemId无效 */
    TAE_TRADE_PROCESS_ITEMID_INVALID = 3004
};

typedef NS_ENUM(NSUInteger, TaeSDKEnvironment) {
    /** 测试环境 */
    TaeSDKEnvironmentDaily,
    /** 预发环境 */
    TaeSDKEnvironmentPreRelease,
    /** 线上环境 */
    TaeSDKEnvironmentRelease,
    /** 沙箱环境 */
    TaeSDKEnvironmentSandBox
};

/** 初始化成功回调 */
typedef void (^ALBBSDKSuccess)();
/** 初始化失败回调 */
typedef void (^ALBBSDKFailure)(NSError *error);

/** 初始化成功回调 */
typedef void (^initSuccessCallback)();
/** 初始化失败回调 */
typedef void (^initFailedCallback)(NSError *error);

#pragma mark - SDK
/** SDK */
@interface ALBBSDK : NSObject

/** 返回单例 */
+ (instancetype)sharedInstance;

/** ALBBSDK初始化，异步执行 */
- (void)asyncInit;
/**
 ALBBSDK初始化，异步执行
 @param sucessCallback 初始化成功回调
 @param failedCallback 初始化失败回调
 */
- (void)asyncInit:(ALBBSDKSuccess)success failure:(ALBBSDKFailure)failure;

/**
 获取ALBBSDK以及所有插件SDK暴露的service 实例
 @param protocol service的协议
 @return service实例
 */
- (id)getService:(Protocol *)protocol;

/**
 用于处理其他App的回跳
 @param url
 @return 是否经过了ALBBSDK的处理
 */
- (BOOL)handleOpenURL:(NSURL *)url;
@end

#ifndef ALBBService
#define ALBBService(__protocol__) \
((id<__protocol__>)([[ALBBSDK sharedInstance] getService:@protocol(__protocol__)]))
#endif


#pragma mark - option
@interface ALBBSDK (Options)
/**
 打开SDK Debug日志
 @param isDebugLogOpen
 */
- (void)setDebugLogOpen:(BOOL)isDebugLogOpen;
/**
 主动关闭百川设置的crashHandler,建议在应用启动的第一行代码调用
 */
- (void)closeCrashHandler;
@end


#pragma mark - settings
@interface ALBBSDK (Settings)
/**
 指定当前APP的版本，以便关联相关日志和crash分析信息, 如果不设置默认会取plist里的Bundle version
 @param version <#version description#>
 */
- (void)setAppVersion:(NSString *)version;
/**
 设置SDK发布渠道,包含渠道类型和渠道名
 */
- (void)setChannel:(NSString *)type name:(NSString *)name;

/**
 指定身份图片的后缀,例如yw_1222_test.jpg
 @param postFix <#postFix description#>
 */
- (void)setSecGuardImagePostfix:(NSString *)postFix;

- (void)setWebViewUISettings:(TaeWebViewUISettings *)webViewUISettings;

- (TaeWebViewUISettings *)getWebViewUISettings;
@end

#pragma mark - trade
@interface ALBBSDK (Trade)

/**
 *  针对外部APP存在appkey多用的情况，特殊标示，由APP自行传入，允许为空
 *
 *  @param tag <#tag description#>
 */
- (void)setAppTag:(NSString *)tag;

/**
 app标识，和isvcode同义，用来追踪订单
 @param tag <#tag description#>
 */
- (void)setISVCode:(NSString *)tag;
/**
  设置打开detail页面是否优先跳转到手机淘宝
  @param isUseTaobaoNativeDetail
 */
- (void)setUseTaobaoNativeDetail:(BOOL)isUseTaobaoNativeDetail;


#define ALBB_ITEM_VIEWTYPE_BAICHUAN @"baichuanH5"
#define ALBB_ITEM_VIEWTYPE_TAOBAO  @"taobaoH5"
/**
  设置默认使用淘宝H5还是百川H5页面
  @param viewType  值为taobaoH5或baichuanH5
 */
- (void)setViewType:(NSString *) viewType;
@end


#pragma mark - TaeSDK
/** 当前环境 */
TaeSDKEnvironment TaeSDKCurrentEnvironment();

@interface ALBBSDK (TaeSDK)
/**
 TaeSDK初始化，异步执行
 @param sucessCallback 初始化成功回调
 @param failedCallback 初始化失败回调
 */
- (void)asyncInit:(initSuccessCallback)sucessCallback failedCallback:(initFailedCallback)failedCallback;

/**
 设置SDK 环境信息，Tae内部测试使用
 @param environmentType 见TaeSDKEnvironment
 */
- (void)setTaeSDKEnvironment:(TaeSDKEnvironment)environmentType;

- (TaeSDKEnvironment)getTaeSDKCurrentEnvironment;
@end


#pragma mark - deprecated
@interface ALBBSDK (Deprecated)
/** 已不再提供高德Key. 请通过高德获取Key. */
- (NSString *)getGaoDeAPIKey __attribute__((availability(ios, unavailable, message="obsolete in 2.1")));
/** 已不再提供友盟Key. 请通过友盟获取Key. */
- (NSString *)getUMengAPIKey __attribute__((availability(ios, unavailable, message="obsolete in 2.1")));
/** 不再在ALBBSDK中设置 */
- (void)setCloudPushSDKOpen:(BOOL)_ __attribute__((availability(ios, unavailable, message="obsolete in 2.1")));;
/** UserAgent自动关闭 */
- (void)closeTaeUserAgent __attribute__((availability(ios, unavailable, message="obsolete in 2.1")));;
@end
