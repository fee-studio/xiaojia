//
//  IYWUtilService4Zip.h
//  WXOpenIMSDK
//
//  Created by huanglei on 16/4/13.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IYWZipProtocol <NSObject>

/// zip
- (BOOL)createZipFile:(NSString *)aZipFile password:(NSString *)aPassword append:(BOOL)aAppend;
- (BOOL)addFileToZip:(NSString *)aFile newName:(NSString *)aNewName;
- (BOOL)addDirectoryToZip:(NSString *)aDirectoryPath newDirectory:(NSString *)aNewDirectory;
- (BOOL)closeZipFile;

/// unzip
- (BOOL)unzipOpenFile:(NSString *)aZipFile password:(NSString *)aPassword;
- (BOOL)unzipFileTo:(NSString *)aPath overWrite:(BOOL)aOverwrite;
- (BOOL)unzipCloseFile;


@end

@protocol IYWUtilService4Zip <NSObject>

/// 获取一个实例
- (id<IYWZipProtocol>)fetchZipArchiver;

@end
