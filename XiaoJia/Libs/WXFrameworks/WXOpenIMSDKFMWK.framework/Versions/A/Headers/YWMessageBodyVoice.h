//
//  YWMessageBodyVoice.h
//  
//
//  Created by huanglei on 14/12/11.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "YWMessageBody.h"

/**
 *  音频下载进度回调
 */
typedef void(^YWGetVoiceProgressBlock)(CGFloat progress);

/**
 *  音频下载结束的回调
 *  @param data 音频数据；wav格式
 */
typedef void(^YWGetVoiceCompletionBlock)(NSData *data, NSError *aError);

/**
 * 语音消息体
 */

@interface YWMessageBodyVoice : YWMessageBody

/// 初始化，amr格式
- (instancetype)initWithMessageVoiceData:(NSData *)voiceData duration:(NSTimeInterval)aDuration;

/// 音频时长
@property (nonatomic, assign, readonly) NSTimeInterval messageVoiceDuration;

/**
 *  异步下载音频数据
 *  @param progress 下载进度回调
 *  @param completion 下载结束回调
 */
- (void)asyncGetVoiceDataWithProgress:(YWGetVoiceProgressBlock)progress
                           completion:(YWGetVoiceCompletionBlock)completion;
@end
