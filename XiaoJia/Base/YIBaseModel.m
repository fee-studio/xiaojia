//
//  YIBaseModel.m
//  Dobby
//
//  Created by efeng on 14-6-10.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//


@interface YIBaseModel ()

@end

@implementation YIBaseModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:self.class];
}

#pragma mark -

- (BOOL)saveData {
    NSString *filePath = [self.class _filePath];
    BOOL isSuccess = [NSKeyedArchiver archiveRootObject:self toFile:filePath];
    return isSuccess;
}

+ (id)fetchData {
    NSString *filePath = [self.class _filePath];
    id baseModel = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (baseModel) {
        return baseModel;
    } else {
        return [[self.class alloc] init];
    }
}

+ (BOOL)clearData {
    BOOL isSuccess = [NSFileManager deleteObjectWithPath:[self _filePath]];
    return isSuccess;
}

+ (void)clearAllData {
    NSString *deletedPath = [YIFileUtil appCachesDirectory];
    NSFileManager *fm = [[NSFileManager alloc] init];
    NSDirectoryEnumerator *en = [fm enumeratorAtPath:deletedPath];
    NSError *err = nil;
    BOOL res;

    NSString *file;
    while (file = [en nextObject]) {
        res = [fm removeItemAtPath:[deletedPath stringByAppendingPathComponent:file] error:&err];
        if (!res && err) {
            NSLog(@"oops: 清理失败：%@", err);
        } else {
            NSLog(@"yeah: 清理成功：%@", file);
        }
    }
}

+ (NSString *)_filePath {
    NSString *path = [[YIFileUtil appCachesDirectory]
            stringByAppendingPathComponent:[NSStringFromClass(self.class) md5]];
    return path;
}

#pragma mark -

- (BOOL)saveData:(NSString *)filePath {
    self.savedPath = filePath;
    BOOL isSuccess = [NSKeyedArchiver archiveRootObject:self toFile:[self _savedPath]];
    return isSuccess;
}

- (id)fetchData:(NSString *)filePath {
    self.savedPath = filePath;
    id baseModel = [NSKeyedUnarchiver unarchiveObjectWithFile:[self _savedPath]];
    if (baseModel) {
        return baseModel;
    } else {
        return self;
    }
}

- (BOOL)clearData:(NSString *)filePath {
    self.savedPath = filePath;
    BOOL isSuccess = [NSFileManager deleteObjectWithPath:[self _savedPath]];
    return isSuccess;
}

+ (void)clearAllCacheData {
    NSString *deletedPath = [YIFileUtil appCachesDirectory];
    NSFileManager *fm = [[NSFileManager alloc] init];
    NSDirectoryEnumerator *en = [fm enumeratorAtPath:deletedPath];
    NSError *err = nil;
    BOOL res;

    NSString *file;
    while (file = [en nextObject]) {
        res = [fm removeItemAtPath:[deletedPath stringByAppendingPathComponent:file] error:&err];
        if (!res && err) {
            NSLog(@"oops: 清理失败：%@", err);
        } else {
            NSLog(@"yeah: 清理成功：%@", file);
        }
    }
}

- (NSString *)_savedPath {
    NSAssert(self.savedPath.isOK, @"保存路径必须指定的~");
    NSString *path = [[YIFileUtil appCachesDirectory] stringByAppendingPathComponent:self.savedPath];
    return path;
}


@end
