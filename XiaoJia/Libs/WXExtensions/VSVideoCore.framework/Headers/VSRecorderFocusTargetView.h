//
//  XHCameraTagetView.h
//  VideoStudio
//
//  
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSRecorderFocusTargetView : UIView

@property (strong, nonatomic) UIImage *outsideFocusTargetImage;
@property (strong, nonatomic) UIImage *insideFocusTargetImage;
@property (assign, nonatomic) float insideFocusTargetImageSizeRatio;

- (void)startTargeting;
- (void)stopTargeting;

@end
