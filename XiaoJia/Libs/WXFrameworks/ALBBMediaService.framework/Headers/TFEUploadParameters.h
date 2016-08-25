//
//  UploadOptions.h
//
//  Created by huamulou on 15-1-13.
//  Copyright (c) 2015年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFEUploadPolicy.h"

@class TFEUploadRemoteCall;

@interface TFEUploadParameters : NSObject
/**
*  上传策略
*/
@property(nonatomic, strong) TFEUploadPolicy *policy;
//文件在服务器上的名称，不可以重复
@property(nonatomic, strong) NSString *fileName;
//文件在服务器上的文件夹地址，不可以重复
@property(nonatomic, strong) NSString *dir;
//文件的路径，上传文件才有。上传流或者data无
@property(nonatomic, strong, readonly) NSString *fileLocalPath;
//系统图库的url
@property(nonatomic, strong, readonly) NSURL *assetUrl;

@property(nonatomic, strong, readonly) NSData *data;
//由tae sdk返回的url，上传成功之后有
@property(nonatomic, strong, readonly) NSString *url;

+ (TFEUploadParameters *)paramsWithAssertUrl:(NSURL *)assertUrl space:(NSString *)space fileName:(NSString *)fileName dir:(NSString *)url;

+ (TFEUploadParameters *)paramsWithData:(NSData *)data space:(NSString *)space fileName:(NSString *)fileName dir:(NSString *)url;

+ (TFEUploadParameters *)paramsWithFilePath:(NSString *)filePath space:(NSString *)space fileName:(NSString *)fileName dir:(NSString *)url;

+ (TFEUploadParameters *)paramsWithAssertUrl:(NSURL *)assertUrl policy:(TFEUploadPolicy *)policy;

+ (TFEUploadParameters *)paramsWithData:(NSData *)data policy:(TFEUploadPolicy *)policy;

+ (TFEUploadParameters *)paramsWithFilePath:(NSString *)filePath policy:(TFEUploadPolicy *)policy;


/**
*  用户自定义的meta
*/
@property(nonatomic, strong) NSDictionary *customMetas;
/**
*  用户自定义的参数
*/
@property(nonatomic, strong) NSDictionary *customParms;
/**
 *  用户自定义的扩展参数，用于在 http body中上报额外的信息
 *  首次出现在3.8.2版，为支持千牛视频扩展信息
 */
@property(nonatomic, strong) NSDictionary *extendParms;


//服务端是否做md5校验
@property(nonatomic, assign) BOOL needMd5Verify;


@end
