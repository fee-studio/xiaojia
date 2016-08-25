//
//  TFEUploadSession.h
//
//  Created by huamulou on 15-1-20.
//  Copyright (c) 2015年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALBBMediaServiceProtocol.h"
#import "TFEModel.h"

@class TFEUploadParameters;

@interface TFEUploadSession : NSObject

//本次上传的标识
@property(nonatomic, readonly, strong) NSString *uniqueIdentifier;

@property(nonatomic, readonly, strong) TFEUploadParameters *parameters;


//由tae sdk返回的url，上传成功之后有
@property(nonatomic, strong, readonly) NSString *responseUrl;
@property(nonatomic, strong, readonly) TFEUploadResponse *response;

//文件的md5值
@property(nonatomic, strong, readonly) NSString *md5;
//文件大小
@property(nonatomic, assign, readonly) unsigned long size;
@property(nonatomic, assign, readonly) unsigned long sizeUploaded;
@property(nonatomic, assign, readonly) unsigned long byteSent;

@property(nonatomic, assign, readonly) TFETaskStatus status;

//是否可以断点续传
@property(nonatomic, assign, readonly) BOOL resumable;

/**
*  任务被添加的时间
*/
@property(nonatomic, assign, readonly) double startTime;
/**
*  任务结束的时间
*/
@property(nonatomic, assign, readonly) double endTime;


/**
*  用户的自定义数据
*/
@property(nonatomic, strong, readonly) id userInfo;


@property(nonatomic, strong, readonly) NSString *suffix;

/**
* 是否处于已结束状态
*/
-(BOOL) isFinished;
-(BOOL) isCanceled;

- (instancetype)init NS_UNAVAILABLE;

- (NSString *)description;

@end
