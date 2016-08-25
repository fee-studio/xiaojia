//
//  WXOBoxMsgFlowBubbleViewModel.h
//  Messenger
//
//  Created by 慕桥(黄玉坤) on 12/8/14.
//
//

#import "YWBaseBubbleViewModel.h"
#import <WXOpenIMSDKFMWK/IYWConversationService.h>
#import "ActionNode.h"

@interface WXOBoxMsgFlowBubbleViewModel : YWBaseBubbleViewModel
- (id)initWithMessage:(id<IYWMessage>)message;
@property (nonatomic, strong) NSString *content;

@end
