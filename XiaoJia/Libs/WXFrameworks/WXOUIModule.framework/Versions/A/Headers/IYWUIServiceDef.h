//
//  IYWUIServiceDef.h
//  WXOpenIMUIKit
//
//  Created by huanglei on 15/4/10.
//  Copyright (c) 2015年 www.alibaba.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <WXOpenIMSDKFMWK/YWContactServiceDef.h>

@class YWPerson;
@class YWTribe;
@class YWConversation;

@protocol IYWMessage;
@class YWConversation;

/**
 * 消息类型
 */
/// 文本消息
FOUNDATION_EXTERN NSInteger const YWIMKitNewMessageTypeText;
/// 音频消息
FOUNDATION_EXTERN NSInteger const YWIMKitNewMessageTypeVoice;
/// 图片消息
FOUNDATION_EXTERN NSInteger const YWIMKitNewMessageTypeImage;
/// 其他类型
FOUNDATION_EXTERN NSInteger const YWIMKitNewMessageTypeOther;


/**
 *  UIService错误域
 */
FOUNDATION_EXTERN NSString *const YWUIServiceErrorDomain;

/**
 *  Error的UserInfo中使用这个Key来传递错误描述信息
 */
FOUNDATION_EXTERN NSString *const YWUIServiceErrorDescriptionKey;

/**
 *  用户点击自定义会话节点左滑菜单时，回调block参数userInfo的键值，用来保存对应的会话
 */
FOUNDATION_EXTERN NSString *const YWMoreActionUserInfoConversation;

/**
 *  用户点击自定义会话节点左滑菜单时，回调block参数userInfo的键值，用来保存菜单名称
 */
FOUNDATION_EXTERN NSString *const YWMoreActionUserInfoActionName;



#pragma mark - Fetch Profile
/**
 *  当IM需要显示单聊对象或者群成员profile时，会调用这个block，
 *  @param aPerson          YWPerson对象，当需要设置群的profile时，为nil
 *  @param aTribe           YWTribe对象，当需要设置单聊person的profile时，为nil，当需要设置群成员的profile时，与aPerson都不为nil
 *  @param aProgressBlock   获取到部分profile信息时，可以立即先调用这个block，通知IM，以便更快的显示这部分先获取到的信息。
 *  @param aCompletionBlock 获取profile完成后，调用这个block通知IM
 */
typedef void (^YWFetchProfileForPersonBlock) (YWPerson *aPerson, YWTribe *aTribe, YWProfileProgressBlock aProgressBlock, YWProfileCompletionBlock aCompletionBlock);
/**
 *  当需要显示群的profile时，会调用这个block
 *
 *  @param aTribe           YWTribe对象
 *  @param aProgressBlock   获取到部分profile信息时，可以立即先调用这个block，通知IM，以便更快的显示这部分先获取到的信息。
 *  @param aCompletionBlock 获取profile完成后，调用这个block通知IM
 */
typedef void (^YWFetchProfileForTribeBlcok) (YWTribe *aTribe, YWProfileProgressBlock aProgressBlock, YWProfileCompletionBlock aCompletionBlock);

/**
 *  当需要设置客服的profile时，请使用这个block，如果不设置，客服默认显示为主账号名:子账号名
 */
typedef void (^YWFetchProfileForEServiceBlock) (YWPerson *aPerson, YWProfileProgressBlock aProgressBlock, YWProfileCompletionBlock aCompletionBlock);

/**
 *  自定义会话，成功获取Profile后，通过这个回调，通知旺信
 *  @param conversation 会话对象
 *  @param aDisplayName 显示名称
 *  @param aAvatarImage 头像
 */
typedef void(^YWFetchCustomProfileCompletionBlock)(BOOL aIsSuccess, YWConversation *conversation, NSString *aDisplayName, UIImage *aAvatarImage);

/**
 *  自定义会话，当IM需要显示profile时，会调用这个block
 *  @param conversation 会话对象
 *  @param aCompletionBlock 获取profile完成后，调用这个block通知IM
 */
typedef void(^YWFetchCustomProfileBlock)(YWConversation *conversation, YWFetchCustomProfileCompletionBlock aCompletionBlock);

#pragma mark - Make Navigation Back Button

/**
 *  当IM需要显示导航栏按钮时，会调用这个block，你需要构建一个新的按钮，用于显示在导航栏的左上角
 */
typedef UIButton *(^YWMakeBackButtonBlock)();


#pragma mark - Open URL

/**
 *  打开某个url的回调block
 *  @param aURLString 某个url
 *  @param aParentController 用于打开的顶层控制器
 */
typedef void(^YWOpenURLBlock)(NSString *aURLString, UIViewController *aParentController);

#pragma mark - Preview Image

/**
 *  当IMUIKit需要预览图片消息时，会调用这个block
 */
typedef void(^YWUIPreviewImageMessageBlock)(id<IYWMessage> aMessage, UIViewController *aFromController);

/**
 *  当IMUIKit需要预览图片消息时，会调用这个block
 *  @param aMessage 用户点击的图片消息
 *  @param aOfConversation 当前加载的会话，您可以从Conversation的fetchedObjects中取出前后的消息，便于图片联播
 *  @param aFromController 从某个Controller触发
 */
typedef void(^YWUIPreviewImageMessageBlockV2)(id<IYWMessage> aMessage, YWConversation *aOfConversation, UIViewController *aFromController);

/**
 *  当IMUIKit需要预览图片消息时，会调用这个block
 *  @param aMessage 用户点击的图片消息
 *  @param aOfConversation 当前加载的会话，您可以从Conversation的fetchedObjects中取出前后的消息，便于图片联播
 *  @param aFromUserInfo 用来传递上下文信息，例如，从某个Controller触发，或者从某个view触发等，键值在下面定义
 */
typedef void(^YWUIPreviewImageMessageBlockV3)(id<IYWMessage> aMessage, YWConversation *aOfConversation, NSDictionary *aFromUserInfo);

/// 传递触发的UIViewController对象
#define YWUIPreviewImageMessageUserInfoKeyFromController    @"YWUIPreviewImageMessageUserInfoKeyFromController"
/// 传递触发的UIView对象
#define YWUIPreviewImageMessageUserInfoKeyFromView          @"YWUIPreviewImageMessageUserInfoKeyFromView"


#pragma mark - Open Profile
/**
 *  打开某个profile的回调block
 *  @param aUserId 某个userId
 *  @param aParentController 用于打开的顶层控制器
 */
typedef void(^YWOpenProfileBlock)(YWPerson *aPerson, UIViewController *aParentController);

#pragma mark - Open Location

/**
 *  打开地理位置的回调
 *  @param aMessage 用户所点击的地理位置消息
 *  @param aFromUserInfo 上下文信息，例如所在Controller，见下面的键值定义
 */
typedef void(^YWUIPreviewLocationBlock)(id<IYWMessage> aMessage, NSDictionary *aFromUserInfo);

/// 传递触发的UIViewController对象
#define YWUIPreviewLocationUserInfoKeyFromController    @"YWUIPreviewLocationUserInfoKeyFromController"




#pragma mark - IM Events
/**
 *  未读数发生变化
 *  @param aCount 总的未读数
 */
typedef void(^YWUnreadCountChangedBlock)(NSInteger aCount);

/**
 *  新消息通知
 */
typedef void(^YWOnNewMessageBlock)(NSString *aSenderId, NSString *aContent, NSInteger aType, NSDate *aTime);

/**
 *  是否可以发送内容为content的文本消息
 */
typedef BOOL(^YWShouldSendTextBlock)(NSString *content);



/**
 *  提示信息的类型定义
 */
typedef NS_ENUM(NSInteger, YWMessageNotificationType) {
    /// 普通消息
    YWMessageNotificationTypeMessage = 0,
    /// 警告
    YWMessageNotificationTypeWarning,
    /// 错误
    YWMessageNotificationTypeError,
    /// 成功
    YWMessageNotificationTypeSuccess
};

/**
 *  当IMUIKit需要显示通知时，会调用这个block。
 *  开发者需要实现并设置这个block，以便给用户提示。
 *  @param aViewController 当前的controller
 *  @param aTitle 标题
 *  @param aSubtitle 子标题
 *  @param aType 类型
 */
typedef void(^YWShowNotificationBlock)(UIViewController *aViewController, NSString *aTitle, NSString *aSubtitle, YWMessageNotificationType aType);



#pragma mark - 其他定义 三方开发者不需要关心

/**
 *  淘宝h5页面需要免登的回调block
 */
typedef void(^YWAutoLoginForH5Block)();

/**
 *  淘宝账号点击修改漫游密码的回调
 */
typedef void(^YWWantChangeRoamingPasswordBlock)(NSString *aConversationId);

/**
 *  页面需要透出的通用事件，例如viewDidLoad，viewWillAppear，viewDidAppear等
 */
typedef void(^YWViewDidLoadBlock)(void);
typedef void(^YWViewWillAppearBlock)(BOOL aAnimated);
typedef void(^YWViewDidAppearBlock)(BOOL aAnimated);
typedef void(^YWViewWillDisappearBlock)(BOOL aAnimated);
typedef void(^YWViewDidDisappearBlock)(BOOL aAnimated);
typedef void(^YWViewControllerWillDeallocBlock) (void);

@protocol YWViewControllerEventProtocol <NSObject>

@property (nonatomic, copy, readonly) YWViewDidLoadBlock viewDidLoadBlock;
@property (nonatomic, copy, readonly) YWViewWillAppearBlock viewWillAppearBlock;
@property (nonatomic, copy, readonly) YWViewDidAppearBlock viewDidAppearBlock;
@property (nonatomic, copy, readonly) YWViewWillDisappearBlock viewWillDisappearBlock;
@property (nonatomic, copy, readonly) YWViewDidDisappearBlock viewDidDisappearBlock;
@property (nonatomic, copy, readonly) YWViewControllerWillDeallocBlock viewControllerWillDeallocBlock;

/**
 *  View的相关事件调出
 */
- (void)setViewDidLoadBlock:(YWViewDidLoadBlock)viewDidLoadBlock;
- (void)setViewWillAppearBlock:(YWViewWillAppearBlock)viewWillAppearBlock;
- (void)setViewDidAppearBlock:(YWViewDidAppearBlock)viewDidAppearBlock;
- (void)setViewWillDisappearBlock:(YWViewWillDisappearBlock)viewWillDisappearBlock;
- (void)setViewDidDisappearBlock:(YWViewDidDisappearBlock)viewDidDisappearBlock;
- (void)setViewControllerWillDeallocBlock:(YWViewControllerWillDeallocBlock)viewControllerWillDeallocBlock;

@end

@interface IYWUIServiceDef : NSObject

@end



#pragma mark - deprecated
/**
 *  当IM需要显示profile时，会调用这个block
 *  deprecated
 *  @param aPerson person对象
 *  @param aProgressBlock 获取到部分profile信息时，可以立即先调用这个block，通知IM，以便更快的显示这部分先获取到的信息。
 *  @param aCompletionBlock 获取profile完成后，调用这个block通知IM
 */
typedef void(^YWFetchProfileBlockV2)(YWPerson *aPerson, YWFetchProfileProgressBlock aProgressBlock, YWFetchProfileCompletionBlock aCompletionBlock);

/**
 *  当IM需要显示profile时，会调用这个block
 *  deprecated
 *  @note 推荐使用 YWFetchProfileBlockV2 .
 *  @param aPerson person对象
 *  @param aCompletionBlock 获取profile完成后，调用这个block通知IM
 */
typedef void(^YWFetchProfileBlock)(YWPerson *aPerson, YWFetchProfileCompletionBlock aCompletionBlock);

/**
 *  群成员备注使用如下定义
 */

/**
 *  当person在不同的群中需要有不同的显示名称时，使用这个block
 *  deprecated
 */
typedef void(^YWPersonProfileWithTribeCompletionBlock)(BOOL aIsSuccess, YWPerson *aPerson, YWTribe *tribe, NSString *aDisplayName, UIImage *aAvatarImage);

/**
 *  当person在不同的群中需要有不同的显示名称时，使用这个block
 *  deprecated
 */
typedef void(^YWPersonProfileWithTribeProgressBlock)(YWPerson *aPerson, YWTribe *tribe, NSString *aDisplayName, UIImage *aAvatarImage);

/**
 *  当person在不同的群中需要有不同的显示名称时，请使用这个block
 *  deprecated
 *  @param tribe, 需要显示person profile的群，当不在群中显示时，tribe为nil，即为YWFetchProfileBlockV2的功能
 */
typedef void(^YWFetchPersonProfileWithTribeBlock) (YWPerson *aPerson, YWTribe *aTribe, YWPersonProfileWithTribeProgressBlock aProgressBlock, YWPersonProfileWithTribeCompletionBlock aCompletionBlock);

/**
 *  群聊，成功获取Profile后，通过这个回调，通知旺信
 *  deprecated
 *  @param tribe 群聊对象
 *  @param aDisplayName 显示名称
 *  @param aAvatarImage 头像
 */
typedef void(^YWFetchTribeProfileCompletionBlock)(BOOL aIsSuccess, YWTribe *tribe, NSString *aDisplayName, UIImage *aAvatarImage);

/**
 *  群聊，当IM需要显示profile时，会调用这个block
 *  deprecated
 *  @param aPerson 单聊对象
 *  @param aCompletionBlock 获取profile完成后，调用这个block通知IM
 */
typedef void(^YWFetchTribeProfileBlock)(YWTribe *tribe, YWFetchTribeProfileCompletionBlock aCompletionBlock);

