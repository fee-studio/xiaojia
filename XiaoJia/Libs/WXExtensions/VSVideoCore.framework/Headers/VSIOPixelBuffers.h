//
//  VSVideoBuffer.h
//  VideoStudio
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface VSIOPixelBuffers : NSObject

@property (readonly, nonatomic) CMTime time;

@property (readonly, nonatomic) CVPixelBufferRef inputPixelBuffer;

@property (readonly, nonatomic) CVPixelBufferRef outputPixelBuffer;

+ (VSIOPixelBuffers *)IOPixelBuffersWithInputPixelBuffer:(CVPixelBufferRef)inputPixelBuffer outputPixelBuffer:(CVPixelBufferRef)outputPixelBuffer time:(CMTime)time;

@end
