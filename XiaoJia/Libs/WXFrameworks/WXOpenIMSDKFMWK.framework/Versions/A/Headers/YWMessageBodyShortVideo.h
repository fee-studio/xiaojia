//
//  YWMessageBodyShortVideo.h
//  WXOpenIMSDK
//
//  Created by sidian on 16/2/22.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import "YWMessageBody.h"
#import "YWMessageBodyImage.h"

// 只有链接了官方Demo中的ALBBMediaService.framework才能使用小视频消息.小视频存储要使用百川多媒体（顽兔）服务，请到百川云旺官网，并阅读短视频开通流程，完成短视频业务的多媒体空间绑定

typedef void(^YWGetShortVideoProgressBlock)(CGFloat progress);
typedef void(^YWGetShortVideoCompletionBlock)(NSURL *VideoUrl, NSError *aError);

@interface YWMessageBodyShortVideo : YWMessageBody

@property (nonatomic, strong, readonly) UIImage *frontImage;
@property (nonatomic, strong, readonly) NSURL *frontImageUrl;
@property (nonatomic, strong, readonly) NSData *data;
@property (nonatomic, strong, readonly) NSURL *videoUrl;
@property (nonatomic, assign, readonly) NSUInteger videoSize;
@property (nonatomic, assign, readonly) NSUInteger width;
@property (nonatomic, assign, readonly) NSUInteger height;
@property (nonatomic, assign, readonly) NSUInteger duration;
@property (nonatomic, copy, readonly) NSString *degradeText;

/// 初始化，使用这个接口发送短视频
/// @param data,视频数据
/// @param frontImage, 视频显示的封面图
/// @param width,视频宽度
/// @param height,视频高度
/// @param duration,持续时间
- (id)initWithMessageData:(NSData *)data
            andFrontImage:(UIImage *)frontImage
                    width:(NSUInteger)width
                   height:(NSUInteger)height
                 duration:(NSUInteger)duration;

/// 使用视频文件的url和首帧图像初始化
/// @param fileUrl，文件路径
- (id)initWithMessageVideoUrl:(NSURL *)videoUrl
                    videoSize:(NSUInteger)videoSize
                   frontImage:(UIImage *)frontImage
                        width:(NSUInteger)width
                       height:(NSUInteger)height
                     duration:(NSUInteger)duration;

/// 使用视频文件的url和首帧图像的url初始化
- (id)initWithMessageVideoUrl:(NSURL *)videoUrl
                    videoSize:(NSUInteger)videoSize
                frontImageUrl:(NSURL *)frontImageUrl
                        width:(NSUInteger)width
                       height:(NSUInteger)height
                     duration:(NSUInteger)duration;

- (void)asyncGetFrontImageWithProgress:(YWGetImageProgressBlock)progress
                            completion:(YWGetImageCompletionBlock)completion;

- (void)asyncGetVideoDataWithProgress:(YWGetShortVideoProgressBlock)progress
                           completion:(YWGetShortVideoCompletionBlock)completion;


@end
