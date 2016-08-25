//
//  WXOAudioBubbleViewModel.h
//  Messenger
//
//  Created by 慕桥(黄玉坤) on 12/1/14.
//
//

#import <Foundation/Foundation.h>
#import "YWBaseBubbleViewModel.h"
#import "WXOAudioBubbleChatView.h"

@class WXOAudioBubbleViewModel;

typedef void (^WXOAudioBubbleBlock) (WXOAudioBubbleChatView *bubbleView);
typedef BOOL (^WXOAudioBubbleIsPlayingBlock)(WXOAudioBubbleViewModel *aViewModel);

@interface WXOAudioBubbleViewModel : YWBaseBubbleViewModel

// 语音时长
@property (nonatomic, assign) NSUInteger duration;
@property (nonatomic, strong) NSString *audioUrl;

@property (nonatomic,   copy) WXOAudioBubbleBlock ask4PlayBlock;
@property (nonatomic,   copy) WXOAudioBubbleBlock ask4StopBlock;

- (void)setAsk4PlayBlock:(WXOAudioBubbleBlock)ask4PlayBlock;
- (void)setAsk4StopBlock:(WXOAudioBubbleBlock)ask4StopBlock;

@property (nonatomic,   copy) WXOAudioBubbleIsPlayingBlock ask4IsPlayingBlock;
- (void)setAsk4IsPlayingBlock:(WXOAudioBubbleIsPlayingBlock)ask4IsPlayingBlock;

@end
