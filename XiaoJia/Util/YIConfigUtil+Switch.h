//
//  YIConfigUtil+Switch.h
//  Dobby
//
//  Created by efeng on 14-10-15.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//
//  开关配置


#import "YIConfigUtil.h"

#define EMMA_DEBUG   DEBUG       // 应用中标记一些调试功能的开关


@interface YIConfigUtil (Switch)

+ (BOOL)onFeedback2;

+ (BOOL)onRemoteNotificationFor8;

@end
