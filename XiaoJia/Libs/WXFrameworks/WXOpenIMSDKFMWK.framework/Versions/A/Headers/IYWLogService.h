//
//  IYWLogService.h
//  WXOpenIMSDK
//
//  Created by huanglei on 15/3/27.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  日志级别
 */
typedef NS_ENUM(NSUInteger, YWLogLevel) {
    YWLogLevelDebug,
    YWLogLevelInfo,
    YWLogLevelWarning,
    YWLogLevelError,
};

@protocol IYWLogService <NSObject>

/**
 *  设置日志开关，默认开启。
 */
- (void)setLogEnabled:(BOOL)aEnabled;

/**
 *  日志是否开启，默认开启。
 */
- (BOOL)logEnabled;

/**
 *  记录日志
 */
- (void)logWithLevel:(YWLogLevel)aLevel tag:(NSString *)aTag format:(NSString *)aFormat, ...;

/**
 *  将要把日志写到文件的回调，你可以在这个里面将日志写到textView等控件，用于在界面上查看日志信息
 *  @param aLogInfo 日志信息
 *  @param aLevel 日志级别
 */
typedef void(^YWLogDidOutputBlock)(NSString *aLogInfo, YWLogLevel aLevel);
/**
 *  将要把日志写到文件的回调，你可以在这个里面将日志写到textView等控件，用于在界面上查看日志信息
 */
@property (nonatomic, copy, readonly) YWLogDidOutputBlock didOutputBlock;
- (void)setDidOutputBlock:(YWLogDidOutputBlock)didOutputBlock;


/**
 *  需要关闭调试界面时，在YWAPI初始化成功后调用
 */
@property (nonatomic, assign) BOOL needCloseDiag;

/**
 *  外部控制调试界面
 */
- (UIViewController *)diagController;
/**
 *  外部控制上传日志
 */
- (void)uploadLogWithCompletionBlock:(void(^)(NSString *aFileName))aCompletionBlock;



@end
