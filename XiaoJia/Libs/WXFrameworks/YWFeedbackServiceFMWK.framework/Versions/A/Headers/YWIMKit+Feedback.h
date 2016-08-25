//
//  YWIMKit+Feedback.h
//  YWFeedbackService
//
//  Created by 慕桥(黄玉坤) on 16/1/25.
//  Copyright © 2016年 www.akkun.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXOUIModule/YWIMKit.h>

@class YWFeedbackViewController;

@interface YWIMKit(Feedback)
/**
 *  创建反馈页面
 *  @brief 如果尚未连接到服务器，首先会连接到服务器。使用匿名方式反馈。
 *  @param conversation 反馈会话的Conversation对象，
 *  @return 反馈页面
 */
- (YWFeedbackViewController *)makeFeedbackViewControllerWithConversation:(YWFeedbackConversation *)conversation;
@end
