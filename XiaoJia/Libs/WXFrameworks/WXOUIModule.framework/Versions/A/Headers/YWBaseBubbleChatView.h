//
//  YWBaseBubbleChatView.h
//  Messenger
//
//  Created by muqiao.hyk on 13-4-19.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 说明：消息气泡基类谨慎修改，修改后请联系慕桥Review。

typedef enum _BubbleStyle{
    
    /// 不显示
    BubbleStyleNone,
    
    /// 文本、语音等普通气泡样式
    BubbleStyleCommonLeft,      // 左侧气泡样式
    BubbleStyleCommonMiddle,    // 居中气泡样式
    BubbleStyleCommonRight,     // 右侧气泡样式
    
    /// 图片、地理位置等气泡中间镂空样式
    BubbleStyleHollowLeft,      // 左侧气泡样式
    BubbleStyleHollowMiddle,    // 居中气泡样式
    BubbleStyleHollowRight,     // 右侧气泡样式
    
    /// 系统通知等弱提示消息样式
    BubbleStyleHintMiddle,      // 居中气泡样式
    
    // 自定义气泡风格
    BubbleStyleCustomize,
}BubbleStyle;

/**
 *  开发者的自定义YWBaseBubbleChatView需要实现这个协议
 */
@protocol YWBaseBubbleChatViewInf <NSObject>
@required
/// 内容区域大小
- (CGSize)getBubbleContentSize;
/// 需要刷新BubbleView时会被调用
- (void)updateBubbleView;
@optional
// 返回所持ViewModel类名，用于类型检测
- (NSString *)viewModelClassName;
@end

@class YWBaseBubbleViewModel;
@class YWBaseBubbleChatView;

@interface YWBaseBubbleChatView : UIView<YWBaseBubbleChatViewInf>

/// 是否需要强制更新
@property (nonatomic, assign, readonly) BOOL forceLayout;
/// 设置强制更新
- (void)setForceLayout:(BOOL)forceLayout;

/// 是否高亮
@property (nonatomic, assign, readonly) BOOL highLight;
/// 设置高亮
- (void)setHighLight:(BOOL)highLight;

// 背景视图
@property (nonatomic, strong) UIImageView* imageViewBG;
@property (nonatomic, assign) UIEdgeInsets edgeInsets4BG;
@property (nonatomic, assign) BOOL overlayContent;

/// 对应的ViewModel
@property (nonatomic, strong) YWBaseBubbleViewModel *viewModel;

/// 计算Bubble大小
- (CGSize)getBubbleViewSize;

/// 缓存复用前调用该函数
- (void)prepareForReuse;

typedef void (^BBVAsk4LayoutBlock) (YWBaseBubbleChatView *bubbleView);
@property (nonatomic, copy) BBVAsk4LayoutBlock ask4LayoutBlock;
- (void)setAsk4LayoutBlock:(BBVAsk4LayoutBlock)ask4LayoutBlock;
@end

@interface YWBaseBubbleChatView (CustomBubbleRect)

/// 设置头像与气泡的间距
+ (void)setBubbleAvatarOffset:(CGFloat)aBubbleAvatarOffset;
+ (CGFloat)bubbleAvatarOffset;

/// 设置居中气泡的最小边距
+ (void)setCenterBubbleMinMarginX:(CGFloat)aMinMarginX;
+ (CGFloat)centerBubbleMinMarginX;

/// 强制隐藏未读label。如果需要隐藏，子类中返回@(YES)
- (NSNumber *)forceHideUnreadLabel;

@end

@interface YWBaseBubbleChatView(PlaceBaseBubbleStyle)
// 是否应该被居中放置
+ (BOOL)shouldBePlacedCentrally:(BubbleStyle)bubbleStyle;
// 是否应该靠左放置
+ (BOOL)shouldBePlacedLeftSide:(BubbleStyle)bubbleStyle;

// 是否应该被居中放置
- (BOOL)shouldBePlacedCentrally;
// 是否应该靠左放置
- (BOOL)shouldBePlacedLeftSide;
@end

@interface YWBaseBubbleChatView(SmartScale)
// 当前设备上气泡可用最大布局宽度
+ (CGFloat)maxWidthUsedForLayout;
+ (void)setMaxWidthUsedForLayout:(CGFloat)width;
@end


/**
 *  兼容历史BubbleStyle定义，请使用最新的定义，后续作废处理。
 */

/// 内容在下层的样式，居左
#define BubbleStyleCoverLeft    BubbleStyleHollowLeft
/// 内容在下层的样式，居中
#define BubbleStyleCoverMid     BubbleStyleHollowMiddle
/// 内容在下层的样式，居右
#define BubbleStyleCoverRight   BubbleStyleCommonRight

/// 内容在上层的样式，居左
#define BubbleStyleFlatLeft     BubbleStyleCommonLeft
/// 内容在上层的样式，居中
#define BubbleStyleFlatMid      BubbleStyleCommonMiddle
/// 内容在上层的样式，居右
#define BubbleStyleFlatRight    BubbleStyleCommonRight

/// 凹陷样式，用于居中显示系统消息
#define BubbleStyleDepressMid   BubbleStyleHintMiddle
