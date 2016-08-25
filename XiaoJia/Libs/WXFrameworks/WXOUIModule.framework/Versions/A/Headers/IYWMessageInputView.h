//
//  IYWMessageInputView.h
//  WXOpenIMUIKit
//
//  Created by Jai Chen on 15/12/16.
//  Copyright © 2015年 www.alibaba.com. All rights reserved.
//

#ifndef IYWMessageInputView_h
#define IYWMessageInputView_h

#import <WXOpenIMSDKFMWK/YWConversationServiceDef.h>

@class YWMessageInputView;
@protocol YWMessageInputViewDelegate;

@protocol IYWMessageInputView <NSObject>

@required

/**
 *  文本输入控件中的文本内容
 */
@property (nonatomic, copy)   NSString *text;

/**
 *  文本输入控件中的文本选中范围
 */
@property (nonatomic, assign) NSRange selectedRange;

/**
 *  委托对象
 */
@property (nonatomic, weak) id<YWMessageInputViewDelegate> messageInputViewDelegate;


@optional

/**
 *  开始监听系统键盘通知
 */
- (void)beginListeningForKeyboard;

/**
 *  结束监听系统键盘通知
 */
- (void)endListeningForKeyboard;

@end

@protocol YWMessageInputViewDelegate <NSObject>
@optional

/// 输入框相关
/**
 *  输入框是否应该开始编辑状态
 */
- (BOOL)messageInputViewShouldBeginEditing:(UIView<IYWMessageInputView> *)inputView;

/**
 *  输入框是否应该结束编辑状态
 */
- (BOOL)messageInputViewShouldEndEditing:(UIView<IYWMessageInputView> *)inputView;

/**
 *  输入框中的文本发生变化
 */
- (void)messageInputViewTextDidChange:(UIView<IYWMessageInputView> *)inputView;

/**
 *  是否允许文本框替换文本
 */
- (BOOL)messageInputView:(UIView<IYWMessageInputView> *)inputView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;


/// 高度变化相关
/**
 *  输入栏高度发生变更
 */
- (void)messageInputView:(UIView<IYWMessageInputView> *)inputView heightOfBarDidChange:(CGFloat)height;

/**
 *  输入栏底部区域高度发生变更，如键盘高度或插件面板高度发生变更
 */
- (void)messageInputView:(UIView<IYWMessageInputView> *)inputView heightOfKeyboardDidChange:(CGFloat)height;

/**
 *  是否发送文本消息，如果返回NO，则不会发送
 */
- (BOOL)messageInputView:(UIView<IYWMessageInputView> *)inputView shouldSendText:(NSString *)text;

@end

#endif /* IYWMessageInputView_h */
