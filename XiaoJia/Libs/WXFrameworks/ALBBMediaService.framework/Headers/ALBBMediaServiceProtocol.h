//
//  阿里多媒体云iOS SDK
//  旺旺支持群：1327158539
//  Copyright (c) 2014年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFEUploadNotification.h"

#define ALBB_MEDIA_SERVICE_VERSION @"3.8.2"

@class TFEUploadParameters;
@class TFEUploadNotification;
@class TFEImageTransferOptions;
@class TFELoadSession;
@class TFELoadOptions;
@class TFELoadNotification;
@class TFEUploadOptions;
@class TFEUploadPolicy;
@class ALBBImageComponent;
@protocol TFETokenGenerator;
@class TFEFile;
@protocol ALBBMediaServiceProtocol;


typedef NS_ENUM(NSInteger, TFEError) {
    TFEErrorUnKnown = 0,
    TFEErrorFileNotExist = 1001,
    TFEErrorFileTypeDisallow = 1002,
    TFEErrorFileRetryTimesExceed = 1003,
    TFEErrorMultipartRetryTimesExceed = 1004,
    TFEErrorUploadError = 1005,
    TFEErrorLoadError = 1006,
    TFEErrorFileReadException = 1007,
    TFEErrorAssetsReadException = 1008,
    TFEErrorNetworkNotReachable = 1009,
    TFEErrorNetworkChanged = 1010,
    TFEErrorConnectionTimeout = 1011,
    TFEErrorImageSizeExceed = 1012,
    TFEErrorIllegalArgument = 1013,
    TFEErrorLoadRequestError = 1014,
    TFEErrorSessionError = 1015,
    TFEErrorAuthFailed = 1016,
    TFEErrorTokenExipred = 1017,
    TFEErrorAssetsGlobalDenied = 1018,
    TFEErrorCanceled = 2001,
    
    TFEErrorTokenRequire = 3001,
    TFEErrorContentInvalid = 3002,
    TFEErrorIdOrUploadIdRequire = 3003,
    TFEErrorPartNumberInvalid = 3004,
    TFEErrorPartsInvalid = 3005
};

typedef NS_ENUM(NSInteger, TFEEnvironment) {
    TFEEnvironmentDaily = 0,
    TFEEnvironmentPreRelease = 1,
    TFEEnvironmentRelease = 2,
    TFEEnvironmentSandBox = 3
};

typedef NS_ENUM(NSInteger, TFETaskStatus) {
    TFETaskStatusReady = 0,
    TFETaskStatusFailed = 1,
    TFETaskStatusCanceled = 2,
    TFETaskStatusRunning = 3,
    TFETaskStatusSuspend = 4,
    TFETaskStatusSuccess = 5
};

@interface ALBBMediaServiceFactory : NSObject

/**
 * 获取Media server protocol的实例，非安全图片模式下使用这个方式初始化ALBBMediaServiceProtocol实例
 *
 * @param tokenGenerator 上传token的生成器。需要自定义上传token的需要实现TFETokenGenerator的protocol
 */
+ (id <ALBBMediaServiceProtocol>)getService:(id <TFETokenGenerator>)tokenDelegate;


@end


@protocol ALBBMediaServiceProtocol <NSObject>


/**
 *  公共的通知，所有文件的上传通知都会调用公共的通知
 */
@property(nonatomic, strong) TFEUploadNotification *globalNotification;

/**
 *  取消所有任务
 */
- (void)cancelAllUploads;

/**
 *  取消特定任务
 *
 *  @param localUniqueIdentifier    本地上传id，用于标识本地一个任务， 使用TaeFile.localUniqueIdentifier, 或者使用upload的返回参数
 */
- (void)cancelUploadByUniqueId:(NSString *)uniqueIdentifier;


/**
 *  直接上传接口
 *
 *  @param data         文件data
 *  @param ns           space
 *  @param fileName     服务器上存储的文件名
 *  @param dir          服务器上存储的路径
 *  @param progress     上传进度
 *  @param success      上传成功通知
 *  @param upload       上传失败通知
 *
 *  @return 任务唯一标识
 */
- (NSString *)uploadByData:(NSData *)data
                     space:(NSString *)space
                  fileName:(NSString *)fileName
                       dir:(NSString *)dir
                  progress:(TFEUploadProgress)progress
                   success:(TFEUploadSuccess)success
                    failed:(TFEUploadFailed)failed;

/**
 * 上传接口
 * @param parameters
 * @param notification
 * @return uniqueId
 */
- (NSString *)upload:(TFEUploadParameters *)parameters notification:(TFEUploadNotification *)notification;

/**
 * 上传接口
 * @param parameters
 * @param options
 * @param notification
 * @return uniqueId
 */
- (NSString *)upload:(TFEUploadParameters *)parameters options:(TFEUploadOptions *)options notification:(TFEUploadNotification *)notification;


/**
 *  获取通过变形转换之后的url Deprecated
 *
 *  @param options 图片处理选项
 *
 *  @return 变形转换之后的url
 */
- (NSString *)getTransferedURL:(TFEImageTransferOptions *)options error:(NSError **)error __deprecated;


/**
 *  获取通过变形转换之后的url
 *
 *  @param file 文件信息
 *  @param options 图片处理选项
 *
 *  @return 变形转换之后的url
 */
- (NSString *)getTransferredURL:(TFEFile *)file options:(TFEImageTransferOptions *)options;


- (TFELoadSession *)load:(NSString *)url error:(NSError **)error;

/**
 *  同步加载
 *
 *  @param url 图片url
 *  @param options 选项
 *  @param error 发生的错误
 *
 *  @return TFELoadSession
 */
- (TFELoadSession *)load:(NSString *)url options:(TFELoadOptions *)options error:(NSError **)error;


- (NSString *)asynLoad:(NSString *)url notifications:(TFELoadNotification *)notifications;


/**
 *  异步加载
 *
 *  @param url      url
 *  @param notifications 异步加载完的回调
 *  @param options 选项
 *
 *  @return UIImage
 */
- (NSString *)asynLoad:(NSString *)url notifications:(TFELoadNotification *)notifications options:(TFELoadOptions *)options;


/**
 * 配置是否使用spdy来加载图片
 */
@property(nonatomic) BOOL useSpdy;

/**
 * 配置是否debug模式
 */
@property(nonatomic) BOOL debug;

/**
 * 获取图片组件实例
 * 需要引入ALBBImageComponent.bundle文件才能够初始化图片组件
 * @return ALBBImageComponent实例
 */
- (id)getImageComponent;


@end

/**
 * token生成器
 */

@protocol TFETokenGenerator <NSObject>


/**
* 通过上传策略获取token
* @param policy 上传策略
*/
- (NSString *)generateToken:(TFEUploadPolicy *)policy;


@end