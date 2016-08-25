//
//  YWInputViewPluginEmoticonPicker.h
//  WXOpenIMUIKit
//
//  Created by Zhiqiang Bao on 15-2-3.
//  Copyright (c) 2015年 www.alibaba.com. All rights reserved.
//

#import "YWInputViewPlugin.h"
#import "YWMessageInputView.h"
#import "YWEmoticonFactory.h"

@class YWEmoticonGroup;

/// 选中表情回调
typedef void(^YWInputViewPluginEmoticonPickBlock)(id<YWInputViewPluginProtocol> plugin, YWEmoticon *emoticon, YWEmoticonType type);

/// 点击发送回调
typedef void(^YWInputViewPluginEmoticonSendBlock)(id<YWInputViewPluginProtocol> plugin, NSString *sendText);

/// 表情分组栏自定义项点击回调
typedef void(^YWEmoticonGroupCustomizedHandleBlock)(id<YWInputViewPluginProtocol> plugin, YWEmoticonGroup *emoticonGroup);

extern NSString *kPluginIndentityEmoticonPicker;

@interface YWInputViewPluginEmoticonPicker : YWInputViewPlugin

/// @brief 初始化表情选择插件
/// @param pickBlk 选中某个表情的回调
/// @param sendBlk 发送按钮按下的回调
- (instancetype)initWithPickerOverBlock:(YWInputViewPluginEmoticonPickBlock)pickBlk
                              sendBlock:(YWInputViewPluginEmoticonSendBlock)sendBlk;


/**
 *  当前的表情分组
 */
@property (nonatomic, readonly) NSArray *emoticonGroups;

/// @brief 插入表情分组
/// @params group 待插入分组
/// @return 是否成功插入
- (BOOL)addEmoticonGroup:(YWEmoticonGroup *)group;

/// @brief 插入表情分组到指定位置
/// @params group 待插入分组
/// @params index 插入位置索引
/// @return 是否成功插入
- (BOOL)insertEmoticonGroup:(YWEmoticonGroup *)group atIndex:(NSUInteger)index;

/// @brief 插入自定义响应处理分组，当该分组被点击调用handleBlock
/// @params groupIcon 待插入分组图标
/// @params handleBlock 分组点击回调Block
/// @return 成功插入的自定义分组
- (YWEmoticonGroup *)addEmoticonGroupWithIcon:(UIImage *)groupIcon
                   withCustomizedHandleBlock:(YWEmoticonGroupCustomizedHandleBlock)handleBlock;


/// @brief 插入自定义响应处理分组，当该分组被点击调用handleBlock
/// @params groupIcon 待插入分组图标
/// @params index 插入位置索引
/// @params handleBlock 分组点击回调Block
/// @return 成功插入的自定义分组
- (YWEmoticonGroup *)insertEmoticonGroupWithIcon:(UIImage *)groupIcon
                                         atIndex:(NSUInteger)index
                       withCustomizedHandleBlock:(YWEmoticonGroupCustomizedHandleBlock)handleBlock;

/// @brief 移除表情分组
/// @params group 待插入分组
/// @return 是否成功移除
- (BOOL)removeEmoticonGroup:(YWEmoticonGroup *)group;

/// @brief 选择表情分组，选中自定义响应处理分组直接触发回调
/// @params group 待选择分组
/// @return 是否成功选择
- (BOOL)selecteEmoticonGroup:(YWEmoticonGroup *)group;

/// @brief 分组选择区域右侧允许放置自定义控件
/// @param rightMinorView 自定义控件
/// @param group 自定义控件在该分组被选中时显示
/// @return 是否成功放置
- (BOOL)setEmoticonGroupPickerRightMinorView:(UIView *)rightMinorView
                            forEmoticonGroup:(YWEmoticonGroup *)group;

@property (nonatomic, strong) UIColor *contentBackgroundColor;
@property (nonatomic, strong) UIColor *emoticonGroupSelectedBackgroundColor;
@property (nonatomic, strong) UIColor *emoticonGroupSeparatorColor;
/// 外部设置表情发送按钮。IMSDK会添加响应事件及修改frame
@property (nonatomic, strong) UIButton *rightMinorButtonForDefaultGroup;

@end
