//
//  YWFeedbackViewController.h
//  WXOpenIMUIKit
//
//  Created by 慕桥(黄玉坤) on 15/12/21.
//  Copyright © 2015年 www.alibaba.com. All rights reserved.
//

#import <WXOUIModule/YWConversationViewController.h>

@interface YWFeedbackViewController : YWConversationViewController

/**
 *  创建消息列表Controller
 *  @param aIMKit IMKit对象
 *  @param aConversation 会话对象
 */
+ (instancetype)makeControllerWithIMKit:(YWIMKit *)aIMKit conversation:(YWConversation *)aConversation;
@end

/// 联系方式输入相关属性
@interface YWFeedbackViewController(ContactInfo)
/// 设置反馈用户联系方式，用于反馈界面展示。
@property (nonatomic, strong) NSString *contactInfo;

/// 隐藏联系方式提醒条，默认显示。联系方式必须输入时无法隐藏。
@property (nonatomic, assign) BOOL hideContactInfoView;
@end
