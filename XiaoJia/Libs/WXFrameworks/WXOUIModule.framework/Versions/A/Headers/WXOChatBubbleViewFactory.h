//
//  WXOChatBubbleViewFactory.h
//  Messenger
//
//  Created by muqiao.hyk on 13-4-19.
//
//

#import <Foundation/Foundation.h>
#import <WXOpenIMSDKFMWK/IYWConversationService.h>
#import "YWBaseBubbleChatView.h"

@interface WXOChatBubbleViewFactory : NSObject
+ (YWBaseBubbleChatView *)bubbleViewWithViewModel:(YWBaseBubbleViewModel *)viewModel;
@end
