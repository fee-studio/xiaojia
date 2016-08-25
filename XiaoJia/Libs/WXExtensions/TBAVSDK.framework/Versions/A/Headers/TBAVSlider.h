//
//  TBAVSlider.h
//  TBAVPlayerView
//
//  Created by Zhubicheng on 08/12/14.
//  Copyright (c) 2014 Taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBAVSlider : UISlider

- (void)setSecondaryValue:(float)value;
- (void)setSecondaryTintColor:(UIColor *)tintColor;
- (void)setThumbSize:(CGSize)size;

@end
