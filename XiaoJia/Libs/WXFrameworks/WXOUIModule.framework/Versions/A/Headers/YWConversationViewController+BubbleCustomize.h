//
//  YWConversationViewController+BubbleCustomize.h
//  WXOpenIMUIKit
//
//  Created by 慕桥(黄玉坤) on 2/8/15.
//  Copyright (c) 2015 www.alibaba.com. All rights reserved.
//

#ifndef WXOpenIMUIKit_WXOConversationViewController_BubbleCustomize_h
#define WXOpenIMUIKit_WXOConversationViewController_BubbleCustomize_h

#import "YWConversationViewController.h"

@protocol YWLinkDetailDelegate;

@protocol IYWMessage;
@class YWBaseBubbleViewModel;
@class YWBaseBubbleChatView;

/**
 *  开发者可以对某些消息的显示进行自定义
 *  如果需要自定义这个message，则首先需要返回对应的自定义YWBaseBubbleViewModel子类
 *  YWBaseBubbleViewModel的子类为bubbleView的显示提供了数据model
 *  如果不需要自定义，则返回nil
 */
typedef YWBaseBubbleViewModel * (^BubbleViewModelHookBlock) (id<IYWMessage> message);

/**
 *  开发者可以对某些消息的显示进行自定义
 *  开发者可以对自定义的YWBaseBubbleViewModel子类，返回自定义的YWBaseBubbleChatView子类，用于显示
 */
typedef YWBaseBubbleChatView * (^BubbleViewHookBlock) (YWBaseBubbleViewModel * message);

/**
 *  BubbleView首次使用或复用前回调以供开发者做处理
 */
typedef void (^BubbleViewModelPrepare4UseBlock) (YWBaseBubbleViewModel * viewModel);

/**
 *  BubbleView首次使用或复用前回调以供开发者做处理
 */
typedef void (^BubbleViewPrepare4UseBlock) (YWBaseBubbleChatView * bubbleView);


@interface YWConversationViewController(BubbleCustomize)

#pragma mark - 消息气泡

/**
 *  自定义消息的ViewModel
 */
@property (nonatomic, copy, readonly) BubbleViewModelHookBlock hook4BubbleViewModel;
/**
 *  自定义消息的ViewModel
 */
- (void)setHook4BubbleViewModel:(BubbleViewModelHookBlock)hook4BubbleViewModel;

/**
 *  自定义消息的BubbleView
 */
@property (nonatomic, copy, readonly) BubbleViewHookBlock hook4BubbleView;
/**
 *  自定义消息的BubbleView
 */
- (void)setHook4BubbleView:(BubbleViewHookBlock)hook4BubbleView;

/**
 *  BubbleViewModel首次使用或复用前回调
 */
@property (nonatomic, copy, readonly) BubbleViewModelPrepare4UseBlock hook4BubbleViewModelPrepare4Use;
/**
 *  BubbleViewModel首次使用或复用前回调
 */
- (void)setHook4BubbleViewModelPrepare4Use:(BubbleViewModelPrepare4UseBlock)hook4BubbleViewModelPrepare4Use;

/**
 *  BubbleView首次使用或复用前回调
 */
@property (nonatomic, copy, readonly) BubbleViewPrepare4UseBlock hook4BubbleViewPrepare4Use;
/**
 *  BubbleView首次使用或复用前回调
 */
- (void)setHook4BubbleViewPrepare4Use:(BubbleViewPrepare4UseBlock)hook4BubbleViewPrepare4Use;

#pragma mark - 文本消息插入链接详情面板代理
/**
 *  自定义链接的展示
 */
@property (nonatomic, weak, readonly) id<YWLinkDetailDelegate> delegate4LinkDetail;
/**
 *  自定义链接的展示
 */
- (void)setDelegate4LinkDetail:(id<YWLinkDetailDelegate>)delegate4LinkDetail;

@end

#pragma mark - 文本消息插入链接详情面板回调

@protocol YWLinkDetailDelegate <NSObject>

/// 是否插入信息面板
/// 如果可以直接判断出是否需要显示信息卡片，直接返回结果；否则可以先返回NO，然后在returnBlock中返回异步判断后的结果
- (BOOL)conversationViewController:(YWConversationViewController *)conversationViewController
             shouldShowDetail4Link:(NSString *)linkUrl
                  asyncReturnBlock:(void (^)(BOOL))returnBlock;

/// 信息面板尺寸
- (CGSize)conversationViewController:(YWConversationViewController *)conversationViewController
                 detailViewSize4Link:(NSString *)linkUrl;

/// 信息面板
- (UIView *)conversationViewController:(YWConversationViewController *)conversationViewController
                       detailView4Link:(NSString *)linkUrl;

@end

#endif
