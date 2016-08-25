//
//  ALBBWTModel.h
//  ALBBWantu
//
//  Created by huamulou on 16/2/20.
//  Copyright © 2016年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALBBWTMTLModel.h"
#import "ALBBWTMTLJSONAdapter.h"


/*-------------------------------------------------------------*/
//上传进度的Block定义，即闭包定义
typedef void (^ALBBWTUploadProgressBlock) (int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend);

/*-------------------------------------------------------------*/
//声明上传资源类型的枚举类
typedef NS_ENUM(NSInteger, ALBBWTUploadType) {
    ALBBWTUploadTypeNSURL = 0,
    ALBBWTUploadTypeData
};

/*-------------------------------------------------------------*/
@interface ALBBWTRequest : ALBBWTMTLModel

@property (nonatomic, assign, readonly, getter = isCancelled) BOOL cancelled;

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong, readonly) NSString *sessionId;

-(void) cancel;
@end
/*-------------------------------------------------------------*/
@interface ALBBWTUploadRequest : ALBBWTRequest

@property (nonatomic, copy)  ALBBWTUploadProgressBlock uploadProgress;

@property (nonatomic, strong) id content;

@property(nonatomic, assign, readonly) ALBBWTUploadType uploadType;
/**
 *  用户自定义的 meta- 参数，用于服务端 替换 魔法变量
 *  可以作为魔法变量填充
 */
@property(nonatomic, strong) NSDictionary *customMetas;
/**
 *  用户自定义的 var- 参数，用于服务的 替换 魔法变量
 *  可以作为魔法变量填充
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

/*-------------------------------------------------------------*/
@interface ALBBWTUploadDataRequest : ALBBWTUploadRequest



@end

/*-------------------------------------------------------------*/
@interface ALBBWTUploadFileRequest : ALBBWTUploadRequest


@end

/*-------------------------------------------------------------*/
@interface ALBBWTResponse : ALBBWTMTLModel<ALBBWTMTLJSONSerializing>

@property(nonatomic, strong) NSString *requestId;
@property(nonatomic) NSInteger httpStatus;
@property(nonatomic, strong) NSString *code;
@property(nonatomic, strong) NSString *message;

@end


/*-------------------------------------------------------------*/
@interface ALBBWTUploadResponse : ALBBWTResponse

//由tae sdk返回的url，上传成功之后有
@property(nonatomic, strong) NSString *url;
@property(nonatomic) BOOL isImage;
@property(nonatomic, strong) NSString *uri;

//由tae sdk返回的url，上传成功之后有
@property(nonatomic, strong) NSString *dir;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *returnBody;
@property(nonatomic, strong) NSString *customBody;

@property(nonatomic) NSInteger fileSize;
@property(nonatomic) NSString *eTag;

@property(nonatomic) NSString *mimeType;

@end


/*-------------------------------------------------------------*/
@interface ALBBWTMultipartUploadBaseRequest : ALBBWTRequest

@property (nonatomic, copy)  ALBBWTUploadProgressBlock uploadProgress;


@end

/*-------------------------------------------------------------*/
#pragma mark 分片上传
@interface ALBBWTInitMultipartUploadRequest : ALBBWTRequest

@property (nonatomic, strong) NSString *dir;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, copy)  ALBBWTUploadProgressBlock uploadProgress;

@property (nonatomic, strong) NSData *content;

@property (nonatomic, strong) NSString *localFileName;

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

@end

/*-------------------------------------------------------------*/
@interface ALBBWTInitMultipartUploadResponse : ALBBWTResponse

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *dir;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *eTag;

@property (nonatomic, strong) NSString *uploadId;

@property (nonatomic) NSInteger partNumber;

@end

/*-------------------------------------------------------------*/
@interface ALBBWTUploadPartRequest : ALBBWTRequest

@property (nonatomic, copy)  ALBBWTUploadProgressBlock uploadProgress;

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *uploadId;

@property (nonatomic) NSInteger partNumber;

@property (nonatomic, strong) NSData *content;

@end

/*-------------------------------------------------------------*/
@interface ALBBWTUploadPartResponse : ALBBWTResponse

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *dir;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *eTag;

@property (nonatomic, strong) NSString *uploadId;

@property (nonatomic) NSInteger partNumber;

@end

/*-------------------------------------------------------------*/
@interface ALBBWTCompleteMultipartUploadRequest : ALBBWTRequest

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *uploadId;

@property (nonatomic, strong) NSArray *parts;

@end

/*-------------------------------------------------------------*/
@interface ALBBWTCompleteMultipartUploadResponse : ALBBWTUploadResponse

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *uploadId;

@end

/*-------------------------------------------------------------*/
@interface ALBBWTCancelMultipartUploadRequest : ALBBWTRequest

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *uploadId;

//@property (nonatomic, strong) NSArray *parts; //Cancel request doesn't need this parameter.

@end

/*-------------------------------------------------------------*/
@interface ALBBWTCancelMultipartUploadResponse : ALBBWTResponse


@end

/*-------------------------------------------------------------*/
@interface ALBBWTPart : NSObject

@property(nonatomic) NSInteger partNumber;
@property(nonatomic, copy) NSString *eTag;
@end

