//
//  IYWUtilService4Security.h
//
//
//  Created by huanglei on 15/3/12.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IYWUtilService4Security <NSObject>

/// MD5
- (NSString *)md5OfData:(NSData *)aInputData;

/// Base64解码
- (NSData *)Base64Decode:(NSString *)aInputString;

/// Base64编码
- (NSString *)Base64Encode:(NSData *)aInputData;


/// AES256加密
- (NSData *)AES256EncryptData:(NSData *)aInputData withKey:(NSString *)aKey;

/// AES256解密
- (NSData *)AES256DecryptData:(NSData *)aInputData withKey:(NSString *)aKey;

/// 使用RSA公钥加密
- (NSData *)RSAPubEncryptData:(NSData *)aInputData withKeyData:(NSData *)aKeyData;

/// 使用RSA公钥验证
- (BOOL)RSAPubVerityData:(NSData *)aSignedData inputData:(NSData *)aInputData withKeyData:(NSData *)aKeyData;

@end
