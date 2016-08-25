//
//  IWXOUIService.h
//  WXOpenIMSDK
//
//  Created by huanglei on 14/12/16.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "IYWUIServiceDef.h"

@class YWPerson, YWTribe, YWConversation, YWFeedbackConversation;

@class YWConversationListViewController, YWConversationViewController;

@class YWFeedbackViewController;

#pragma mark - 常量及类型定义



#pragma mark - Service接口定义

/**
 *  UI Service公开接口
 */

@protocol IYWUIService <NSObject>

#pragma mark - UI API

/**
 *  打开首页
 *  @brief 如果尚未连接到服务器，首先会连接到服务器
 *  @param aController 用以弹出IM页面的外部Controller，例如H5容器Controller
 *  @return 如果尚未设置登录能力，则返回NO，否则返回YES
 */
- (BOOL)openHomeFromController:(UIViewController *)aController;

/**
 *  创建会话列表页面
 *  @return 所创建的会话列表页面
 */
- (YWConversationListViewController *)makeConversationListViewController;

/**
 *  打开单聊页面
 *  @brief 如果尚未连接到服务器，首先会连接到服务器
 *  @param aPerson 聊天对象
 *  @param aController 用以弹出IM页面的外部Controller，例如H5容器Controller
 *  @return 如果尚未设置登录能力或者personId为空，则返回NO，否则返回YES
 */
- (BOOL)openChatWithPerson:(YWPerson *)aPerson fromController:(UIViewController *)aController;
- (BOOL)openChatWithPerson:(YWPerson *)aPerson fromController:(UIViewController *)aController withDidOpenChatBlock:(void (^)(YWConversationViewController *conversationViewController))didOpenChatBlock;

/**
 *  构建单聊页面
 *  @param aPerson 聊天对象
 */
- (YWConversationViewController *)makeConversationViewControllerWithPerson:(YWPerson *)aPerson;


/**
 *  打开群聊页面
 *  @param aTribe 群
 *  @param aController 用以弹出IM页面的外部Controller，例如H5容器Controller
 *  @return 如果尚未设置登录能力或者aTribe为空，则返回NO
 */
- (BOOL)openChatWithTribe:(YWTribe *)aTribe fromController:(UIViewController *)aController;

/**
 *  构建群聊页面
 *  @param aTribe 群聊对象
 */
- (YWConversationViewController *)makeConversationViewControllerWithTribe:(YWTribe *)aTribe;


/**
 *  打开单聊页面
 *  @brief 如果尚未连接到服务器，首先会连接到服务器
 *  @param aConversationId 聊天会话Id。注意：conversationId与personId并不等同。您一般不能自己构造一个conversationId，而是从conversation等特定接口中才能读取到conversationId。如果需要使用personId来打开会话，应该使用openChatWithPerson这个接口。
 *  @param aController 用以弹出IM页面的外部Controller，例如H5容器Controller
 *  @return 如果尚未设置登录能力或者conversation为空，则返回NO，否则返回YES
 */

- (BOOL)openChatWithConversationId:(NSString *)aConversationId fromController:(UIViewController *)aController;
- (BOOL)openChatWithConversationId:(NSString *)aConversationId fromController:(UIViewController *)aController withDidOpenChatBlock:(void (^)(YWConversationViewController *conversationViewController))didOpenChatBlock;


/**
 *  通过会话Id构建聊天页面
 *  @param aConversationId 会话Id
 *  @return 聊天页面
 */
- (YWConversationViewController *)makeConversationViewControllerWithConversationId:(NSString *)aConversationId;

/**
 *  关闭openIM SDK的UI界面，但是不会断开登录。
 *  @param aAnimated 是否需要动画
 */
- (void)dismissSDKUIAnimated:(BOOL)aAnimated;


/**
 *  导航栏返回按钮，如果没有设置，则为默认返回字样
 */
@property (nonatomic, strong) UIButton *navigationBackButton;

/**
 *  设置会话列表和聊天界面头像ImageView的contentMode
 */
@property (nonatomic, assign) UIViewContentMode avatarImageViewContentMode;

/**
 *  设置会话列表和聊天界面头像ImageView的圆角弧度
 *  注意，请在需要圆角矩形时设置，会话列表和聊天界面头像默认圆形。
 *  默认值为 -1.0 ，表示使用圆形
 */
@property (nonatomic, assign) CGFloat avatarImageViewCornerRadius;

#pragma mark - 能力获取
/**
 *  当IM需要显示单聊person或者群成员的profile时，会调用这个block，
 *  @param aPerson          YWPerson对象，当需要设置群的profile时，为nil
 *  @param aTribe           YWTribe对象，当需要设置单聊person的profile时，为nil，当需要设置群成员的profile时，与aPerson都不为nil
 *  @param aProgressBlock   获取到部分profile信息时，可以立即先调用这个block，通知IM，以便更快的显示这部分先获取到的信息。
 *  @param aCompletionBlock 获取profile完成后，调用这个block通知IM
 */
@property (nonatomic, copy) YWFetchProfileForPersonBlock fetchProfileForPersonBlock;
- (void)setFetchProfileForPersonBlock:(YWFetchProfileForPersonBlock)fetchProfileForPersonBlock;

/**
 *  当IM需要显示profile时，会调用这个block，
 *  @param aTribe           YWTribe对象，当需要设置单聊person的profile时，为nil，当需要设置群成员的profile时，与aPerson都不为nil
 */
@property (nonatomic, copy) YWFetchProfileForTribeBlcok fetchProfileForTribeBlock;
- (void)setFetchProfileForTribeBlock:(YWFetchProfileForTribeBlcok)fetchProfileForTribeBlock;

/**
 *  当需要设置客服的profile时，请使用这个block，如果不设置，客服默认显示为主账号名:子账号名
 */
@property (nonatomic, copy) YWFetchProfileForEServiceBlock fetchProfileForEServiceBlock;
- (void)setFetchProfileForEServiceBlock:(YWFetchProfileForEServiceBlock)fetchProfileForEServiceBlock;

/**
 *  缓存失效时长，单位是秒。
 */
@property (nonatomic, assign) NSTimeInterval profileCacheExpireTime;

/**
 *  清除对指定 person 的 profile 缓存
 *
 *  @param person 用户对象
 */
- (void)removeCachedProfileForPerson:(YWPerson *)person;

/**
 *  清除对指定 person 在 tribe 中的 profile 缓存
 *
 *  @param person 用户对象
 *  @param tribe  群聊对象
 */
- (void)removeCachedProfileForPerson:(YWPerson *)person inTribe:(YWTribe *)tribe;


/**
 *  清空指定 tribe 的profile缓存
 */
- (void)removeCachedProfileForTribe:(YWTribe *)aTribe;
- (void)removeCachedProfileForTribeID:(NSString *)tribeID;

/**
 *  当IM需要显示profile时，会调用这个block
 *  @param conversation 自定义会话对象
 *  @param aCompletionBlock 获取profile完成后，调用这个block通知IM
 */
@property (nonatomic, copy) YWFetchCustomProfileBlock fetchCustomProfileBlock;
- (void)setFetchCustomProfileBlock:(YWFetchCustomProfileBlock)fetchCustomProfileBlock;

/**
 *  删除会话对应的UIProfile缓存，比如当用户信息发生变化时
 *  @param  aConversation 会话，可以是单聊，也可是群聊
 */
- (void)removeCacheForConversation:(YWConversation *)aConversation;

/**
 *  删除全部缓存，比如当切换用户时，如果同一个人显示的名称和头像需要变更
 */
- (void)removeAllCache;

/**
 *  当IM需要显示导航栏按钮时，会调用这个block，你需要构建一个新的按钮，用于显示在导航栏的左上角
 */
@property (nonatomic, copy) YWMakeBackButtonBlock makeBackButtonBlock;
- (void)setMakeBackButtonBlock:(YWMakeBackButtonBlock)makeBackButtonBlock;

#pragma mark - 事件回调

/**
 *  未读数发生变化
 *  @param aCount 总的未读数
 */
@property (nonatomic, copy) YWUnreadCountChangedBlock unreadCountChangedBlock;
- (void)setUnreadCountChangedBlock:(YWUnreadCountChangedBlock)aBlock;

/// 新消息通知的block
@property (nonatomic, copy) YWOnNewMessageBlock onNewMessageBlock;
- (void)setOnNewMessageBlock:(YWOnNewMessageBlock)aBlock;


#pragma mark - 用户行为回调

/**
 *  打开某个url的回调block
 *  @param aURLString 某个url
 *  @param aParentController 用于打开的顶层控制器
 */
@property (nonatomic, copy) YWOpenURLBlock openURLBlock;
- (void)setOpenURLBlock:(YWOpenURLBlock)aBlock;

/**
 *  当IMUIKit需要预览图片消息时，会调用这个block
 */
@property (nonatomic, copy) YWUIPreviewImageMessageBlockV2 previewImageMessageBlockV2;
- (void)setPreviewImageMessageBlockV2:(YWUIPreviewImageMessageBlockV2)previewImageMessageBlockV2;

/**
 *  当IMUIKit需要预览图片消息时，会调用这个block.
 *  V3版本，使用NSDictionary传递上下文信息，便于扩展
 */
@property (nonatomic, copy) YWUIPreviewImageMessageBlockV3 previewImageMessageBlockV3;
- (void)setPreviewImageMessageBlockV3:(YWUIPreviewImageMessageBlockV3)previewImageMessageBlockV3;


/**
 *  打开某个profile的回调block
 *  @param aUserId 某个userId
 *  @param aParentController 用于打开的顶层控制器
 */
@property (nonatomic, copy) YWOpenProfileBlock openProfileBlock;
- (void)setOpenProfileBlock:(YWOpenProfileBlock)openProfileBlock;


/**
 *  当IMUIKit需要预览地理位置时，会调用这个block
 */
@property (nonatomic, copy) YWUIPreviewLocationBlock previewLocationBlock;
- (void)setPreviewLocationBlock:(YWUIPreviewLocationBlock)previewLocationBlock;


#pragma mark - 提示信息
/**
 *  当IMUIKit需要显示通知时，会调用这个block。
 *  开发者需要实现并设置这个block，以便给用户提示。
 *  @param aViewController 当前的controller
 *  @param aTitle 标题
 *  @param aSubtitle 子标题
 *  @param aType 类型
 */
@property (nonatomic, copy) YWShowNotificationBlock showNotificationBlock;
- (void)setShowNotificationBlock:(YWShowNotificationBlock)showNotificationBlock;





#pragma mark - 数据获取

/**
 *  获取所有未读消息数
 */
- (NSUInteger)getTotalUnreadCount;

/**
 *  获取某个联系人的未读消息数
 */
- (NSUInteger)getUnreadCountOfPerson:(YWPerson *)aPerson;

#pragma mark - 其他属性获取

/**
 *  默认为nil,使用默认的Categery,开发者需要定制播放语音的category时，可以设置这个值
 *  可选的值为：AVAudioSessionCategoryPlayAndRecord（听筒模式）     AVAudioSessionCategoryPlayback（扬声器模式）
 *  扬声器模式支持靠近耳朵时自动切换到听筒
 */
@property (nonatomic, strong) NSString *audioSessionCategory;

/// 当前IM页面的根Controller
@property (nonatomic, strong, readonly) UINavigationController *rootNavigationController;

/**
 *  @brief 设置IMUIKit界面绘制所需资源包，默认使用自带资源包。
 *  @param customizedUIResources 自定义界面后所使用的资源包。
 *  @return 是否成功设置
 */
- (BOOL)setCustomizedUIResources:(NSBundle *)customizedUIResources;

#pragma mark - 设置默认行为的工具方法

/**
 *  为聊天页面添加默认的 InputView 插件，当不是通过 YWIMKit 创建聊天页面却希望添加默认插件时，可调用该方法
 */
- (void)addDefaultInputViewPluginsToMessagesListController:(YWConversationViewController *)controller;

#pragma mark - 其他事件定义 三方开发者不需要关心

/**
 *  淘宝h5页面需要免登，这个回调被调用时，一般需要你植入免登cookies信息
 */
@property (nonatomic, copy) YWAutoLoginForH5Block autoLoginForH5Block;
- (void)setAutoLoginForH5Block:(YWAutoLoginForH5Block)autoLoginForH5Block;

/**
 *  淘宝帐号，用户点击修改漫游密码的回调
 */
@property (nonatomic, copy) YWWantChangeRoamingPasswordBlock wantChangeRoamingPasswordBlock;
- (void)setWantChangeRoamingPasswordBlock:(YWWantChangeRoamingPasswordBlock)wantChangeRoamingPasswordBlock;


#pragma mark - deprecated
/**
 *  当IM需要显示profile时，会调用这个block
 *  @note  V2版本可以方便开发者在获取到profile中的部分信息时就回调IM，以便更快刷新profile的显示
 *  @param aUserId 用户Id
 *  @param aProgressBlock 获取到部分profile信息时，可以先调用这个block，通知IM。以便更快的显示这部分先获取到的信息。
 *  @param aCompletionBlock 获取profile完成后，调用这个block通知IM
 */
@property (nonatomic, copy) YWFetchProfileBlockV2 fetchProfileBlockV2 __attribute__((deprecated("请使用fetchProfileForPersonBlock")));
- (void)setFetchProfileBlockV2:(YWFetchProfileBlockV2)fetchProfileBlockV2 __attribute__((deprecated("请使用setFetchProfileForPersonBlock")));

/**
 *  当person在不同的群中需要有不同的显示名称时，请使用这个block
 *  @note 一般是用于群备注功能
 */
@property (nonatomic, copy) YWFetchPersonProfileWithTribeBlock fetchPersonProfileWithTribeBlock __attribute__((deprecated("请使用fetchProfileForPersonBlock")));
- (void)setFetchPersonProfileWithTribeBlock:(YWFetchPersonProfileWithTribeBlock)fetchPersonProfileWithTribeBlock __attribute__((deprecated("请使用setFetchProfileForPersonBlock")));

/**
 *  当IM需要显示profile时，会调用这个block
 *  @note 推荐使用 setFetchProfileForPersonAndTribeBlock: .
 *  @param aPerson 单聊用户对象
 *  @param aCompletionBlock 获取profile完成后，调用这个block通知IM
 */
@property (nonatomic, copy) YWFetchProfileBlock fetchProfileBlock __attribute__((deprecated("请使用fetchProfileForPersonBlock")));
- (void)setFetchProfileBlock:(YWFetchProfileBlock)fetchProfileBlock __attribute__((deprecated("请使用setFetchProfileForPersonBlock")));

/**
 *  当IM需要显示profile时，会调用这个block
 *  @param tribe 群聊对象
 *  @param aCompletionBlock 获取profile完成后，调用这个block通知IM
 */
@property (nonatomic, copy) YWFetchTribeProfileBlock fetchTribeProfileBlock __attribute__((deprecated("请使用setFetchProfileForPersonBlock")));
- (void)setFetchTribeProfileBlock:(YWFetchTribeProfileBlock)fetchTribeProfileBlock __attribute__((deprecated("请使用setFetchProfileForPersonBlock")));


/**
 *  当IMUIKit需要预览图片消息时，会调用这个block
 */
@property (nonatomic, copy) YWUIPreviewImageMessageBlock previewImageMessageBlock __attribute__((deprecated("请使用V2版本:YWUIPreviewImageMessageBlockV2")));
- (void)setPreviewImageMessageBlock:(YWUIPreviewImageMessageBlock)previewImageMessageBlock __attribute__((deprecated("请使用V2版本:YWUIPreviewImageMessageBlockV2")));

@end


