//
//  WXOInputViewPlugin.h
//  WXOpenIMUIKit
//
//  Created by Zhiqiang Bao on 15-2-3.
//  Copyright (c) 2015年 www.alibaba.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IYWMessageInputView.h"

@class YWEmoticon;

/**
 *  默认插件的类型定义
 *  这个定义用于对方显示当前用户的操作状态，例如“对方正在拍照”
 *  一般地，您不需要关心这些定义，如果您实现了自定义输入插件，可以直接返回YWInputViewPluginTypeDefault类型
 *  如果您实现了拍照、选图、地理位置等插件，你可以返回以下类型，确保对方可以收到正确的提示
 */
typedef NS_ENUM(NSUInteger, YWInputViewPluginType) {
    YWInputViewPluginTypeDefault = 0,       // 默认未知类型
    YWInputViewPluginTypeText,              // 文本输入
    YWInputViewPluginTypeVoice,             // 语音输入
    YWInputViewPluginTypeTakePhoto,         // 拍照
    YWInputViewPluginTypePickImage,         // 选择照片
    YWInputViewPluginTypeLocation,          // 地理位置
    YWInputViewPluginTypeShortVideo,        // 短视频
    YWInputViewPluginTypeMorePanel,         // 显示更多面板
};

typedef NS_ENUM(NSUInteger, YWInputViewPluginPosition) {
    YWInputViewPluginPositionMorePanel,     // 位于点击输入框下方的可展开区域
    YWInputViewPluginPositionLeft,          // 位于输入框的左侧，用于前置插件
    YWInputViewPluginPositionRight,         // 位于输入框的右侧，用于前置插件
};

@protocol YWInputViewPluginDelegate;

/*
 * 实现一个插件可以选择实现 WXOInputViewPluginProtocol
 * 或者继承自 WXOInputViewPlugin 重写其中的方法
 */

/********** WXOInputViewPluginProtocol **********/

@protocol YWInputViewPluginProtocol <NSObject>

@optional

// 插件位置，默认为YWInputViewPluginPositionMorePanel
@property (nonatomic, assign) YWInputViewPluginPosition pluginPosition;

// 是否在面板关闭时popPluginContentView，默认是YES
- (BOOL)shouldPopPluginContentViewWhenMorePanelClose;

// 是否显示在前置面板（输入文本框右边），只在加载时判断一次，默认是NO
- (BOOL)isPrepositionPlugin __attribute__((deprecated("请使用pluginPosition")));

// 前置插件按钮普通状态的图标，仅在pluginPosition不为 YWInputViewPluginPositionMorePanel 时有效
- (UIImage *)prepositionPluginNormalIcon;

// 前置插件按钮按下时的图标（若未设置以normal展示），仅在pluginPosition不为 YWInputViewPluginPositionMorePanel 时有效
- (UIImage *)prepositionPluginPressedIcon;

// 前置插件选中时的图标，仅在pluginPosition不为 YWInputViewPluginPositionMorePanel 时有效
- (UIImage *)prepositionPluginSelectedIcon;

- (BOOL)shouldShowRedPoint;

// 前置插件是否打开更多面板，默认为NO
- (BOOL)shouldOpenMorePanel;

@required

// 加载该插件的inputView
@property (nonatomic, weak) UIView<IYWMessageInputView> *inputViewRef;

// 插件类型，用来向对方发送当前用户正在做的操作，例如正在拍照或者正在选择地理位置，详见 YWInputViewPluginType 的定义
@property (nonatomic, readonly) YWInputViewPluginType pluginType;

// 插件图标
@property (nonatomic, readonly, strong) UIImage  *pluginIconImage;

// 插件名称
@property (nonatomic, readonly, copy) NSString *pluginName;

// 插件对应的view，会被加载到inputView上
@property (nonatomic, readonly, strong) UIView   *pluginContentView;

@property (nonatomic, weak) id<YWInputViewPluginDelegate> delegate;

// 插件被选中运行
- (void)pluginDidClicked;

@end

@protocol YWInputViewPluginDelegate <NSObject>

/**
 *  加载移除pluginContentView
 *  添加子view
 */
- (void)pushContentViewOfPlugin:(id <YWInputViewPluginProtocol>)plugin;
/**
 *  移除子view
 */
- (void)popContentViewOfPlugin:(id <YWInputViewPluginProtocol>)plugin;


/**
 * plugin如果需要通知到对方己方当前的输入状态，可以调用下面两个API，告知输入框发送当前用户正在使用该插件
 *
 * plugin进入编辑状态(通知YWMessageInputView更新输入状态)
 */
- (void)pluginWillBeginEdit:(id <YWInputViewPluginProtocol>)plugin;
/**
 *  plugin结束编辑状态(通知YWMessageInputView更新输入状态)
 */
- (void)pluginDidEndEdit:(id <YWInputViewPluginProtocol>)plugin;

@end


/************ WXOInputViewPlugin ************/

@interface YWInputViewPlugin : NSObject <YWInputViewPluginProtocol>

- (instancetype)initWithPluginName:(NSString *)pluginName
                   pluginIconImage:(UIImage *)pluginIconImage;

@end
