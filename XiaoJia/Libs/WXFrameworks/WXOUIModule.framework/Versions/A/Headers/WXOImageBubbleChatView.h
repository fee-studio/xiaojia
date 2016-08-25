//
//  WXOImageBubbleChatView.h
//  Messenger
//
//  Created by muqiao.hyk on 13-4-19.
//
//

#import "YWBaseBubbleChatView.h"

@class WXOCircularProgressView;

@interface WXOImageBubbleChatView : YWBaseBubbleChatView<YWBaseBubbleChatViewInf>
@property (nonatomic, strong, readonly) WXOCircularProgressView *progressView;
- (void)setProgressViewHidden:(BOOL)aHidden;
- (void)setProgress:(CGFloat)aProgress;

@property (nonatomic, strong) UIImageView *msgImageView;
@property (nonatomic, assign) BOOL showMask;

@end