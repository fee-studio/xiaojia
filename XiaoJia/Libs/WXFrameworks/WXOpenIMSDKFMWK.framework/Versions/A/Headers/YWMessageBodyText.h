//
//  YWMessageBodyText.h
//  
//
//  Created by huanglei on 14/12/11.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "YWMessageBody.h"

/**
 * 文本消息体
 */

@interface YWMessageBodyText : YWMessageBody

/// 初始化
- (instancetype)initWithMessageText:(NSString *)aMessageText;

/// 消息内容
@property (nonatomic, copy, readonly) NSString *messageText;

@end



@interface YWMessageBodyText (TribeAtMessage)

/**
 *  初始化
 *
 *  @param aMessageText 文本体内容
 *  @param isAtAll      是否是@all的消息
 *  @param atMembers    @群成员列表，YWTribeMember object in atMembers
 * 
 *  当isAtAll == YES时，会忽略传入的atMembers具体的成员列表，按照群当时的群成员来处理
 *  当isAtAll == NO时，atMembers会被作为是具体的@成员列表
 *  当isAtAll == NO,且atMembers为空或者数量为0时，跟普通的文本消息体无区别
 *
 *  @return YWMessageBodyText 对象
 */
- (instancetype)initWithMessageText:(NSString *)aMessageText andAtFlag:(BOOL)isAtAll andAtMembers:(NSArray *)atMembers;

/**
 *  是否是@自己的消息,是返回YES,否则返回NO
 */
@property (nonatomic, assign, readonly) BOOL isAtMe;
/**
 *  是否是自己@别人的消息，是返回YES,否则返回NO
 */
@property (nonatomic, assign, readonly) BOOL isMySelfAtOther;

/**
 *  如果是@别人的消息，记录@的人数，否则返回0
 */
@property (nonatomic, assign, readonly) short atCount;
/**
 *  如果是@别人的消息，在@的人数里面，有多少人未读，否则返回0
 *  如果是@自己的消息，未读返回1，否则返回0
 */
@property (nonatomic, assign, readonly) short unreadCountForAtMessage;

/**
 *  是否是@all的消息
 */
@property (nonatomic, assign, readonly) BOOL isAtAll;
/**
 *  @的群成员列表， 可能为nil
 *  YWTribeMember object in atMembers
 */
@property (nonatomic, copy, readonly) NSArray *atMembers;

@end