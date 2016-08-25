//
//  YWMessageBodyImage.h
//  
//
//  Created by huanglei on 14/12/11.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "YWMessageBody.h"

typedef void(^YWGetImageProgressBlock)(CGFloat progress);
typedef void(^YWGetImageCompletionBlock)(NSData *imageData, NSError *aError);


/**
 *  图片类型
 */
typedef NS_ENUM(NSUInteger, YWMessageBodyImageType){
    /**
     *  普通静态图片
     */
    YWMessageBodyImageTypeNormal,
    /**
     *  GIF 动态图片
     */
    YWMessageBodyImageTypeGIF
};


/**
 * 图片消息体
 */

@interface YWMessageBodyImage : YWMessageBody

/// 初始化，使用这个接口发送图片，图片会被本地压缩
- (instancetype)initWithMessageImage:(UIImage *)aMessageImage;

/// 使用ImageData初始化，客户端本地不压缩数据，尽量保持图片清晰度。（CDN服务器目前有固定的压缩策略）
/// @param aIsOriginal 如果设置为YES，则接收方会显示“查看原图”按钮
- (instancetype)initWithMessageImageData:(NSData *)data isOriginal:(BOOL)aIsOriginal;

/// 使用ImageData初始化，客户端本地不压缩数据，尽量保持图片清晰度。（CDN服务器目前有固定的压缩策略）
/// 调用上面的接口，aIsOriginal的值为YES
- (instancetype)initWithMessageImageData:(NSData *)data;

/**
 *  异步下载缩略图
 */
- (void)asyncGetThumbnailImageWithProgress:(YWGetImageProgressBlock)progress
                                completion:(YWGetImageCompletionBlock)completion;

/**
 *  异步下载大图
 */
- (void)asyncGetBigImageWithProgress:(YWGetImageProgressBlock)progress
                               completion:(YWGetImageCompletionBlock)completion;

/**
 *  异步下载原图
 */
- (void)asyncGetOriginalImageWithProgress:(YWGetImageProgressBlock)progress
                                completion:(YWGetImageCompletionBlock)completion;

/**
 *  缩略图尺寸
 */
@property (nonatomic, assign, readonly) CGSize thumbnailImageSize;

/**
 *  是否有原图
 */
@property (nonatomic, assign, readonly) BOOL hasOriginal;

/**
 *  是否已经下载了原图
 */
@property (nonatomic, assign, readonly) BOOL cachedOriginal;

/**
 *  如果有原图，则为原图尺寸。如果为0，则是没有原图或者没有原图尺寸信息。
 */
@property (nonatomic, assign, readonly) NSUInteger originalFileSize;


/**
 *  原始图片的类型，用于区分普通静态图片和 GIF 动态图片
 *  缩略图永远为静态图片
 */
@property (nonatomic, assign, readonly) YWMessageBodyImageType originalImageType;

@end
