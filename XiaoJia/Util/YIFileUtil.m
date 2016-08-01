//
//  YIFileUtil.m
//  Dobby
//
//  Created by efeng on 14-6-30.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

@implementation YIFileUtil

+ (NSString *)appCachesDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return paths[0];
}

+ (NSString *)appDocumentDirectory {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths[0];
}


//单个文件的大小
+ (long long)fileSizeAtPath:(NSString *)filePath {

    NSFileManager *manager = [NSFileManager defaultManager];

    if ([manager fileExistsAtPath:filePath]) {

        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//遍历文件夹获得文件夹大小，返回多少M
+ (float)folderSizeAtPath:(NSString *)folderPath {

    NSFileManager *manager = [NSFileManager defaultManager];

    if (![manager fileExistsAtPath:folderPath]) return 0;

    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];

    NSString *fileName;

    long long folderSize = 0;

    while ((fileName = [childFilesEnumerator nextObject]) != nil) {

        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];

        folderSize += [[self class] fileSizeAtPath:fileAbsolutePath];

    }

    return folderSize / (1024.0 * 1024.0);

}

@end
