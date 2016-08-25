//
//  VSVideoPlayerView.h
//  VSAudioVideoRecorder
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSPlayer.h"
#import "VSImageView.h"

@class VSVideoPlayerView;

@protocol VSVideoPlayerViewDelegate <NSObject>

- (void)videoPlayerViewTappedToPlay:(VSVideoPlayerView *__nonnull)videoPlayerView;

- (void)videoPlayerViewTappedToPause:(VSVideoPlayerView *__nonnull)videoPlayerView;

@end

@interface VSVideoPlayerView : UIView

/**
 The delegate
 */
@property (weak, nonatomic) IBOutlet __nullable id<VSVideoPlayerViewDelegate> delegate;

/**
 The player this VSVideoPlayerView show
 */
@property (strong, nonatomic) VSPlayer *__nullable player;

/**
 The underlying AVPlayerLayer used for displaying the video.
 */
@property (readonly, nonatomic) AVPlayerLayer *__nullable playerLayer;

/**
 If enabled, tapping on the view will pause/unpause the player.
 */
@property (assign, nonatomic) BOOL tapToPauseEnabled;

/**
 Init the VSVideoPlayerView with a provided VSPlayer.
 */
- (nonnull instancetype)initWithPlayer:(VSPlayer *__nonnull)player;

/**
 Set whether every new instances of VSVideoPlayerView should automatically create
 and hold an VSPlayer when needed. If disabled, an external VSPlayer must be set
 manually to each VSVideoPlayerView instance in order to work properly. Default is YES.
 */
+ (void)setAutoCreatePlayerWhenNeeded:(BOOL)autoCreatePlayerWhenNeeded;

/**
 Whether every new instances of VSVideoPlayerView should automatically create and hold an VSPlayer
 when needed. If disabled, an external VSPlayer must be set manually to each
 VSVideoPlayerView instance in order to work properly. Default is YES.
 */
+ (BOOL)autoCreatePlayerWhenNeeded;

@end
