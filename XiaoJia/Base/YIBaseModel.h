//
//  YIBaseModel.h
//  Dobby
//
//  Created by efeng on 14-6-10.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface YIBaseModel : MTLModel <MTLJSONSerializing> {

}


- (BOOL)saveData;

+ (id)fetchData;

+ (BOOL)clearData;

+ (void)clearAllData;


@property(nonatomic, strong) NSString *savedPath;

- (BOOL)saveData:(NSString *)filePath;

- (id)fetchData:(NSString *)filePath;

- (BOOL)clearData:(NSString *)filePath;

+ (void)clearAllCacheData;

@end
