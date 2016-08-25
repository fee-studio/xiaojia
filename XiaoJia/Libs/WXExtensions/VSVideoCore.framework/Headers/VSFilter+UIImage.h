//
//  VSFilter+UIImage.h
//  VideoStudio
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSFilter.h"

@interface VSFilter (UIImage)

/**
 Returns a UIImage by processing this filter into the given UIImage
 */
- (UIImage *__nullable)UIImageByProcessingUIImage:(UIImage *__nullable)image atTime:(CFTimeInterval)time;

/**
 Returns a UIImage by processing this filter into the given UIImage
 */
- (UIImage *__nullable)UIImageByProcessingUIImage:(UIImage *__nullable)image;

@end
