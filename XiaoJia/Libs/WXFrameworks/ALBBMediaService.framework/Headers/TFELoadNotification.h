//
//  TFELoadNotification.h
//
//  Created by huamulou on 15-1-18.
//  Copyright (c) 2015年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TFELoadSession;
typedef void (^TFELoadSuccess)(TFELoadSession *session, NSData *responseData);
typedef void (^TFELoadFailed)(TFELoadSession *session, NSError *error);
typedef void (^TFELoadProgress)(TFELoadSession* session, NSUInteger progress);

@interface TFELoadNotification : NSObject


@property(nonatomic, copy, readonly)TFELoadProgress progress;
@property(nonatomic, copy, readonly)TFELoadSuccess success;
@property(nonatomic, copy, readonly)TFELoadFailed failed;

- (instancetype)init NS_UNAVAILABLE;
/**
 * 生成通知实例
 * @param progress  进度通知
 * @param success   成功通知
 * @param failed    失败通知
 */
+ (instancetype)notificationWithProgress:(TFELoadProgress)progress success:(TFELoadSuccess)success failed:(TFELoadFailed)failed;


@end
