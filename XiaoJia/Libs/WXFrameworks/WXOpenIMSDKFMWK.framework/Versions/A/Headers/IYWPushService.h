//
//  IYWPushService.h
//  
//
//  Created by huanglei on 14/12/16.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IYWMessage;
@class YWPerson;

/// Push服务错误域
FOUNDATION_EXTERN NSString *const YWPushServiceDomain;

/**
 Push服务
 */

@protocol IYWPushService <NSObject>

/**
 *  获取转换后的deviceToken字符串
 */
@property (nonatomic, readonly) NSString *deviceTokenString;


#pragma mark - V4

/// 是否是用户划开push启动app（app原先处于未启动状态）。值为BOOL类型的NSNumber
FOUNDATION_EXTERN NSString *YWPushHandleResultKeyIsLaunching;
/// app当前状态，您可以判断是否是由于用户划开push，导致app从后台进入前台。值为UIApplicationState类型的NSNumber
FOUNDATION_EXTERN NSString *YWPushHandleResultKeyApplicationState;
/// 收到的APS消息体。值为NSDictionary
FOUNDATION_EXTERN NSString *YWPushHandleResultKeyAPS;
/// Push的原始UserInfo，值为NSDictionary
FOUNDATION_EXTERN NSString *YWPushHandleResultKeyOriginalUserInfo;

/**
 *  APNS 推送处理的回调Block定义
 *  设置这个回调，当用户点击Push时，IMSDK会截获该事件并解析，如果识别出是属于IM的推送消息，则会通过该回调通知你
 *  @param aResult 回调携带的信息，包含的key在监听的函数注释中说明
 *  @param aShouldStop 一般不需要关心和修改。不需要继续回调其他的监听者时改为NO，用于已检查出Push属于特定业务时使用，避免让干扰其他监听者。
 */
typedef void(^YWPushHandleResultBlockV4)(NSDictionary *aResult, BOOL *aShouldStop);

/**
 *  APNS 推送处理的回调Block定义
 *  设置这个回调，当用户点击Push时，IMSDK会截获该事件并解析，如果识别出是属于IM的推送消息，则会通过该回调通知你
 *  @param aResult 回调携带的信息，包含的字段有：YWPushHandleResultKeyIsLaunching、YWPushHandleResultKeyApplicationState、YWPushHandleResultKeyAPS、YWPushHandleResultKeyOriginalUserInfo、YWPushHandleResultKeyConversationId、YWPushHandleResultKeyConversationClass、YWPushHandleResultKeyToPerson
 */
- (void)addHandlePushBlockV4:(YWPushHandleResultBlockV4)handlePushBlockV4 forKey:(NSString *)aKey ofPriority:(YWBlockPriority)aPriority;

/// 会话Id，值为NSString
FOUNDATION_EXTERN NSString *YWPushHandleResultKeyConversationId;
/// 会话Class，值为Class
FOUNDATION_EXTERN NSString *YWPushHandleResultKeyConversationClass;
/// 消息发送给哪一个账号，供调试使用，你一般不需要关心这个参数；值为NSString
FOUNDATION_EXTERN NSString *YWPushHandleResultKeyToPerson;


/**
 *  移除推送处理的回调监听
 */
- (void)removeHandlePushBlockV4ForKey:(NSString *)aKey;





#pragma mark - xpush

/// OpenIM提供的统一推送服务

/// 设置证书名称，不设置则默认为production；如果需要设置，则需要在didFinishLaunching中
- (void)setXPushCertName:(NSString *)aCertName;

/// 默认沙箱证书名称
FOUNDATION_EXTERN NSString *const YWXPushDefaultCertNameSandbox;


///////////////ClientId相关//////////////////
/**
 *  同步获取本地保存的ClientId，如果本地不存在，则返回nil
 *  一般在登录你的账号成功后，读取本地clientId，如果有，则提交到你的服务器上做绑定；同时，监听clientId的变更回调，如果clientId发生变更，则提交到你的服务器上做绑定
 */
- (NSString *)localClientId;

/**
 *  获取到ClientId后抛出的通知
 */
FOUNDATION_EXTERN NSString *const YWXPushClientIdChangedNotification;
/**
 *  通知的userInfo使用这个key，携带clientId
 */
FOUNDATION_EXTERN NSString *const YWXPushClientIdChangedNotificationKeyClientId;

///////////////XPush校验相关///////////////////
/// 如果需要设置，则需要在didFinishLaunching中
- (void)setXPushClientSecret:(NSString *)aClientSecret;


///////////////XPush回调相关///////////////////
/**
 *  监听xpush回调
 *  这个函数特地使用xpush开头命名，以防跟上面的push回调函数混用
 *  @param aBlock YWPushHandleResultBlockV4类型，aResult中包含：YWPushHandleResultKeyIsLaunching、YWPushHandleResultKeyApplicationState、YWPushHandleResultKeyAPS、YWPushHandleResultKeyOriginalUserInfo、YWPushHandleResultKeyXPushClientData; 
 *  @brief 如果是透传消息，则不会包含YWPushHandleResultKeyAPS、YWPushHandleResultKeyOriginalUserInfo字段
 */
- (void)xpushAddHandlePushBlock:(YWPushHandleResultBlockV4)aBlock forKey:(NSString *)aKey ofPriority:(YWBlockPriority)aPriority;

/**
 *  XPUSH消息中的clientData，NSString类型
 */
FOUNDATION_EXTERN NSString *const YWPushHandleResultKeyXPushClientData;

/**
 *  移除监听
 */
- (void)xpushRemoveHandlePushBlockForKey:(NSString *)aKey;



#pragma mark - deprecated

/**
 *  现在当你的app获取到DeviceToken时，IMSDK会截获到该DeviceToken，自动使用该DeviceToken，您不需要调用此接口设置。
 */
@property (nonatomic, copy, readwrite) NSData *deviceToken;


#pragma mark - V3

/**
 *  Push处理回调
 *  @param aIsLaunching 是否是用户划开push启动app（app原先处于未启动状态）
 *  @param aState app当前状态，您可以判断是否是由于用户划开push，导致app从后台进入前台
 *  @param aAPS APS消息本身
 *  @param aConversationId 会话Id
 *  @param aConversationClass 会话类型，返回值可能是：[YWP2PConversation class]、[YWTribeConversation class]
 *  @param aToPerson 供调试使用，你一般不需要关心这个参数；消息是发送给哪个帐号
 */
typedef BOOL (^YWPushHandleResultBlockV3)(BOOL aIsLaunching, UIApplicationState aState, NSDictionary *aAPS, NSString *aConversationId, Class aConversationClass, YWPerson *aToPerson);

@property (nonatomic, copy, readonly) YWPushHandleResultBlockV3 handlePushBlockV3;

/**
 *  现在IMSDK可以自己监听到Push事件，您只需要在-[AppDelegate application:didFinishLaunchingWithOptions:]中设置下面这个回调，做对应的处理。
 *  @note 您不需要再调用V2或者V1版本中的handleXXX函数，在 application:didFinishLaunchingWithOptions 中实现 setHandlePushBlockV3: 回调即可
 */
- (void)setHandlePushBlockV3:(YWPushHandleResultBlockV3)handlePushBlockV3;

#pragma mark - V1

/**
 *  Push处理回调
 *  @param aAPS APS消息本身
 *  @param aConversationId 会话Id
 */
typedef void(^YWPushHandleResultBlock)(NSDictionary *aAPS, NSString *aConversationId);

/**
 *  处理启动参数
 *  @param aLaunchOptions 启动参数
 *  @param aCompletionBlock 如果OpenIM接受处理该启动参数，在处理完毕后通过此回调返回结果
 *  @return OpenIM是否接受处理该启动参数
 */
- (BOOL)handleLaunchOptions:(NSDictionary *)aLaunchOptions completionBlock:(YWPushHandleResultBlock)aCompletionBlock __attribute__((deprecated("您不需要再调用V2或者V1版本中的handleXXX函数，在 application:didFinishLaunchingWithOptions 中实现 setHandlePushBlockV3: 回调即可")));

/**
 *  处理Push消息
 *  @param aPushUserInfo
 *  @param aCompletionBlock
 *  @return OpenIM是否接受处理该Push
 */
- (BOOL)handlePushUserInfo:(NSDictionary *)aPushUserInfo completionBlock:(YWPushHandleResultBlock)aCompletionBlock __attribute__((deprecated("您不需要再调用V2或者V1版本中的handleXXX函数，在 application:didFinishLaunchingWithOptions 中实现 setHandlePushBlockV3: 回调即可")));


#pragma mark - V2

/**
 *  Push处理回调
 *  @param aAPS APS消息本身
 *  @param aConversationId 会话Id
 *  @param aConversationClass 会话类型，返回值可能是：[YWP2PConversation class]、[YWTribeConversation class]
 */
typedef void(^YWPushHandleResultBlockV2)(NSDictionary *aAPS, NSString *aConversationId, Class aConversationClass);

/**
 *  处理启动参数
 *  @param aLaunchOptions 启动参数
 *  @param aCompletionBlock 如果OpenIM接受处理该启动参数，在处理完毕后通过此回调返回结果
 *  @return OpenIM是否接受处理该启动参数
 */
- (BOOL)handleLaunchOptionsV2:(NSDictionary *)aLaunchOptions completionBlock:(YWPushHandleResultBlockV2)aCompletionBlock __attribute__((deprecated("您不需要再调用V2或者V1版本中的handleXXX函数，在 application:didFinishLaunchingWithOptions 中实现 setHandlePushBlockV3: 回调即可")));

/**
 *  处理Push消息
 *  @param aPushUserInfo
 *  @param aCompletionBlock
 *  @return OpenIM是否接受处理该Push
 */
- (BOOL)handlePushUserInfoV2:(NSDictionary *)aPushUserInfo completionBlock:(YWPushHandleResultBlockV2)aCompletionBlock __attribute__((deprecated("您不需要再调用V2或者V1版本中的handleXXX函数，在 application:didFinishLaunchingWithOptions 中实现 setHandlePushBlockV3: 回调即可")));


@end
