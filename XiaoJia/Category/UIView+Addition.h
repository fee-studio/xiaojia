//
//  UIView+Addition.h
//  Line0New
//
//  Created by line0 on 13-5-17.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)


- (UIView *)subViewWithTag:(int)tag;

+ (UIView *)loadNibView:(NSString *)viewName;

+ (UIView *)loadNibView:(NSString *)viewName index:(NSUInteger)index;

- (UIImage *)toImage;

- (void)borderAndCornerStyle;

- (void)cornerStyle;

- (void)borderStyle;

- (void)flashlightSwitchStyle;

- (void)circleStyle;

@end
