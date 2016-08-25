//
//  IYWSettingService.h
//  WXOpenIMSDK
//
//  Created by huanglei on 15/6/5.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IYWSettingServiceDef.h"


@protocol IYWSettingService <NSObject>

// 关闭@消息相关功能
@property (nonatomic, assign) BOOL disableAtFeatures;

#pragma mark - 消息提醒设置

/**
 *  将本地的消息接收设置更新至服务端的状态，sdk内部每24h同步一次,开发者可以视自己需求调用
 */
- (void)syncMessageSettingFromServerWithompletionBlcok:(YWCompletionBlock)aCompletion;

/**
 *  PC在线时消息是否推送
 */

/// 获取PC在线时消息是否推送设置
- (BOOL)messagePushWhenPCOnline;

/// 异步设置PC在线时消息是否推送的值
- (void)asyncSetMessagePushWhenPCOnline:(BOOL)aNeedPush completion:(YWCompletionBlock)aCompletion;


/**
 *  单聊和群消息接收设置
 *  注意：下面的get接口不会发起网络请求，请先调用syncMessageSettingFromServerWithompletionBlcok:方法
 */

/// 获取person 发送的消息后台是否push
- (BOOL)getMessagePushEnableForPerson:(YWPerson *)person;

/// 异步设置person 发送的消息后台是否push
- (void)asyncSetMessagePushEnable:(BOOL)enable ForPerson:(YWPerson *)person completion:(YWCompletionBlock)aCompletion;

/// 获取tribe 普通消息的接收设置
- (YWMessageFlag)getMessageReceiveForTribe:(YWTribe *)tribe;

/// 异步设置tribe 普通消息的接收设置
- (void)asyncSetMessageReceive:(YWMessageFlag)flag ForTribe:(YWTribe *)tribe completion:(YWCompletionBlock)aCompletion;

/// 获取tribe at消息的接收设置
- (YWAtMessageFlag)getAtMessageEnableReceiveForTribe:(YWTribe *)tribe;
/// 异步设置tribe at消息的接收设置
- (void)asyncSetAtMessageReceive:(YWAtMessageFlag)atflag ForTribe:(YWTribe *)tribe completion:(YWCompletionBlock)aCompletion;

/// 异步设置tribe 普通消息和at消息的接收设置
- (void)asyncSetMessageReceive:(YWTribeMessageSettingItem *)tribeMessageItem completion:(YWCompletionBlock)aCompletion;

/**
 *  批量获取单聊和群消息设置
 *  @param, personArray,需要获取的 YWPerson 数组
 *  @param, tribeArray, 需要获取的 YWTribe 数组
 *  @result, 包含 YWP2PMessageSetting 和 YWTribeMessageSetting两个键的字典，其值分别为 YWP2PMessageSettingItem 数组和 YWTribeMessageSettingItem 数组
 */
- (NSDictionary *)getMessageSettingForPersons:(NSArray *)personArray andTribes:(NSArray *)tribeArray;
 /**
 *  异步从服务端批量获取单聊和群消息设置
 *
 *  @param personArray 需要获取的 YWPerson 数组
 *  @param tribeArray  需要获取的 YWTribe 数组
 *  @param aCompletion 成功与否的回调，在回调中调用上面的get方法获取更新后的本地数据
 */
- (void )asyncGetMessageSettingFromServerForPersons:(NSArray *)personArray andTribes:(NSArray *)tribeArray completion:(YWCompletionBlock)aCompletion;


/**
 *  异步批量设置单聊和群消息接收的值
 *  @param, personArray,需要设置的 YWP2PMessageSettingItem 数组
 *  @param, tribeArray, 需要设置的 YWTribeMessageSettingItem 数组
 */
- (void)asyncSetMessageSettingForPersons:(NSArray *)personSettingArray andTribes:(NSArray *)tribeSettingArray completion:(YWCompletionBlock)aCompletion;


/**
 *  获取开发者自定义的设置项
 */
- (NSDictionary *)getExtraSettings;

/**
 *  异步设置自定义设置项，服务端只负责保存，不会进行解析
 */
- (void)asyncSetExtraSettings:(NSDictionary *)settings completion:(YWCompletionBlock)aCompletion;
@end
