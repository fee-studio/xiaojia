//
//  YWBaseBubbleViewModel.h
//  Messenger
//
//  Created by 慕桥(黄玉坤) on 12/3/14.
//
//

#import <Foundation/Foundation.h>
#import "YWBaseBubbleChatView.h"
#import "YWIMKit.h"

@interface YWBaseBubbleViewModel : NSObject
{
    NSUInteger _layout;
    NSData *_backgroundImage;
    NSData *_highLightBGImage;
    
    UIImage *_normalBackgroundImage;
    UIImage *_highLightBackgroundImage;
    
    UIEdgeInsets _contentEdgeInsets;
    BOOL _overlayContent;
}

/// 期望展示的气泡样式
@property (nonatomic, assign) BubbleStyle bubbleStyle;

/// 消息内容供应方，用于显示“消息来源”
@property (nonatomic, strong) NSString *ownerName;

/// 消息长按后弹出菜单项 @[UIMenuItem,...]。你的ViewModel中需要实现这些UIMenuItem的Selector。
@property (nonatomic, strong) NSArray *menuItems;

/// ViewModel对应的bubbleView
@property (nonatomic, weak) YWBaseBubbleChatView *bubbleView;

/// 缓存复用前调用该函数
- (void)prepareForReuse;

@end

/**
 *  气泡的布局
 */
typedef enum : NSUInteger {
    /// 居中
    WXOBubbleLayoutCenter,
    /// 居左
    WXOBubbleLayoutLeft,
    /// 居右
    WXOBubbleLayoutRight,
} WXOBubbleLayout;

/**
 *  如果BubbleStyle等于BubbleStyleCustomize时，你可以通过设置以下属性，来控制气泡的自定义显示
 */
@interface YWBaseBubbleViewModel(Customize)
/// 自定义气泡的布局方式(左|中|右)
@property (nonatomic, assign) WXOBubbleLayout layout;

/// 自定义气泡背景
@property (nonatomic, strong) UIImage *normalBackgroundImage;

/// 自定义高亮气泡背景
@property (nonatomic, strong) UIImage *highLightBackgroundImage;

/// 气泡背景覆盖内容之上作为遮罩使用
@property (nonatomic, assign) BOOL overlayContent;

/// 气泡内容边距(与背景外框间距)
@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;

@end

@interface YWBaseBubbleViewModel(Deprecated)
/// 自定义气泡背景
@property (nonatomic, strong) NSData *backgroundImage __attribute__((deprecated("请使用normalBackgroundImage")));

/// 自定义高亮气泡背景
@property (nonatomic, strong) NSData *highLightBGImage __attribute__((deprecated("请使用highLightBackgroundImage")));
@end