//
//  VSFilterAnimation.h
//  VideoStudio
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSFilterAnimation : NSObject<NSCoding>

@property (readonly, nonatomic) NSString *__nonnull key;

@property (readonly, nonatomic) __nullable id startValue;

@property (readonly, nonatomic) __nullable id endValue;

@property (readonly, nonatomic) CFTimeInterval startTime;

@property (readonly, nonatomic) CFTimeInterval duration;

- (__nullable id)valueAtTime:(CFTimeInterval)time;

- (BOOL)hasValueAtTime:(CFTimeInterval)time;

+ (VSFilterAnimation *__nonnull)filterAnimationForParameterKey:(NSString *__nonnull)key startValue:(__nullable id)startValue endValue:(__nullable id)endValue startTime:(CFTimeInterval)startTime duration:(CFTimeInterval)duration;

@end
