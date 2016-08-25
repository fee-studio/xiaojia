//
//  IYWEHelperService.h
//  WXOpenIMSDK
//
//  Created by huanglei on 16/7/8.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YWPerson.h"


@protocol IYWEHelperService <NSObject>

/**
 *  获取某个单聊中，最后服务的子账号Person对象
 *  @param aPerson 主账号Person对象
 */
- (YWPerson *)getLastEHelperForPerson:(YWPerson *)aPerson;



/**
 *  设置跟某个主账号聊天时的分流信息
 *  @param aShuntInfo 分流信息
 *  @param aMainPerson 主账号Person对象
 */
- (void)setShuntInfo:(NSDictionary *)aShuntInfo forMainPerson:(YWPerson *)aMainPerson;

/**
 *  返回当前某个主账号上的分流设置
 *  @param aMainPerson 主账号person对象
 */
- (NSDictionary *)shuntInfoForMainPerson:(YWPerson *)aMainPerson;

/**
 *  shuntInfo中使用这个key传递指定的子账号Person对象
 *  值为YWPerson *
 *  示例：[[YWPerson alloc] initWithEHelperPersonId:@"openim官方客服:android"]
 */
FOUNDATION_EXTERN NSString *const YWEHelperShuntInfoKeySubPerson;

/**
 *  shuntInfo中使用这个key指定是否需要分流，指定为@(NO)后，表示不需要分流，则服务端必定往指定的子账号或者主账号发送消息
 *  值为NSNumber *
 *  不设置或者设置为@(YES)则为需要分流
 */
FOUNDATION_EXTERN NSString *const YWEHelperShuntInfoKeyNeedShunt;

/**
 *  shuntInfo中使用这个key传递分流groupId
 *  值为NSString *
 *  注意：如果指定了不需要分流，则groupId设置无效
 */
FOUNDATION_EXTERN NSString *const YWEHelperShuntInfoKeyGroupId;




#pragma mark - callbacks

/**
 *  转交回调
 */

/**
 *  被客服转交的回调
 *  aUserInfo中使用如下key传递转交上下文信息
 *  YWEHelperTransferKeyFromSubPerson, YWEHelperTransferKeyFromGroup, YWEHelperTransferKeyToSubPerson, YWEHelperTransferKeyToGroup
 */
typedef void(^YWEHelperTransferBlock)(NSDictionary *aUserInfo);

/**
 *  被客服转交的回调
 *  aUserInfo中使用如下key传递转交上下文信息
 */
- (void)addTransferBlock:(YWEHelperTransferBlock)aBlock forKey:(NSString *)aKey priority:(YWBlockPriority)aPriority;
- (void)removeTransferBlockForKey:(NSString *)aKey;

/// YWEHelperTransferBlock的UserInfo中使用这个Key传递转交前的子账号，值为：YWPerson *
FOUNDATION_EXTERN NSString *const YWEHelperTransferKeyFromSubPerson;
/// YWEHelperTransferBlock的UserInfo中使用这个Key传递转交前的子账号分组，值为：YWEHelperGroup *
FOUNDATION_EXTERN NSString *const YWEHelperTransferKeyFromGroup;
/// YWEHelperTransferBlock的UserInfo中使用这个Key传递转交后的子账号，值为：YWPerson *
FOUNDATION_EXTERN NSString *const YWEHelperTransferKeyToSubPerson;
/// YWEHelperTransferBlock的UserInfo中使用这个Key传递转交后的子账号分组，值为：YWEHelperGroup *
FOUNDATION_EXTERN NSString *const YWEHelperTransferKeyToGroup;


@end


@interface YWEHelperGroup : NSObject

@property (nonatomic, copy) NSString *groupId;

@property (nonatomic, copy) NSString *groupName;

@end


@interface YWPerson (IYWEHelperService)

/// 构建客服帐号Person对象
- (instancetype)initWithEHelperPersonId:(NSString *)aPersonId;

/**
 *  创建客服聊天对象，当发生分流时，会优先分流到指定的分组客服
 *  @brief 当您收到客服消息时，您可以判断该Person的appKey是否为YWSDKAppKey，从而对客服的头像等进行特定的显示。
 *  @param aPersonId 客服Id
 *  @param aGroupId 客服分组Id，如果没有对客服进行分组，则可以传入nil，用以辅助分流
 *  @return 客服的Person对象，您可以通过该Person对象创建会话并发起聊天
 */
- (instancetype)initWithPersonId:(NSString *)aPersonId EServiceGroupId:(NSString *)aGroupId baseContext:(YWIMCore *)aBaseContext;


/// 是否子账号
- (BOOL)isSubAccount;

/// 是否客服帐号
- (BOOL)isEHelperPerson;

/// 获取主账号
- (YWPerson *)mainPerson;


#pragma mark - deprecated

/**
 *  控制不要分流，始终发送消息给指定的客服子账号
 */
@property (nonatomic, assign) BOOL lockShunt __attribute__((deprecated("请直接设置IYWEHelperService的shuntInfo")));


@end