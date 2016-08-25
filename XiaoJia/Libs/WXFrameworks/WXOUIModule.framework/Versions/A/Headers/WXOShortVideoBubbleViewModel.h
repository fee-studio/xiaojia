//
//  WXOShortVideoBubbleViewModel.h
//  WXOpenIMUIKit
//
//  Created by sidian on 16/2/26.
//  Copyright © 2016年 www.alibaba.com. All rights reserved.
//

#import "YWBaseBubbleViewModel.h"
#import <WXOpenIMSDKFMWK/IYWMessage.h>
#import <WXOpenIMSDKFMWK/YWMessageBodyImage.h>
#import <WXOpenIMSDKFMWK/YWMessageBodyShortVideo.h>

typedef NS_ENUM(NSInteger, WXOVideoBubbleMaskMode) {
    WXOVideoBubbleMaskModePlayButton,            //播放按钮
    WXOVideoBubbleMaskModeProgress,             //进度条
};

typedef void (^WXOVideoBubbleAsk2PlayBlock) (UIView *aFromView);

@interface WXOShortVideoBubbleViewModel : YWBaseBubbleViewModel

@property (nonatomic,   copy) WXOVideoBubbleAsk2PlayBlock ask2PlayBlock;
- (void)setAsk2PreviewBlock:(WXOVideoBubbleAsk2PlayBlock)ask2PreviewBlock;

typedef void (^WillPlayVideoFullScreenBlock)(void);
@property (nonatomic, copy) WillPlayVideoFullScreenBlock willPlayVideoBlock;

- (NSUInteger)getVideoFileSize;
- (CGSize)getVideoSize;

- (WXOVideoBubbleMaskMode)getMaskMode;

- (void)asyncGetFrontImageWithProgress:(YWGetImageProgressBlock)progress
                            completion:(YWGetImageCompletionBlock)completion;

- (void)asyncGetVideoDataWithProgress:(YWGetShortVideoProgressBlock)progress
                           completion:(YWGetShortVideoCompletionBlock)completion;

@end
