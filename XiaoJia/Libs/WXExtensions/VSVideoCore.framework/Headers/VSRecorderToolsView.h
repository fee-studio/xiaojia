//
//  VideoStudio
//  VideoStudio
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSRecorder.h"

@class VSRecorder;
@class VSRecorderToolsView;

@protocol VSRecorderToolsViewDelegate <NSObject>

@optional

- (void)recorderToolsView:(VSRecorderToolsView *__nonnull)recorderToolsView didTapToFocusWithGestureRecognizer:(UIGestureRecognizer *__nonnull)gestureRecognizer;

@end

@interface VSRecorderToolsView : UIView

@property (nonatomic, weak) __nullable id<VSRecorderToolsViewDelegate> delegate;

/**
 The instance of the VSRecorder to use.
 */
@property (strong, nonatomic) VSRecorder *__nullable recorder;

/**
 The outside image used when focusing.
 */
@property (strong, nonatomic) UIImage *__nullable outsideFocusTargetImage;

/**
 The inside image used when focusing.
 */
@property (strong, nonatomic) UIImage *__nullable insideFocusTargetImage;

/**
 The size of the focus target.
 */
@property (assign, nonatomic) CGSize focusTargetSize;

/**
 The minimum zoom allowed for the pinch to zoom.
 Default is 1
 */
@property (assign, nonatomic) CGFloat minZoomFactor;

/**
 The maximum zoom allowed for the pinch to zoom.
 Default is 4
 */
@property (assign, nonatomic) CGFloat maxZoomFactor;

/**
 Whether the tap to focus should be enabled.
 */
@property (assign, nonatomic) BOOL tapToFocusEnabled;

/**
 Whether the double tap to reset the focus should be enabled.
 */
@property (assign, nonatomic) BOOL doubleTapToResetFocusEnabled;

/**
 Whether the pinch to zoom should be enabled.
 */
@property (assign, nonatomic) BOOL pinchToZoomEnabled;

@property (assign, nonatomic) BOOL showsFocusAnimationAutomatically;

- (void)showFocusAnimation;

/**
 Manually hide the focus animation.
 This method is called automatically if showsFocusAnimationAutomatically
 is set to YES.
 */
- (void)hideFocusAnimation;

@end
