//
//  VSSaveToCameraRollOperation.h
//  VideoStudio
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSSaveToCameraRollOperation : NSObject

- (void)saveVideoURL:(NSURL *)url completion:(void(^)(NSString *, NSError *))completion;

- (void)saveImage:(UIImage *)image completion:(void(^)(NSError *))completion;

@end
