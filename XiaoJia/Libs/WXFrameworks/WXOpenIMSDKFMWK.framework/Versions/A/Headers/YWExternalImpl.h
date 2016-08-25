//
//  YWExternalImpl.h
//  WXOpenIMSDK
//
//  Created by huanglei on 15/8/18.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWExternalImpl : NSObject

+ (instancetype)sharedInstance;

@end

#pragma mark - 外部实现AMR编解码

typedef BOOL(^YWAMRCodecExternalEncodeBlock)(NSString *aWavFile, NSString *aAmrFile);
typedef BOOL(^YWAMRCodecExternalDecodeBlock)(NSString *aAmrFile, NSString *aWavFile);

@interface YWExternalImpl (AMR)

@property (nonatomic, copy, readonly) YWAMRCodecExternalEncodeBlock encodeBlock;
@property (nonatomic, copy, readonly) YWAMRCodecExternalDecodeBlock decodeBlock;

/// 外部实现AMR的编解码
- (void)setExternalEncodeBlock:(YWAMRCodecExternalEncodeBlock)aEncodeBlock
                   decodeBlock:(YWAMRCodecExternalDecodeBlock)aDecodeBlock;

@end

#pragma mark - 外部实现lua脚本执行

@interface YWExternalImpl ()

typedef NSError *(^YWExternalLuaBlock)(NSString *aLuaString);

/// 务必在DidFinishLaunching中设置
@property (nonatomic, copy) YWExternalLuaBlock luaBlock;

- (void)setLuaBlock:(YWExternalLuaBlock)luaBlock;

@end
