//
//  VSSession.h
//  VSAudioVideoRecorder
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "VSRecordSessionSegment.h"

#define kRecordSessionDefaultVideoCodec AVVideoCodecH264
#define kRecordSessionDefaultVideoScalingMode AVVideoScalingModeResizeAspectFill
#define kRecordSessionDefaultOutputBitPerPixel 12
#define kRecordSessionDefaultAudioBitrate 128000
#define kRecordSessionDefaultAudioFormat kAudioFormatMPEG4AAC


#ifdef DEBUG
#define VSLog NSLog
#else
#define VSLog(...)
#endif

extern NSString *__nonnull const VSRecordSessionSegmentFilenameKey;
extern NSString *__nonnull const VSRecordSessionSegmentFilenamesKey;
extern NSString *__nonnull const VSRecordSessionSegmentsKey;
extern NSString *__nonnull const VSRecordSessionDurationKey;
extern NSString *__nonnull const VSRecordSessionIdentifierKey;
extern NSString *__nonnull const VSRecordSessionSegmentInfoKey;
extern NSString *__nonnull const VSRecordSessionDateKey;
extern NSString *__nonnull const VSRecordSessionDirectoryKey;

extern NSString *__nonnull const VSRecordSessionTemporaryDirectory;
extern NSString *__nonnull const VSRecordSessionCacheDirectory;
extern NSString *__nonnull const VSRecordSessionDocumentDirectory;

@class VSRecordSession;
@class VSRecorder;


typedef NS_ENUM(NSInteger, VSRecordSessionState) {
    VSRecordSessionStateStopped = 0,//停止中
    VSRecordSessionStateReady,//已初始化segment，是否在录制由recoder.isRecording决定
    VSRecordSessionStateExporting//正在输出到文件中
};

@interface VSRecordSession : NSObject

//////////////////
// GENERAL SETTINGS
////

/**
 An unique identifier generated when creating this record session.
 */
@property (readonly, nonatomic) NSString *__nonnull identifier;

/**
 The date when this record session was created.
 */
@property (readonly, nonatomic) NSDate *__nonnull date;

/**
 The directory to which the record segments will be saved.
 Can be either VSRecordSessionTemporaryDirectory or an arbritary directory.
 Default is VSRecordSessionTemporaryDirectory.
 */
@property (copy, nonatomic) NSString *__nonnull segmentsDirectory;

/**
 The output file type used for the AVAssetWriter.
 If null, AVFileTypeMPEG4 will be used for a video file, AVFileTypeAppleM4A for an audio file
 */
@property (copy, nonatomic) NSString *__nullable fileType;

/**
 The extension of every record segments.
 If null, the VSRecordSession will figure out one depending on the fileType.
 */
@property (copy, nonatomic) NSString *__nullable fileExtension;

/**
 The output url based on the identifier, the recordSegmentsDirectory and the fileExtension
 */
@property (readonly, nonatomic) NSURL *__nonnull outputUrl;

/**
 Contains every record segment as VSRecordSessionSegment.
 */
@property (readonly, nonatomic) NSArray *__nonnull segments;

/**
 The duration of the whole recordSession including the current recording segment
 and the previously added record segments.
 */
@property (readonly, nonatomic) CMTime duration;

/**
 The duration of the recorded record segments.
 */
@property (readonly, atomic) CMTime segmentsDuration;

/**
 The duration of the current recording segment.
 */
@property (readonly, atomic) CMTime currentSegmentDuration;

/**
 True if a recordSegment has began
 */
@property (readonly, nonatomic) BOOL recordSegmentBegan;

/**
 The recorder that is managing this VSRecordSession
 */
@property (readonly, nonatomic, weak) VSRecorder *__nullable recorder;

//////////////////
// PUBLIC METHODS
////

- (nonnull instancetype)init;

/**
 Create a VSRecordSession
 */
+ (nonnull instancetype)recordSession;

/**
 Calling any method of VSRecordSession is thread safe. However,
 if the record session is inside an VSRecorder instance, its state
 might change between 2 calls you are making. Making any modification
 within this block will ensure that you are the only one who has
 access to any modification on this VSRecordSession.
 */
- (void)dispatchSyncOnSessionQueue:(void(^__nonnull)())block;

//////////////////////
/////// SEGMENTS
////

/**
 Remove the record segment. Does not delete the associated file.
 */
- (void)removeSegment:(VSRecordSessionSegment *__nonnull)segment;

/**
 Remove the record segment at the given index.
 */
- (void)removeSegmentAtIndex:(NSInteger)segmentIndex deleteFile:(BOOL)deleteFile;

/**
 Add a recorded segment.
 */
- (void)addSegment:(VSRecordSessionSegment *__nonnull)segment;

/**
 Insert a record segment.
 */
- (void)insertSegment:(VSRecordSessionSegment *__nonnull)segment atIndex:(NSInteger)segmentIndex;

/**
 Remove all the record segments and their associated files.
 */
- (void)removeAllSegments;

/**
 Remove all the record segments and their associated files if deleteFiles is true.
 */
- (void)removeAllSegments:(BOOL)deleteFiles;

/**
 Remove the last segment safely. Does nothing if no segment were recorded.
 */
- (void)removeLastSegment;

/**
 Cancel the session.
 End the current recordSegment (if any) and call removeAllSegments
 If you don't want a segment to be automatically added when calling this method,
 you should remove the VSRecordSession from the VSRecorder
 */
- (void)cancelSession:(void(^ __nullable)())completionHandler;



//将所有视频片段合成一个AVAsset对象
- (void)composeSegments:(void(^ __nullable)(AVAsset *__nonnull asset))completionHandler;


/**
 Append all the record segments to a given AVMutableComposition.
 */
- (void)appendSegmentsToComposition:(AVMutableComposition *__nonnull)composition;

/**
 Append all the record segments to a given AVMutableComposition and adds the audio mix instruction
 if audioMix is provided
 */
- (void)appendSegmentsToComposition:(AVMutableComposition *__nonnull)composition audioMix:(AVMutableAudioMix *__nullable)audioMix;

/**
 Returns a dictionary that represents this VSRecordSession
 This will only contains strings and can be therefore safely serialized
 in any text format
 */
- (NSDictionary *__nonnull)dictionaryRepresentation;

/**
 Stop the current segment and deinitialize the video and the audio.
 This can be usefull if the input video or audio profile changed.
 */
- (void)deinitialize;

/**
 Start a new record segment.
 This method is automatically called by the VSRecorder.
 */
- (void)beginSegment:(NSError*__nullable*__nullable)error;

/**
 End the current record segment.
 This method is automatically called by the VSRecorder
 when calling [VSRecorder pause] if necessary.
 segmentIndex contains the index of the segment recorded accessible
 in the recordSegments array. If error is not null, if will be -1
 If you don't remove the VSRecordSession from the VSRecorder while calling this method,
 The VSRecorder might create a new recordSegment right after automatically if it is not paused.
 */
- (BOOL)endSegmentWithInfo:(NSDictionary *__nullable)info completionHandler:(void(^__nullable)(VSRecordSessionSegment *__nullable segment, NSError *__nullable error))completionHandler;

@end
