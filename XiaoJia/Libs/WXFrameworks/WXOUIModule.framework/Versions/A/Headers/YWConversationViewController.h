//
//  WXOConversationViewController.h
//  testFreeOpenIM
//
//  Created by Jai Chen on 15/1/12.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IYWUIServiceDef.h"

#import "YWMessageInputView.h"

@class YWConversation;
@protocol IYWMessage;
@class YWIMCore;
@class YWIMKit;

/**
 *  自定义长按菜单项使用这个Key传递Controller
 */
FOUNDATION_EXTERN NSString *const YWConversationMessageCustomMenuItemUserInfoKeyController;
/**
 *  自定义长按菜单项使用这个Key传递MessageId
 */
FOUNDATION_EXTERN NSString *const YWConversationMessageCustomMenuItemUserInfoKeyMessageId;

/**
 *  某一个消息长按后弹出的菜单
 *  @return 返回的NSArray中包含的必须是 YWMoreActionItem 对象
 *  @note 当菜单项被点击时，会调用该菜单项的actionBlock，并且在UserInfo中使用 YWConversationMessageCustomMenuItemUserInfoKeyController 这个key传递当前的Controller
 */
typedef NSArray *(^YWConversationMessageCustomMenuItemsBlock)(id<IYWMessage> aMessage);


@interface YWConversationViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate,
YWViewControllerEventProtocol>


/**
 *  创建消息列表Controller
 *  @param aIMKit IMKit对象
 *  @param aConversation 会话对象
 */
+ (instancetype)makeControllerWithIMKit:(YWIMKit *)aIMKit conversation:(YWConversation *)aConversation;

/**
 *  YWIMKit对象的弱引用
 */
@property (nonatomic, weak, readonly)   YWIMKit *kitRef;

/**
 *  会话对象
 */
@property (nonatomic, strong, readonly) YWConversation *conversation;

#pragma mark - for CustomUI

/// 输入框
@property (nonatomic, strong) UIView<IYWMessageInputView> *messageInputView;

// 设置输入框隐藏
- (void)setMessageInputViewHidden:(BOOL)hidden animated:(BOOL)animated;

// 承载消息的 TableView
@property (nonatomic, strong, readonly) UITableView *tableView;

/// 顶部自定义View
@property (nonatomic, strong) UIView *customTopView;

/**
 * 设置顶部自定义View及其显示和隐藏View
 * @param customTopView, 顶部自定义View
 * @param hideView, 可选，显示在customTopView下方，用户点击会触发收起customTopView，若为nil，customTopView将会一直显示
 * @param showView, 可选，用户点击展开customTopView，若为nil且hideView不为nil，则会使用hideView
 */
- (void)setCustomTopView:(UIView *)customTopView withOptionHideView:(UIView *)hideView andOptionShowView:(UIView *)showView;

/// 通过接口设置背景图片
@property (nonatomic, strong) UIImage *backgroundImage;


/**
 *  某一个消息长按后弹出的菜单
 *  @return 返回的NSArray中包含的必须是 YWMoreActionItem 对象
 */
@property (nonatomic, copy, readwrite) YWConversationMessageCustomMenuItemsBlock messageCustomMenuItemsBlock;
/**
 *  某一个消息长按后弹出的菜单
 *  @return 返回的NSArray中包含的必须是 YWMoreActionItem 对象
 */
- (void)setMessageCustomMenuItemsBlock:(YWConversationMessageCustomMenuItemsBlock)messageCustomMenuItemsBlock;


#pragma mark - 消息发送
/**
 *  文本发送
 */
- (void)sendTextMessage:(NSString *)text;

@property (nonatomic, copy) YWShouldSendTextBlock shouldSendTextBlock;

/*
 * 图片发送 包含图片上传交互
 *
 * @param image, 要发送的图片
 */
- (void)sendImageMessage:(UIImage *)image;

/**
 *  图片发送 包含图片上传交互
 *
 *  @param image         待发送图片
 *  @param shouldConfirm 如果为 YES，则需要用户确认才会发送
 */
- (void)sendImageMessage:(UIImage *)image shouldAskUserToConfirm:(BOOL)shouldConfirm;

- (void)sendImageMessageData:(NSData *)ImageData;

/**
 *  视频发送 包含视频上传交互
 *
 *  @param videoUrl                     待发送视频，可为本地file://地址，也为http地址
 *  @param size                         视频字节数
 *  @param frontImage                   封面图片
 *  @param frontImageUrl                封面图片，可为本地file://地址，也为http地址
 *  @param width                        视频宽度
 *  @param height                       视频高度
 *  @param duration                     视频时长
 */
- (void)sendVideoMessage:(NSURL *)videoUrl videoSize:(NSUInteger)size frontImage:(UIImage *)frontImage width:(NSUInteger)width height:(NSUInteger)height duration:(NSUInteger)duration;

- (void)sendVideoMessage:(NSURL *)videoUrl videoSize:(NSUInteger)size frontImageUrl:(NSURL *)frontImageUrl width:(NSUInteger)width height:(NSUInteger)height duration:(NSUInteger)duration;


/// 语音发送
- (void)sendVoiceMessage:(NSData*)wavData andTime:(NSTimeInterval)nRecordingTime;

/*
 * C端用户当前正在浏览的宝贝id，OpenIM完成数据从C端传递到B端展现的打通，开发者可以通过宝贝id展现宝贝详细信息，具体参考http://baichuan.taobao.com/doc2/detail?spm=0.0.0.0.aEXBLc&treeId=41&articleId=103769&docType=1#s1
 * @param itemId, 宝贝Id
 */
- (void)sendTradeItemMessage:(NSString *)itemId;

/*
 * C端用户交易焦点信息，OpenIM完成数据从C端传递到B端展现的打通，开发者可以通过宝贝id展现宝贝详细信息，具体参考http://baichuan.taobao.com/doc2/detail?spm=0.0.0.0.aEXBLc&treeId=41&articleId=103769&docType=1#s1
 * @param tradeId, 交易Id
 */
- (void)sendTradeInfoMessage:(NSString *)tradeId;

/**
 *  发送用户的当前输入状态
 *
 *  @param status 详情见 YWConversationInputStatus 枚举
 */
- (void)sendInputStatus:(YWConversationInputStatus)status;

@end

@interface YWConversationViewController ()

/**
 *  在没有数据时显示该view，占据Controller的View整个页面
 */
@property (nonatomic, strong) UIView *viewForNoData;


/**
 *  会话失效的处理 block，如当群被解散或当前用户不再属于该会话时，对应会话会失效应当被删除并且关闭聊天窗口
 */
- (void)setConversationInvalidedHandler:(void (^)(NSError *))conversationInvalidedHandler;

@end



@interface YWConversationViewController()

/**
 *  是否禁止导航栏标题的自动设置，默认为NO;
 *  默认情况下在单聊界面导航栏显示在线状态和输入状态，如果您想自定义聊天界面的标题，请置为YES，
 *  注意这里只是UI显示控制，如果需要真实在线状态，请将IMCore层中IYWContactService中的enableContactOnlineStatus置为YES。
 */
@property (nonatomic, assign) BOOL disableTitleAutoConfig;

/**
 *  顶部导航栏标题不显示在线状态
 */
@property (nonatomic, assign) BOOL disableTitleOnlineDisplay;

/**
 *  是否禁用文字的双击放大功能，默认为NO
 */
@property (nonatomic, assign) BOOL disableTextShowInFullScreen;

/**
 *  禁用群聊中显示发送者的昵称
 */
@property (nonatomic, assign) BOOL disablePersonTribeNick;

/**
 *  禁用聊天窗口中显示接收方消息已读未读标记，默认为NO
 */
@property (nonatomic, assign) BOOL disableReceiverReadFlag;

@end


