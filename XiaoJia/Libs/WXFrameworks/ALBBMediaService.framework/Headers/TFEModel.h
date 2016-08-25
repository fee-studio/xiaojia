//
// Created by huamulou on 15/9/5.
// Copyright (c) 2015 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TFEFile : NSObject
/**
 * 空间
 */
@property(nonatomic, strong) NSString *space;
/**
 * 文件夹， 以斜杠开头不以斜杠结尾
 */
@property(nonatomic, strong) NSString *dir;
/**
 * 文件名
 */
@property(nonatomic, strong) NSString *name;

- (instancetype)initWithSpace:(NSString *)space dir:(NSString *)dir name:(NSString *)name;

+ (instancetype)fileWithSpace:(NSString *)space dir:(NSString *)dir name:(NSString *)name;

@end


@protocol TFEResponse <NSObject>

@property(nonatomic, strong) NSString *requestId;
@property(nonatomic) NSInteger httpStatus;
@property(nonatomic, strong) NSString *code;
@property(nonatomic, strong) NSString *message;
@end

@interface TFEHttpResponse : NSObject <TFEResponse>
- (NSString *)description;
@end

@interface TFEUploadResponse : TFEHttpResponse

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

- (NSString *)description;
@end

