//
//  YWMessageBodyP2PInfos.h
//  WXOpenIMSDK
//
//  Created by sidian on 15/10/8.
//  Copyright © 2015年 taobao. All rights reserved.
//

#import "YWMessageBody.h"

/// P2P焦点消息,可以用来发送宝贝焦点或者交易焦点
@interface YWMessageBodyP2PInfos : YWMessageBody

/// 初始化,宝贝焦点
- (instancetype)initWithItemId:(NSString *)itemId;

/// 宝贝ID
@property (nonatomic, copy, readonly) NSString *itemId;

/// 初始化,交易焦点
- (instancetype)initWithTradeId:(NSString *)tradeId;

/// 宝贝ID
@property (nonatomic, copy, readonly) NSString *tradeId;

@end
