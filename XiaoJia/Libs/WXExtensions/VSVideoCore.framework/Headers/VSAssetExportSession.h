//
//  VSAssetExportSession.h
//  VideoStudio
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "VSFilter.h"
#import "VSVideoConfiguration.h"
#import "VSAudioConfiguration.h"
#import "VSContext.h"
#import "VSEAGLImageView.h"

@class VSAssetExportSession;
@protocol VSAssetExportSessionDelegate <NSObject>

@optional

- (void)assetExportSessionDidProgress:(VSAssetExportSession *__nonnull)assetExportSession;

- (BOOL)assetExportSession:(VSAssetExportSession *__nonnull)assetExportSession shouldReginReadWriteOnInput:(AVAssetWriterInput *__nonnull)writerInput fromOutput:(AVAssetReaderOutput *__nonnull)output;

- (BOOL)assetExportSessionNeedsInputPixelBufferAdaptor:(VSAssetExportSession *__nonnull)assetExportSession;

@end

@interface VSAssetExportSession : NSObject

/**
 The input asset to use
 */
@property (strong, nonatomic) AVAsset *__nullable inputAsset;

/**
 The outputUrl to which the asset will be exported
 */
@property (strong, nonatomic) NSURL *__nullable outputUrl;

/**
 The type of file to be written by the export session
 */
@property (strong, nonatomic) NSString *__nullable outputFileType;

/**
 The context type to use for rendering the images through a filter
 */
@property (assign, nonatomic) VSContextType contextType;

/**
 Access the configuration for the video.
 */
@property (readonly, nonatomic) VSVideoConfiguration *__nonnull videoConfiguration;

/**
 Access the configuration for the audio.
 */
@property (readonly, nonatomic) VSAudioConfiguration *__nonnull audioConfiguration;

/**
 If an error occured during the export, this will contain that error
 */
@property (readonly, nonatomic) NSError *__nullable error;

/**
 Will be set to YES if cancelExport was called
 */
@property (readonly, atomic) BOOL cancelled;

/**
 The timeRange to read from the inputAsset
 */
@property (assign, nonatomic) CMTimeRange timeRange;

/**
 Whether the assetExportSession should automatically translate the filter into an AVVideoComposition.
 This won't be done if a composition has already been set in the videoConfiguration.
 Default is YES
 */
@property (assign, nonatomic) BOOL translatesFilterIntoComposition;

/**
 Indicates whether the movie should be optimized for network use.
 Default is NO
 */
@property (assign, nonatomic) BOOL shouldOptimizeForNetworkUse;

/**
 The current progress
 */
@property (readonly, nonatomic) float progress;

@property (weak, nonatomic) __nullable id<VSAssetExportSessionDelegate> delegate;


@property (assign, nonatomic) VSEAGLImageView *__nullable imageView;

- (nonnull instancetype)init;

// Init with the inputAsset
- (nonnull instancetype)initWithAsset:(AVAsset *__nonnull)inputAsset;

/**
 Cancels exportAsynchronouslyWithCompletionHandler
 */
- (void)cancelExport;

/**
 Starts the asynchronous execution of the export session
 */
- (void)exportAsynchronouslyWithCompletionHandler:(void(^__nullable)())completionHandler;

@end
