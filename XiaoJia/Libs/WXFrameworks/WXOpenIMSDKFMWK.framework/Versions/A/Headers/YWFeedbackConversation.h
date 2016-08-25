//
//  YWFeedbackConversation.h
//  WXOpenIMUIKit
//
//  Created by 慕桥(黄玉坤) on 15/12/21.
//  Copyright © 2015年 www.alibaba.com. All rights reserved.
//

#import "YWP2PConversation.h"

@interface YWFeedbackConversation : YWP2PConversation
/**
 *  获取某个单聊会话
 *  @param WXOPerson 会话对象
 *  @param aCreateIfNotExist 如果还不存在，则创建会话
 *  @param aBaseContext 用户环境上下文
 *  @param extInfo 用户自定义扩展信息
 *  @return 需要获取的会话。如果本地不存在该会话且不需要新建，则返回nil
 */
+ (instancetype)fetchConversationByPerson:(YWPerson *)person
                          creatIfNotExist:(BOOL)aCreateIfNotExist
                              baseContext:(YWIMCore *)aBaseContext
                                  extInfo:(NSDictionary *)extInfo;

/// 当前会话是否绑定了客服账号
- (BOOL)isCustomerServiceBinded;
@end
