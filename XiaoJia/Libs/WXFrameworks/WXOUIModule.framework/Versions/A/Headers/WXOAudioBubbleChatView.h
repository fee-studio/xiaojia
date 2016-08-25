//
//  WXOAudioBubbleChatView.h
//  Messenger
//
//  Created by muqiao.hyk on 13-4-19.
//
//

#import "YWBaseBubbleChatView.h"


@interface WXOAudioBubbleChatView : YWBaseBubbleChatView<YWBaseBubbleChatViewInf>

- (void)playSoundAnimation;
- (void)stopSoundAnimation;
- (BOOL)isPlayingAnimation;

@end
