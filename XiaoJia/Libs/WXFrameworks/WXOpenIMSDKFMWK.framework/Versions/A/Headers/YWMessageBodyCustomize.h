//
//  YWMessageBodyCustomize.h
//  
//
//  Created by 慕桥(黄玉坤) on 1/15/15.
//  Copyright (c) 2015 taobao. All rights reserved.
//

#import "YWMessageBody.h"

@interface YWMessageBodyCustomize : YWMessageBody

/**
 *  自定义数据，您应该组织您的数据格式，将其放入content字段中。
 *  请注意长度应该越短越好，有利于消息更快的加载和展示，也有利于节省流量。
 *  您应该尽量只放置元数据，例如图片的url等，而不是直接将图片之类的大数据放入content中。
 *  最长限制受服务端控制。您应该尽量控制在1KB以内。
 */
@property (nonatomic, strong, readonly) NSString *content;

/// 推送穿透内容。summary会显示在push提示或者会话最后消息穿透中。
@property (nonatomic, strong, readonly) NSString *summary;

/// 透传消息：这种消息不会有apns推送，并且对方接收到以后，也不会修改会话，仅通过-[IYWConversationService addOnNewMessageBlockV2:forKey:ofPriority:]
@property (nonatomic, assign) BOOL isTransparent;

/// 初始化
- (instancetype)initWithMessageCustomizeContent:(NSString *)content summary:(NSString *)summary;
- (instancetype)initWithMessageCustomizeContent:(NSString *)content summary:(NSString *)summary isTransparent:(BOOL)aIsTransparent;
@end
