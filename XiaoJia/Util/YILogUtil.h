//
//  YILogUtil.h
//  Dobby
//
//  Created by efeng on 14-5-21.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YILogUtil : NSObject

+ (void)logFrameOfView:(UIView *)view andName:(NSString *)name;

+ (void)logFrameOrBounds:(CGRect)rect andName:(NSString *)name;

+ (void)logSize:(CGSize)size andName:(NSString *)name;

+ (void)logPoint:(CGPoint)point andName:(NSString *)name;

+ (void)logCurrentTimeWithName:(NSString *)name;

@end
