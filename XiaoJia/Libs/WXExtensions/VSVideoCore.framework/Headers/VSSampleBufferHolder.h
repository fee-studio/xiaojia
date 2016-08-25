//
//  VSSampleBufferHolder.h
//  VideoStudio
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface VSSampleBufferHolder : NSObject

@property (assign, nonatomic) CMSampleBufferRef sampleBuffer;

+ (VSSampleBufferHolder *)sampleBufferHolderWithSampleBuffer:(CMSampleBufferRef)sampleBuffer;

@end
