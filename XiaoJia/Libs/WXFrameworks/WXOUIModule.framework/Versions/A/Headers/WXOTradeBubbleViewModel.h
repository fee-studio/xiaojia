//
//  PipeTradeBubbleViewModel.h
//  Messenger
//
//  Created by 慕桥(黄玉坤) on 12/8/14.
//
//

#import "YWBaseBubbleViewModel.h"
#import <WXOpenIMSDKFMWK/IYWConversationService.h>
#import "ActionNode.h"

@interface WXOTradeBubbleViewModel : YWBaseBubbleViewModel
@property (nonatomic, strong) NSString *content;

/// @brief 老数据需使用该接口转换成新协议
- (NSDictionary *)convertProtocol:(NSDictionary *)inputDict;
@end
