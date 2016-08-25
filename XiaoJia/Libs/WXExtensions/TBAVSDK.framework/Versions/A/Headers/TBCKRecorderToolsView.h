//
//  TBCKRecorderToolsView.h
//  TBAVSDK
//
//  Created by 兵长 on 16/2/18.
//  Copyright © 2016年 Taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBCKRecorder.h"

@protocol TBCKRecorderToolsViewDelegate;

/*
视频录制时的辅助类，支持点击定焦，双指缩放操作。
*/
@interface TBCKRecorderToolsView : UIView
@property (nonatomic, weak) id<TBCKRecorderToolsViewDelegate> delegate;
//定焦的外框图片。默认不显示。
@property (nonatomic, strong) UIImage *outsideFocusTargetImage;
//定焦的内框图片。默认不显示
@property (nonatomic, strong) UIImage *insideFocusTargetImage;

//设置需要联动的播放器
- (void)setActionRecorder:(TBCKRecorder *)recoder;
@end

@protocol TBCKRecorderToolsViewDelegate <NSObject>
@optional
//点击定焦后的回调
- (void)recorderToolsView:(TBCKRecorderToolsView *)recorderToolsView didTapToFocusWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;
@end
