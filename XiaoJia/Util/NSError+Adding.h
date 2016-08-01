//
// Created by efeng on 15/6/24.
// Copyright (c) 2015 weiboyi. All rights reserved.
//


#import <Foundation/Foundation.h>


static NSString *const DobbyErrorDomain = @"com.weiboyi.emma";

/**
* Error codes in Server domain
*/
typedef NS_ENUM(NSUInteger, ErrorCode) {

    ErrorCodeSuccess = 0, // 操作成功
    ErrorCodeServerDown = 1, // 服务器维护中
    ErrorCodeAIDError = 2, // 不支持的客户端类型	即aid不合法
    ErrorCodeRIDError = 3, // 找不到和请求对应的处理对象	即客户端提交了一个无法识别的rid
    ErrorCodePIDError = 4, // 不支持的协议版本号	即pid不合法
    ErrorCodeTokenExpired = 5, // token已经失效，客户端需要重新登录
    ErrorCodeNeedUpdate = 6, // token已经失效，客户端需要软件升级
    ErrorCodeLostParameters = 7, // 缺少必须的参数	缺少aid,rid,pid.length1,info或者length2字段
    ErrorCodeOutOfMixLength = 8, // 请求数据包超出最大长度
    ErrorCodeRequestLengthAndInfoNotMatch = 9, // 请求数据包Length1和info字段长度不符合
    ErrorCodeInfoFarmatError = 10, // info字段格式不正确
    ErrorCodeLostInfoParameters = 11, // info缺少必须的字段	例如在登录以后请求中缺少token
    ErrorCodeRequestLengthAndInfoNotMatch2 = 12, // 请求数据包Length2和data字段长度不符合
    ErrorCodeAuthenticationError = 13, // 用户认证错误（服务器返回的错误号是1000以外的数，由客户端映射到此错误号）
    ErrorCodeAuthorizationError = 14, // 用户授权错误（暂时没有使用，保留）
    ErrorCodeUploadFailure = 15, // 文件上传失败
    ErrorCodeRawPasswordError = 17, // 注册后还没修改过密码
    ErrorCodeUnknownError = 99, // 未知错误
    ErrorCodeNetworkNotReachable = 98,// 网络不可达 网络失败

    ErrorCodeNoCacheData = 1601,
};


@interface NSError (Adding)

@property(nonatomic, copy) NSString *errorArg1;

+ (instancetype)dobbyErrorWithCode:(NSInteger)code andMsg:(NSString *)msg;

+ (id)networkNotReachableError;

+ (id)noCacheDataError;

- (id)toHandle;

@end
