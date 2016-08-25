//
//  VSFilter+VideoComposition.h
//  VideoStudio
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "VSFilter.h"

@interface VSFilter (VideoComposition)

/**
 Creates and returns a videoComposition that will process the given asset with this filter.
 Returns nil on unsupported platforms.
 */
- (AVMutableVideoComposition *__nullable)videoCompositionWithAsset:(AVAsset *__nonnull)asset NS_AVAILABLE(10_11, 9_0);

@end
