//
//  WXOTradeBubbleChatView.h
//  Messenger
//
//  Created by qinghua.liqh on 13-12-25.
//
//

#import "YWBaseBubbleChatView.h"

@interface WXOTradeBubbleChatView : YWBaseBubbleChatView
- (void)updateSellerOnlineStatus:(BOOL)isOnline;
- (NSString *)getContentSellerName;
@end
