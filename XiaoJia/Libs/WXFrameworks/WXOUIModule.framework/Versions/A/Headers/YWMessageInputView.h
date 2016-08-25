//
//  WXOMessageInputView.h
//  testFreeOpenIM
//
//  Created by Jai Chen on 15/1/13.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WXOpenIMSDKFMWK/YWConversationServiceDef.h>
#import "IYWMessageInputView.h"
#import "YWInputViewPlugin.h"

@class YWIMKit, YWRecordKit;

/**
 *  当输入框底部的“更多”区域，高度发生变化时，抛出此通知
 *  @note 键盘的出现和消失，也会引起该通知。所以如果需要覆盖“更多”区域，需要判断键盘当前处于弹出状态
 */
FOUNDATION_EXTERN NSString *const YWMorePanelHeightWillChangeNotification;
/// 高度
FOUNDATION_EXTERN NSString *const YWMorePanelHeightWillChangeNotificationKeyHeight;
/// 动画方式
FOUNDATION_EXTERN NSString *const YWMorePanelHeightWillChangeNotificationKeyAnimationOption;
/// 时长
FOUNDATION_EXTERN NSString *const YWMorePanelHeightWillChangeNotificationKeyDuration;
/// 菜单、键盘模式切换
FOUNDATION_EXTERN NSString *const YWInputViewSwitchMenuWillChangeNotification;

@interface YWMessageInputView : UIView
<IYWMessageInputView,
YWInputViewPluginDelegate>

/**
 *  more面板容器View，可往里添加自定义pluginView
 *  @note 一般不要直接添加子view，如果希望添加子view，请使用下面的push和pop函数
 */
@property (nonatomic, readonly) UIView  *morePanelContentView;

@property (strong, nonatomic) YWRecordKit *recordKit;


/**
 *  语音输入功能开关，默认 NO，即默认打开语音输入
 */
@property (nonatomic, assign, readwrite) BOOL disableAudioInput;

/**
 *  输入栏顶部分割线是否隐藏，默认隐藏
 */
@property (nonatomic, assign, getter=isTopSeparatorHidden) BOOL topSeparatorHidden;

/**
 *  输入框文字限制
 */
@property (nonatomic, assign) NSUInteger wordLimit;

/**
 *  控制“更多”面板的高度
 */
+ (void)setMorePanelHeight:(CGFloat)aHeight;
+ (CGFloat)morePanelHeight;


@property (nonatomic, readonly) UIViewController *controllerRef;

@property (nonatomic, weak) YWIMKit *imkit;

#pragma mark - plugin

// 往更多面板中添加与删除item

/**
 *  在最后添加新的item
 */
- (void)addPlugin:(id <YWInputViewPluginProtocol>)plugin;

/**
 *  移除某个item
 */
- (void)removePlugin:(id <YWInputViewPluginProtocol>)plugin;

/**
 *  移除所有item，包含前置插件
 */
- (void)removeAllPlugins;

/**
 *  获取plugin列表，包含前置插件
 */
- (NSArray *)allPluginList;

/**
 *  刷新
 */
- (void)reloadPluginData;

/**
 *  激活某个plugin，相当于手动按下这个插件。一般用在希望进入聊天页面就激活某个输入插件的场景
 */
- (void)activatePlugin:(id<YWInputViewPluginProtocol>)plugin;

/**
 *  插入一段内容，如果atCurrent为YES，则在当前光标处添加，如果为NO或无光标，添加在末尾
 *  @return 返回插入后的内容
 */
- (NSString *)insertEmotion:(NSString *)emotion atCurrentCurser:(BOOL)atCurrent;

@property (nonatomic, strong) UIView *menuView;// 输入框位置的自定义菜单

- (void)switchMenuAnimated:(BOOL)animated;//切换菜单和输入框

@end
