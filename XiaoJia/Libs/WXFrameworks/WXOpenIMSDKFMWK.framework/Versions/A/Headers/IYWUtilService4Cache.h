//
//  IYWCacheUtilService.h
//
//
//  Created by huanglei on 15/2/11.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IYWUtilService4Cache <NSObject>

/**
 *  @param aData 需要存放的数据
 *  @param aKey 使用的key
 */
- (void)storeData:(NSData *)aData forKey:(NSString *)aKey;

/**
 *  @param aKey 需要访问的key
 *  @return 结果NSData对象
 */
- (NSData *)dataForKey:(NSString *)aKey;


/**
 *  @param aData 需要存放的数据
 *  @param aUrlString 该数据的来源URL
 */
- (void)storeData:(NSData *)aData forUrlString:(NSString *)aUrlString;

/**
 *  @param aUrlString 数据的来源URL
 *  @return 如果没有本地存储，则返回nil
 */
- (NSData *)dataForUrlString:(NSString *)aUrlString;


/**
 *  清除 aKey 对应的数据
 *
 *  @param aKey 使用的key
 */
- (void)removeDataForKey:(NSString *)aKey;

/**
 *  全部缓存的大小,以字节为单位
 */
- (long long)cacheSize;


/**
 *  清除全部缓存
 */
- (void)removeAllDatas;

@end
