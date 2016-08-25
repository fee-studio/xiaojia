//
//  YWRecordKit.h
//  WXOpenIMUIKit
//
//  Created by huanglei on 5/5/15.
//  Copyright (c) 2015 www.alibaba.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YWIMKit;
@class YWRecordKit;

@protocol YWRecordKitDelegate <NSObject>

/**
 *  完成录音的回调
 *  @param aData 录音数据
 *  @param aDuration 录音时长
 */
- (void)recordKit:(YWRecordKit *)aRecordKit didEndRecordWithData:(NSData *)aData duration:(NSTimeInterval)aDuration;

@optional

/**
 *  录音即将开始
 *
 *  @param aRecordKit 录音对象
 */
- (void)recordKitWillStartRecord:(YWRecordKit *)aRecordKit;

/**
 *  录音被取消
 *
 *  @param aRecordKit 录音对象
 */
- (void)recordKitDidCancel:(YWRecordKit *)aRecordKit;

/**
 *  音波强度
 *  @param aCurrentPercent 当前强度
 */
- (void)recordKit:(YWRecordKit *)aRecordKit voicePowerPercentDidUpdate:(CGFloat)aCurrentPercent;


@end


/**
 *  最长录音时长
 */
FOUNDATION_EXTERN NSTimeInterval const YW_MAX_RECORD_DURATION;

typedef NS_ENUM(NSUInteger, YWRecordViewState) {
    YWRecordViewStateNormal, /// 正常状态
    YWRecordViewStateTouchDown, /// 按下状态
};

@interface YWRecordKit : NSObject

- (id)initWithRecordViewFrame:(CGRect)aRecordViewFrame delegate:(id<YWRecordKitDelegate>)aDelegate __attribute__ ((deprecated));
- (id)initWithRecordViewFrame:(CGRect)aRecordViewFrame delegate:(id<YWRecordKitDelegate>)aDelegate andImkit:(YWIMKit *)aImkit;

/**
 *  TouchView，将这个View add到你自己的View上，用户可以通过长按这个view来控制录音
 */
@property (nonatomic, readonly) UIView *recordView;

@property (nonatomic, weak) YWIMKit *imkit;

/// 是否需要隐藏TouchLabel，TouchLabel根据按下状态显示不同文字。如果您的按钮区域比较狭小，则应该隐藏。
- (void)setTouchLabelHidden:(BOOL)aHidden;

/// 设置不同状态下的图片
- (void)setRecordViewImage:(UIImage *)aImage forState:(YWRecordViewState)aState;

/// 获取不同状态下的图片
- (UIImage *)recordViewImageForState:(YWRecordViewState)aState;

@end


/**
 *  您也可以只通过如下接口直接控制录音
 */

@interface YWRecordKit ()

@property (nonatomic, readonly) BOOL isRecording;

/**
 *  开始录音
 */
- (void)startRecord;

/**
 *  结束录音
 */
- (void)stopRecord;

/**
 *  取消录音
 */
- (void)cancelRecord;

@end
