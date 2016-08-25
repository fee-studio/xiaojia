//
//  VSPhotoConfiguration.h
//  VideoStudio
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import "VSMediaTypeConfiguration.h"

@interface VSPhotoConfiguration : NSObject

/**
 Whether the photo output is enabled or not.
 Changing this value after the session has been opened
 on the VSRecorder has no effect.
 */
@property (assign, nonatomic) BOOL enabled;

/**
 If set, every other properties but "enabled" will be ignored
 and this options dictionary will be used instead.
 */
@property (copy, nonatomic) NSDictionary *__nullable options;

/**
 Returns the output settings for the 
 */
- (NSDictionary *__nonnull)createOutputSettings;

@end
