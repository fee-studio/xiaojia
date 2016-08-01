//
//  YIFileUtil.h
//  Dobby
//
//  Created by efeng on 14-6-30.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YIFileUtil : NSObject

+ (NSString *)appCachesDirectory;

+ (NSString *)appDocumentDirectory;

//单个文件的大小
+ (long long)fileSizeAtPath:(NSString *)filePath;

//遍历文件夹获得文件夹大小，返回多少M
+ (float)folderSizeAtPath:(NSString *)folderPath;

@end
