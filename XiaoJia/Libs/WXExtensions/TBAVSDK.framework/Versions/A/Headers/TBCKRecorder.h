//
//  TBCKRecorder.h
//  TBAVSDK
//
//  Created by 兵长 on 16/2/17.
//  Copyright © 2016年 Taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "TBCKRecordSegment.h"

typedef NS_ENUM(NSInteger, TBCKFlashMode) {
    TBCKFlashModeOff  = AVCaptureFlashModeOff,
    TBCKFlashModeOn   = AVCaptureFlashModeOn,
    TBCKFlashModeAuto = AVCaptureFlashModeAuto,
    TBCKFlashModeLight//电筒模式，闪光灯常亮
};

@protocol TBCKRecorderDelegate;

/*
 视频录制类。支持分段录制与删除
 */
@interface TBCKRecorder : NSObject

@property (nonatomic, weak) id<TBCKRecorderDelegate>  delegate;

//视频拍摄预览的视图.
@property (nonatomic, strong) UIView * previewView;

//视频的尺寸。默认按previewView的宽高比输出，并且尽可能清晰。
@property (nonatomic, assign) CGSize size;

//视频的码率。默认为2000000
@property (nonatomic, assign) UInt64 bitrate;

//视频的帧率。默认为35
@property (nonatomic, assign) Float64 frameRate;

//允许的录制时长上限。当视频录制时长达到该上限时，自动停止录制，并调用 recorderDidCompleteSession: 回调。默认无限大。
@property (nonatomic, assign) CMTime maxRecordDuration;

//已录制的视频总时长，包括当前正在录制的部分
@property (nonatomic, readonly) CMTime duration;

//切换闪关灯模式
@property (nonatomic, assign) TBCKFlashMode flashMode;

//切换前后摄像头
@property (nonatomic, assign) AVCaptureDevicePosition device;

//输出的文件格式。默认 AVFileTypeMPEG4。
@property (nonatomic, strong) NSString * fileType;


//初始化
- (id)init;

//开始录制
- (void)startRecording;

//结束录制
- (void)stopRecording;
- (void)stopRecording:(void(^)()) handle;

//开始摄像头采集显示，一般在viewDidAppear中调用
- (BOOL)startPreview;

//结束摄像头采集显示，一般在viewWillDisappear中调用。
- (void)stopPreview;

//切换前后摄像头
- (void)switchCaptureDevices;

//输出的asset，若有多段则自动合并
- (void)composeSegments:(void(^)(AVAsset *asset))completionHandler;

@end


@interface TBCKRecorder (TBCKRecorderSegment)
//当前录制的片段时长
@property (nonatomic, readonly) CMTime curSegmentsDuration;

//录制的片段数组（TBCKRecordSegment），不包含当前正在录制的部分
@property (nonatomic, readonly) NSMutableArray *segments;

//删除最后一段视频（同时删除文件）
- (void)removeLastSegment;

//删除所有视频片段（同时删除文件）
- (void)removeAllSegments;
@end



@protocol TBCKRecorderDelegate <NSObject>

@optional
//开始录制一段视频
- (void)recorderDidBeginSegment:(TBCKRecorder *)recorder;

//录制完一段视频
- (void)recorder:(TBCKRecorder *)recorder didCompleteSegment:(TBCKRecordSegment *)segment;

//录制时长超过上限，自动结束
- (void)recorderDidCompleteSession:(TBCKRecorder *)recorder;

//录制过程中，触发摄像头的captureOutput:didOutputSampleBuffer:fromConnection:事件，或者每1/60秒调用一次。一般用于更新UI上的计数器或进度条
- (void)recorderDidOutputSampleBuffer:(TBCKRecorder *)recorder;

@end
