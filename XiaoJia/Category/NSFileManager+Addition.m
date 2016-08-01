//
//  NSFileManager+HW.m
//  StringDemo
//
//  Created by 何 振东 on 12-10-11.
//  Copyright (c) 2012年 wsk. All rights reserved.
//

@implementation NSFileManager (Addition)

+ (BOOL)createFolder:(NSString *)folder atPath:(NSString *)path {
    NSString *savePath = [path stringByAppendingPathComponent:folder];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL exist = [fileManager fileExistsAtPath:savePath isDirectory:&isDirectory];
    NSError *error = nil;
    if (!exist || !isDirectory) {
        [fileManager createDirectoryAtPath:savePath withIntermediateDirectories:YES attributes:nil error:&error];
    }

    return [fileManager fileExistsAtPath:savePath isDirectory:&isDirectory];
}

+ (BOOL)createFolderPath:(NSString *)path {

    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL exist = [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    NSError *error = nil;
    if (!exist || !isDirectory) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    }

    return [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
}


+ (BOOL)createFilePath:(NSString *)filePath {
    // 是否存在此路径，不存在创建
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL exist = [fm fileExistsAtPath:filePath isDirectory:&isDirectory];

    if (!exist || !isDirectory) {
        NSString *dirPath = [filePath stringByDeletingLastPathComponent];
        BOOL dirExist = [fm fileExistsAtPath:dirPath isDirectory:&isDirectory];

        if (!dirExist || !isDirectory) {
            BOOL isOk = [fm createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
            if (isOk) {
                [fm createFileAtPath:filePath contents:nil attributes:nil];
            }
        } else {
            [fm createFileAtPath:filePath contents:nil attributes:nil];
        }
    }

    return [fm fileExistsAtPath:filePath isDirectory:&isDirectory];
}

+ (BOOL)saveData:(NSData *)data withName:(NSString *)name atPath:(NSString *)path {
    if (data && name && path) {
        if ([self createFilePath:path]) {
            NSString *filePath = [path stringByAppendingPathComponent:name];
            return [data writeToFile:filePath atomically:YES];
        }
    }

    return NO;
}

+ (BOOL)saveObject:(id)object withName:(NSString *)name atPath:(NSString *)path {
    if (object && name && path) {
        if ([object respondsToSelector:@selector(writeToFile:atomically:)]) {

            if ([self createFilePath:path]) {
                NSString *filePath = [path stringByAppendingPathComponent:name];
                return [object writeToFile:filePath atomically:YES];
            }
        }
    }

    return NO;
}

+ (BOOL)saveObject:(id)object withFilePath:(NSString *)filePath {
    if (object && filePath) {
        if ([object respondsToSelector:@selector(writeToFile:atomically:)]) {

            BOOL isSuccess = [self createFilePath:filePath];
            if (isSuccess) {
                BOOL isOk = [NSKeyedArchiver archiveRootObject:object toFile:filePath];
                return isOk;
            }
        }
    }

    return NO;
}

+ (NSData *)findFile:(NSString *)fileName atPath:(NSString *)path {
    NSData *data = nil;
    if (fileName && path) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *filePath = [path stringByAppendingPathComponent:fileName];

        if ([fileManager fileExistsAtPath:filePath]) {
            data = [NSData dataWithContentsOfFile:filePath];
        }
    }

    return data;
}

+ (id)findFileWithFilePath:(NSString *)filePath {
    id object = nil;
    if (filePath) {
        NSFileManager *fileManager = [NSFileManager defaultManager];

        if ([fileManager fileExistsAtPath:filePath]) {
            object = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        }
    }

    return object;
}

+ (BOOL)deleteFile:(NSString *)fileName atPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    return success;
}

+ (BOOL)deleteObjectWithPath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    return success;
}

@end
