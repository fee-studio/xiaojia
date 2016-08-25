//
//  VSPixelBufferHolder.h
//  VideoStudio
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface VSPixelBufferHolder : NSObject

@property (assign, nonatomic) CVPixelBufferRef pixelBuffer;

+ (VSPixelBufferHolder *)pixelBufferHolderWithPixelBuffer:(CVPixelBufferRef)pixelBuffer;

@end
