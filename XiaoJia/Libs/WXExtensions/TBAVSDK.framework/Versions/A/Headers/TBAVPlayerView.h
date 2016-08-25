//
//  TBAVPlayerView.h
//  TBAVPlayerView
//
//  Created by Zhubicheng on 08/12/14.
//  Copyright (c) 2014 Taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "TBAVSlider.h"

@class TBAVPlayerView;

@protocol TBAVPlayerViewDelegate <NSObject>

@optional
- (void)playerViewWillPlay:(TBAVPlayerView *)playerView;
- (void)playerViewWillPause:(TBAVPlayerView *)playerView;
- (void)playerViewDidPause:(TBAVPlayerView *)playerView;
- (void)playerViewWillResume:(TBAVPlayerView *)playerView;
- (void)playerViewWillEndPlaying:(TBAVPlayerView *)playerView;
- (void)playerViewDidEndPlaying:(TBAVPlayerView *)playerView;
- (void)playerViewWillEnterFullscreen:(TBAVPlayerView *)playerView;
- (void)playerViewDidEnterFullscreen:(TBAVPlayerView *)playerView;
- (void)playerViewWillLeaveFullscreen:(TBAVPlayerView *)playerView;
- (void)playerViewDidLeaveFullscreen:(TBAVPlayerView *)playerView;
- (void)playerViewTimeSliderStartDrag:(TBAVPlayerView *)playerView;
- (void)playerViewTimeSliderFinishDrag:(TBAVPlayerView *)playerView;
- (void)playerView:(TBAVPlayerView *)playerView timeSliderValueDidChanged:(CGFloat)second;
- (void)playerViewShowFailView:(TBAVPlayerView *)playerView error:(NSError *)error;
- (void)playerViewStalled:(TBAVPlayerView *)playerView;
- (void)playerViewTimeChanged:(CMTime)time;

- (void)playerViewDidTap:(TBAVPlayerView *)playerView;
@end

extern const NSInteger TBAVPlayerViewActivityIndicatorPriority;
extern const NSInteger TBAVPlayerViewErrorIndicatorPriority;

typedef NS_ENUM (NSInteger, TBAVPlayerStatus) {
    TBAVPlayerStatusUnknown = 0,
    TBAVPlayerStatusReady,
    TBAVPlayerStatusWaiting,
    TBAVPlayerStatusPlaying,
    TBAVPlayerStatusError
};

@interface TBAVPlayerView : UIView

@property (strong, nonatomic) NSURL     *videoURL;
@property (assign, nonatomic) NSInteger controlsTimeoutPeriod;
@property (nonatomic, assign) BOOL      exitFullScreenWhenFinish;

@property (nonatomic, assign) BOOL allowShowControls;
@property (nonatomic, assign) BOOL allowShowIndicator;
@property (nonatomic, assign) BOOL allowShowCenterControl;

@property (weak, nonatomic) id<TBAVPlayerViewDelegate> delegate;

// UI
@property (nonatomic, strong) UIView      *containerView;
@property (nonatomic, strong) UIImageView *thumbnailImageView;
@property (nonatomic, strong) UIView      *controlsOverlayView;
@property (nonatomic, strong) UIView      *indicatorOverlayView;

@property (nonatomic, strong) UIButton *bigPlayButton;

// controls
@property (strong, nonatomic) TBAVSlider *progressIndicator;
@property (strong, nonatomic) UIButton   *playButton;
@property (strong, nonatomic) UIButton   *fullscreenButton;
@property (strong, nonatomic) UILabel    *currentTimeLabel;
@property (strong, nonatomic) UILabel    *remainingTimeLabel;

@property (strong, nonatomic) UIView *activityIndicator;
@property (nonatomic, strong) UIView *errorIndicator;

// status
@property (assign, nonatomic) BOOL fullscreen;

@property (nonatomic, readonly) Float64 loadedTime;
@property (nonatomic, readonly) BOOL isPlaying;
@property (nonatomic, readonly) BOOL hasPlayed;

@property (nonatomic, readonly) TBAVPlayerStatus playerStatus;

@property (readonly, nonatomic) AVPlayer *player;

- (void)preload;
- (void)play;
- (void)pause;
- (void)stop;

- (void)setBufferTintColor:(UIColor *)tintColor;

- (void)showErrorIndicatorViewWithError:(NSError *)error;
- (void)showIndicatorView:(UIView *)indicator withPriority:(NSInteger)priority;
- (void)hideIndicatorView:(UIView *)indicator;

@end
