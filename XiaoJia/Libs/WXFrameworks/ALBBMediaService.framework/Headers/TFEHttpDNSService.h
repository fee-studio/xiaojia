//
// Created by huamulou on 16/1/3.
//

#import <Foundation/Foundation.h>
#import "TFEConstants.h"

@class TFEResult;
@class TFEHttpDNSService;
@class TFEHttpDNSOrigin;
@protocol TFENetMonitorServiceProtocol;
@protocol TFEHttpDNSStrategy;

extern NSString *const kTFEHttpDNSNotification;

@interface TFEHttpDNSService : NSObject

TFE_SHARE_INSTANCE_DECLARE

/**
 * 决定是否选择httpDNS
 */
@property(strong) id <TFEHttpDNSStrategy> strategy;

/**
 * 需要依赖网络监视组件
 */
@property(strong) id <TFENetMonitorServiceProtocol> netMonitorService;

/**
 * key -> TFENetworkType
 * value -> NSDictionary (key -> host, value -> TFEStack|TFEHttpDNSOrigin)
 */
@property(strong) NSMutableDictionary *dnsCache;

/**
 * 同步方法
 */
- (TFEHttpDNSOrigin *)resolve:(NSString *)rawUrl;

/**
 * 异步方法
 * 如果内存中有, 则立即返回
 * 如果内存中没有, 则发起异步任务开始解析，并返回nil
 */
- (TFEHttpDNSOrigin *)asyncResolve:(NSString *)rawUrl;

/**
 * 增加预解析host，启动手机，或者网络变化的时候自动解析
 */
- (void) addPreResolveHost:(NSString *)host;

/**
 * 删除预解析host
 */
- (void) removePreResolveHost:(NSString *)host;


/**
 * 缓存操作相关方法
 */
- (TFEHttpDNSOrigin *)readCache:(NSString *)host;

- (TFEHttpDNSOrigin *)readCache:(NSString *)host networkType:(NSUInteger)networkType wifiSSID:(NSString *)wifiSSID;

- (void)addCache:(TFEHttpDNSOrigin *)origin ;

- (void)addCache:(TFEHttpDNSOrigin *)origin networkType:(NSUInteger)type wifiSSID:(NSString *)wifiSSID ;

- (void)removeCache:(NSString *)host;

- (void)removeCache:(NSString *)host networkType:(NSUInteger)networkType wifiSSID:(NSString *)wifiSSID;


@end



@protocol TFEHttpDNSStrategy

- (void)setHttpDNSEnable:(BOOL)enable;

/**
 * 判断本次请求是否适用于httpDNS
 *
 */
- (BOOL)useHttpDNSForHost:(NSString *)host service:(TFEHttpDNSService *)service;

/**
 * 向httpDNS汇报网络失败情况
 */
- (void)reportNetWorkFailed:(NSString *)host;

/**
 * 向httpDNS汇报请求失败情况
 */
- (void)reportRequestFailed:(NSString *)host;

/**
 * 向httpDNS汇报请求失败情况
 */
- (void)reportResolveFailed:(NSString *)host;

- (void)setMaxFailedCount:(NSUInteger)count;

@end


@interface TFEHttpDNSOrigin : NSObject

//如果是wifi,会存储ssid
@property(strong) NSString *wifiSSID;
@property(nonatomic, strong) NSArray *ips;
@property(strong) NSString *host;
@property(strong) NSDate *queryTime;
@property(nonatomic, assign) long ttl;

- (BOOL)isExpired;

- (id)initWithHost:(NSString *)host;

- (NSString *)defaultIp;

- (NSString *)description;
@end



@interface TFEHttpDNSDefaultStrategy : NSObject <TFEHttpDNSStrategy>

@property BOOL enableHttpDNS;

/**
 * 业务请求失败数, 服务端返回没有requestId, 但是3xx, 4xx, 5xx
 */
@property NSUInteger requestFailedCount;

/**
 * 解析失败数
 */
@property NSUInteger resolveFailedCount;

/**
 * 网络连接失败之类的
 */
@property NSUInteger netWorkFailedCount;

/**
 * 允许的最大失败数,默认是10
 */
@property NSUInteger maxFailedCount;

@end