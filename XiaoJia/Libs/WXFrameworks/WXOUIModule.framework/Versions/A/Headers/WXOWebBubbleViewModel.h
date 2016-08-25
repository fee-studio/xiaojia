//
//  WXOWebBubbleViewModel.h
//  Messenger
//
//  Created by 慕桥(黄玉坤) on 12/5/14.
//
//

#import "YWBaseBubbleViewModel.h"

typedef enum : NSUInteger {
    WB_ContentType_URL      = 1,
    WB_ContentType_HTML,
} WB_ContentType;

@interface WXOWebBubbleViewModel : YWBaseBubbleViewModel<UIWebViewDelegate>
// 数据类型 url地址或html文本
@property (nonatomic, assign) WB_ContentType contentType;

// 数据内容
@property (nonatomic, strong) NSString *content;

// WebView优化频繁Reload，该参数控制重新加载
@property (nonatomic, assign) BOOL forceReloadUrl;

typedef void (^WXOWebBubbleAsk2OpenBlock) (NSString *url);
@property (nonatomic,   copy) WXOWebBubbleAsk2OpenBlock ask2OpenBlock;

typedef void (^WXOWebBubbleLoadStartedBlock) (NSString *url);
@property (nonatomic,   copy) WXOWebBubbleLoadStartedBlock startedBlock;

typedef void (^WXOWebBubbleLoadDoneBlock) (NSString *url, NSError *error);
@property (nonatomic,   copy) WXOWebBubbleLoadDoneBlock doneBlock;

- (void)setAsk2OpenBlock:(WXOWebBubbleAsk2OpenBlock)ask2OpenBlock;
- (void)setStartedBlock:(WXOWebBubbleLoadStartedBlock)startedBlock;
- (void)setDoneBlock:(WXOWebBubbleLoadDoneBlock)doneBlock;
@end
