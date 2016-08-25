//
//  VSProcessingQueue.h
//  VideoStudio
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSProcessingQueue : NSObject

@property (assign, nonatomic) NSUInteger maxQueueSize;

- (void)startProcessingWithBlock:(id(^)())processingBlock;

- (void)stopProcessing;

- (id)dequeue;

@end
