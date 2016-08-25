//
//  WXOTextBubbleViewModel.h
//  Messenger
//
//  Created by 慕桥(黄玉坤) on 12/1/14.
//
//

#import <Foundation/Foundation.h>
#import "YWBaseBubbleViewModel.h"

@protocol WXOTextBubbleVMDelegate <NSObject>

// 是否插入信息面板
- (BOOL)shouldShowDetail4Link:(NSString *)linkUrl asyncReturnBlock:(void (^)(BOOL))returnBlock;

// 信息面板尺寸
- (CGSize)detailViewSize4Link:(NSString *)linkUrl;

// 信息面板
- (UIView *)detailView4Link:(NSString *)linkUrl;

@end

@interface WXOTextBubbleViewModel : YWBaseBubbleViewModel

// 文本内容
@property (nonatomic, strong) NSString *content;

#pragma mark - 链接处理
// 是否高亮链接
- (BOOL)shouldFollowLink:(NSString *)linkUrl;

typedef void (^WXOTextBubbleAsk2OpenUrl) (NSString *linkUrl);
@property (nonatomic, copy) WXOTextBubbleAsk2OpenUrl ask2OpenUrl;
- (void)setAsk2OpenUrl:(WXOTextBubbleAsk2OpenUrl)ask2OpenUrl;

typedef void (^WXOTextBubbleDoubleClickBlock) (NSString *content, BOOL leftAlign);
@property (nonatomic, copy) WXOTextBubbleDoubleClickBlock doublClickBlock;
- (void)setDoublClickBlock:(WXOTextBubbleDoubleClickBlock)doublClickBlock;

#pragma mark - 信息面板
/// 为宝贝、店铺等特定链接插入信息面板
@property (nonatomic, weak) id<WXOTextBubbleVMDelegate> delegate;
@end
