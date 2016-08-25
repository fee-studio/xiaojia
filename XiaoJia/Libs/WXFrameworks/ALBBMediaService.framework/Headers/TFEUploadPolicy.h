//
//  TFEUploadPolicy.h
//
//  Created by huamulou on 15-1-20.
//  Copyright (c) 2015年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TFEUploadRemoteCall;

@interface TFEUploadPolicy : NSObject


@property(nonatomic, strong) NSString *space;

@property(nonatomic, strong) TFEUploadRemoteCall *remoteCall;

@property(nonatomic, strong) NSString *mimeLimit;
//文件在服务器上的名称，不可以重复
@property(nonatomic, strong) NSString *fileName;
//文件在服务器上的文件夹地址，不可以重复
@property(nonatomic, strong) NSString *dir;
@property(nonatomic, assign) BOOL insertOnly;
@property(nonatomic, strong) NSDictionary *customPolicies;
@property(nonatomic) long long sizeLimit;
/**
* @brief 设置上传策略的过期时间
*/
@property(nonatomic, strong) NSDate *expiration;

+ (instancetype)policyWithNamespace:(NSString *)space;

+ (instancetype)policyWithANamespace:(NSString *)space fileName:(NSString *)fileName dir:(NSString *)dir;

- (instancetype)init NS_UNAVAILABLE;
@end
