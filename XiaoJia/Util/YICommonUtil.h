//
//  YICommonUtil.h
//  Dobby
//
//  Created by efeng on 15/7/7.
//  Copyright (c) 2015年 weiboyi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YICommonUtil : NSObject

+ (void)copyStringToPasteboard:(NSString *)copiedString;

// 应用的名字
+ (NSString *)appName;

// 强制退出应用
+ (void)suspendAppAndExit;

// 是否远程注册
+ (BOOL)isRegisteredRemoteNotification;

// 应用的版本号
+ (NSString *)appVersion;

// 应用的图标
+ (UIImage *)appIconImage;

// unix时间戳
+ (NSString *)unixTimestamp;

// 打开应用的appstore页
+ (void)toAppPageOfAppStore;

// 两个日期之间的天数
+ (NSInteger)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime;

// 渠道名字
+ (NSString *)channelName;

@end
