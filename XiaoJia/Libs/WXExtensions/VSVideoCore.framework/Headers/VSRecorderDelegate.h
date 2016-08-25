//
//  VideoStudio
//  VideoStudio
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "VSRecorder.h"

typedef NS_ENUM(NSInteger, VSFlashMode) {
    VSFlashModeOff  = AVCaptureFlashModeOff,
    VSFlashModeOn   = AVCaptureFlashModeOn,
    VSFlashModeAuto = AVCaptureFlashModeAuto,
    VSFlashModeLight
};

@class VSRecorder;

@protocol VSRecorderDelegate <NSObject>

@optional

/**
 Called when the recorder has reconfigured the videoInput
 */
- (void)recorder:(VSRecorder *__nonnull)recorder didReconfigureVideoInput:(NSError *__nullable)videoInputError;

/**
 Called when the recorder has reconfigured the audioInput
 */
- (void)recorder:(VSRecorder *__nonnull)recorder didReconfigureAudioInput:(NSError *__nullable)audioInputError;

/**
 Called when the flashMode has changed
 */
- (void)recorder:(VSRecorder *__nonnull)recorder didChangeFlashMode:(VSFlashMode)flashMode error:(NSError *__nullable)error;

/**
 Called when the recorder has lost the focus. Returning true will make the recorder
 automatically refocus at the center.
 */
- (BOOL)recorderShouldAutomaticallyRefocus:(VSRecorder *__nonnull)recorder;

/**
 Called before the recorder will start focusing
 */
- (void)recorderWillStartFocus:(VSRecorder *__nonnull)recorder;

/**
 Called when the recorder has started focusing
 */
- (void)recorderDidStartFocus:(VSRecorder *__nonnull)recorder;

/**
 Called when the recorder has finished focusing
 */
- (void)recorderDidEndFocus:(VSRecorder *__nonnull)recorder;

/**
 Called before the recorder will start adjusting exposure
 */
- (void)recorderWillStartAdjustingExposure:(VSRecorder *__nonnull)recorder;

/**
 Called when the recorder has started adjusting exposure
 */
- (void)recorderDidStartAdjustingExposure:(VSRecorder *__nonnull)recorder;

/**
 Called when the recorder has finished adjusting exposure
 */
- (void)recorderDidEndAdjustingExposure:(VSRecorder *__nonnull)recorder;

/**
 Called when the recorder has initialized the audio in a session
 */
- (void)recorder:(VSRecorder *__nonnull)recorder didInitializeAudioInSession:(VSRecordSession *__nonnull)session error:(NSError *__nullable)error;

/**
 Called when the recorder has initialized the video in a session
 */
- (void)recorder:(VSRecorder *__nonnull)recorder didInitializeVideoInSession:(VSRecordSession *__nonnull)session error:(NSError *__nullable)error;

/**
 Called when the recorder has started a segment in a session
 */
- (void)recorder:(VSRecorder *__nonnull)recorder didBeginSegmentInSession:(VSRecordSession *__nonnull)session error:(NSError *__nullable)error;

/**
 Called when the recorder has completed a segment in a session
 */
- (void)recorder:(VSRecorder *__nonnull)recorder didCompleteSegment:(VSRecordSessionSegment *__nullable)segment inSession:(VSRecordSession *__nonnull)session error:(NSError *__nullable)error;

/**
 Called when the recorder has appended a video buffer in a session
 */
- (void)recorder:(VSRecorder *__nonnull)recorder didAppendVideoSampleBufferInSession:(VSRecordSession *__nonnull)session;

/**
 Called when the recorder has appended an audio buffer in a session
 */
- (void)recorder:(VSRecorder *__nonnull)recorder didAppendAudioSampleBufferInSession:(VSRecordSession *__nonnull)session;

/**
 Called when the recorder has skipped an audio buffer in a session
 */
- (void)recorder:(VSRecorder *__nonnull)recorder didSkipAudioSampleBufferInSession:(VSRecordSession *__nonnull)session;

/**
 Called when the recorder has skipped a video buffer in a session
 */
- (void)recorder:(VSRecorder *__nonnull)recorder didSkipVideoSampleBufferInSession:(VSRecordSession *__nonnull)session;

/**
 Called when a session has reached the maxRecordDuration
 */
- (void)recorder:(VSRecorder *__nonnull)recorder didCompleteSession:(VSRecordSession *__nonnull)session;

/**
 Gives an opportunity to the delegate to create an info dictionary for a record segment.
 */
- (NSDictionary *__nullable)createSegmentInfoForRecorder:(VSRecorder *__nonnull)recorder;

@end
