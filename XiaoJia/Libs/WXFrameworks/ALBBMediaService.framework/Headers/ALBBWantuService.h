//
//  ALBBWantuService.h
//  ALBBMediaService
//  旺旺支持群：1327158539
//
//  Created by huamulou on 16/2/20.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALBBWantuConfiguration;
@class ALBBWTUploadRequest;
@class ALBBWTUploadResponse;
@class ALBBWTInitMultipartUploadRequest;
@class ALBBWTInitMultipartUploadResponse;
@class ALBBWTUploadPartRequest;
@class ALBBWTUploadPartResponse;
@class ALBBWTCompleteMultipartUploadRequest;
@class ALBBWTCompleteMultipartUploadResponse;
@class ALBBWTCancelMultipartUploadRequest;
@class ALBBWTCancelMultipartUploadResponse;


/*-------------------------------------------------------------*/
@interface ALBBWantu : NSObject

+ (instancetype)defaultWantu;

+ (void)registerWantuWithConfiguration:(ALBBWantuConfiguration *)configuration forKey:(NSString *)key;

+ (instancetype)wantuForKey:(NSString *)key;

+ (void)removeWantuForKey:(NSString *)key;


- (instancetype) initWithConfiguration:(ALBBWantuConfiguration *)configuration;


- (void) upload:(ALBBWTUploadRequest *) uploadRequest completeHandler:(void (^)(ALBBWTUploadResponse *  response, NSError *  error))completeHandler;

- (void)initMultipartUpload:(ALBBWTInitMultipartUploadRequest *)request completeHandler:(void (^)(ALBBWTInitMultipartUploadResponse *, NSError *))completeHandle;

- (void)uploadPart:(ALBBWTUploadPartRequest *)request completeHandler:(void (^)(ALBBWTUploadPartResponse *, NSError *))completeHandle;

- (void)completeMultipartUpload:(ALBBWTCompleteMultipartUploadRequest *)request completeHandler:(void (^)(ALBBWTCompleteMultipartUploadResponse *, NSError *))completeHandle;

- (void)cancelMultipartUpload:(ALBBWTCancelMultipartUploadRequest *)request completeHandler:(void (^)(ALBBWTCancelMultipartUploadResponse *, NSError *))completeHandle;


- (void) setDebug:(BOOL) usingDebug;


@property (nonatomic, strong, readonly) ALBBWantuConfiguration *configuration;
@end


/*-------------------------------------------------------------*/
@interface ALBBNetworkingConfiguration : NSObject

/**
 The timeout interval to use when waiting for additional data.
 */
@property (nonatomic, assign) NSTimeInterval timeoutIntervalForRequest;
@property (nonatomic, assign) uint32_t maxRetryCount;

@end

/*-------------------------------------------------------------*/
@interface ALBBWantuConfiguration : ALBBNetworkingConfiguration

+ (instancetype)defaultConfiguration;

@property(nonatomic, strong) NSString *uploadEndPoint;

@end