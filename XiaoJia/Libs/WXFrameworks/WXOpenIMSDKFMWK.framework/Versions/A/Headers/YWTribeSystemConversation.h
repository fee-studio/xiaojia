//
//  YWTribeSystemConversation.h
//  WXOpenIMSDK
//
//  Created by Jai Chen on 15/10/21.
//  Copyright © 2015年 taobao. All rights reserved.
//

#import "YWConversation.h"

@interface YWTribeSystemConversation : YWConversation

+ (instancetype)fetchConversationCreatIfNotExist:(BOOL)aCreateIfNotExist baseContext:(YWIMCore *)imCore;

+ (instancetype)fetchConversationByConversationId:(NSString *)aConversationId creatIfNotExist:(BOOL)aCreateIfNotExist baseContext:(YWIMCore *)aBaseContext __attribute__((unavailable));

- (void)asyncSendMessageBody:(YWMessageBody *)aMessageBody
                    progress:(YWMessageSendingProgressBlock)aProgress
                  completion:(YWMessageSendingCompletionBlock)aCompletion __attribute__((unavailable));

- (void)asyncResendMessage:(id<IYWMessage>)aMessage
                  progress:(YWMessageSendingProgressBlock)aProgress
                completion:(YWMessageSendingCompletionBlock)aCompletion __attribute__((unavailable));

- (void)asyncForwardMessage:(id<IYWMessage>)aMessage
                   progress:(YWMessageSendingProgressBlock)aProgress
                 completion:(YWMessageSendingCompletionBlock)aCompletion __attribute__((unavailable));


- (id<IYWMessage>)fetchMessageWithMessageId:(NSString *)aMessageId __attribute__((unavailable));
- (void)removeMessageWithMessageId:(NSString *)aMessageId __attribute__((unavailable));
- (void)markMessageAsReadWithMessageIds:(NSArray *)messageIds __attribute__((unavailable));

@property (nonatomic, strong) NSArray *supportedMessageTypes;

@end
