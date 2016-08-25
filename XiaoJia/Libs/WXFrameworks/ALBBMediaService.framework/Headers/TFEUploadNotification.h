//
//  TaeFileNotification.h
//
//  Created by huamulou on 14-11-9.
//  Copyright (c) 2014年 showmethemoney. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TFEUploadSession;

typedef void (^TFEUploadProgress)(TFEUploadSession *session, NSUInteger progress);

typedef void (^TFEUploadSuccess)(TFEUploadSession *session, NSString *url);

typedef void (^TFEUploadFailed)(TFEUploadSession *session, NSError *error);

@interface TFEUploadNotification : NSObject

@property(copy, readonly) TFEUploadProgress progress;
@property(copy, readonly) TFEUploadSuccess success;
@property(copy, readonly) TFEUploadFailed failed;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)notificationWithProgress:(TFEUploadProgress)progress success:(TFEUploadSuccess)success failed:(TFEUploadFailed)failed;

@end
