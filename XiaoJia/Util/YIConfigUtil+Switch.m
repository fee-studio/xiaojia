//
//  YIConfigUtil+Switch.m
//  Dobby
//
//  Created by efeng on 14-10-15.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

@implementation YIConfigUtil (Switch)


+ (BOOL)onFeedback2; {
#ifdef DEBUG
    return YES;
#else
    return NO;
#endif
}


+ (BOOL)onRemoteNotificationFor8; {
#ifdef DEBUG
    return YES;
#else
    return NO;
#endif
}


@end
