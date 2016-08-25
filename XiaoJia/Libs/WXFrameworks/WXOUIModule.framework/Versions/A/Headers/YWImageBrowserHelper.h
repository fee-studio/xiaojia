//
//  YWImageBrowserHelper.h
//  WXOpenIMUIKit
//
//  Created by huanglei on 15/9/7.
//  Copyright (c) 2015年 www.alibaba.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IYWMessage;
@class YWConversation;
@class YWIMKit;

FOUNDATION_EXTERN NSString *const YWImageBrowserHelperActionKeyMessageId;
FOUNDATION_EXTERN NSString *const YWImageBrowserHelperActionKeyConversationId;

/// 图片加载完成的通知
FOUNDATION_EXTERN NSString *const YWImageBrowserHelperNotificationImageLoad;
/// 携带NSError对象，如果有
FOUNDATION_EXTERN NSString *const YWImageBrowserHelperNotificationImageLoadKeyError;
/// 携带messageId，如果有
FOUNDATION_EXTERN NSString *const YWImageBrowserHelperNotificationImageLoadKeyMessageId;
/// 携带conversationId，如果有
FOUNDATION_EXTERN NSString *const YWImageBrowserHelperNotificationImageLoadKeyConversationId;
/// 携带url字符串，如果有
FOUNDATION_EXTERN NSString *const YWImageBrowserHelperNotificationImageLoadKeyUrlString;

/// 以下键值用于控制更多参数
/// 不需要保存按钮，默认为@(YES)
FOUNDATION_EXTERN NSString *const YWImageBrowserHelperParamKeyEnableSave;


@interface YWImageBrowserHelper : NSObject

/**
 *  这个函数用来预览图片消息的大图
 *  @param aMessage 用户点击的图片消息
 *  @param aConversation 所属会话
 *  @param aNavigationController 用于Push的导航栏控制器
 *  @param aNeedDefaultSaveAction 是否需要默认的保存按钮
 *  @param aAdditionalActions 更多选项，数组中每一个对象都必须是YWMoreActionItem对象，用户点击回调的UserInfo中使用 YWImageBrowserHelperActionKeyMessage 作为Key，传递当前操作的id<IYWMessage>对象
 */
+ (void)previewImageMessage:(id<IYWMessage>)aMessage
               conversation:(YWConversation *)aConversation
     inNavigationController:(UINavigationController *)aNavigationController
          additionalActions:(NSArray *)aAdditionalActions;


/**
 *  这个函数用来预览图片消息的大图
 *  @param aMessage 用户点击的图片消息
 *  @param aConversation 所属会话
 *  @param aNavigationController 用于Push的导航栏控制器
 *  @param aNeedDefaultSaveAction 是否需要默认的保存按钮
 *  @param aAdditionalActions 更多选项，数组中每一个对象都必须是YWMoreActionItem对象，用户点击回调的UserInfo中使用 YWImageBrowserHelperActionKeyMessage 作为Key，传递当前操作的id<IYWMessage>对象
 *  @param aIMKit 用于多账号同时登录的情况
 */
+ (void)previewImageMessage:(id<IYWMessage>)aMessage
               conversation:(YWConversation *)aConversation
     inNavigationController:(UINavigationController *)aNavigationController
          additionalActions:(NSArray *)aAdditionalActions
                  withIMKit:(YWIMKit *)aIMKit;

/**
 *  这个函数用来预览图片消息的大图
 *  @param aMessage 用户点击的图片消息
 *  @param aConversation 所属会话
 *  @param aNavigationController 用于Push的导航栏控制器
 *  @param aFromView 可用于呈现动画
 *  @param aNeedDefaultSaveAction 是否需要默认的保存按钮
 *  @param aAdditionalActions 更多选项，数组中每一个对象都必须是YWMoreActionItem对象，用户点击回调的UserInfo中使用 YWImageBrowserHelperActionKeyMessage 作为Key，传递当前操作的id<IYWMessage>对象
 *  @param aIMKit 用于多账号同时登录的情况
 */
+ (void)previewImageMessage:(id<IYWMessage>)aMessage
               conversation:(YWConversation *)aConversation
     inNavigationController:(UINavigationController *)aNavigationController
                   fromView:(UIView *)aFromView
          additionalActions:(NSArray *)aAdditionalActions
                  withIMKit:(YWIMKit *)aIMKit;

/**
 *  用来预览一批图片链接
 */
+ (void)previewImagesWithUrlsArray:(NSArray *)aUrlsArray
                      currentIndex:(NSUInteger)aCurrentIndex
            inNavigationController:(UINavigationController *)aNavigationController
                          fromView:(UIView *)aFromView
                 additionalActions:(NSArray *)aAdditionalActions
                         withIMKit:(YWIMKit *)aIMKit
                       extraParams:(NSDictionary *)aExtraParams;


/**
 *  用于外部控制关闭大图预览页面
 */
+ (void)dismissLastController;

@end
