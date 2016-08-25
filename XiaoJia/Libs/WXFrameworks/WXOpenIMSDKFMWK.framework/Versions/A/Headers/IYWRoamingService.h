//
//  IYWRoamingService.h
//
//
//  Created by Jai Chen on 15/2/9.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#ifndef IYWRoamingService_h
#define IYWRoamingService_h

typedef void (^YWRoamingAuthenticationChallengeCompletionHandlerBlock)(NSString *roamingPassword);
typedef void (^YWDidReceiveRoamingAuthenticationChallengeBlock)(YWRoamingAuthenticationChallengeCompletionHandlerBlock completionHandler);


typedef NS_ENUM(NSInteger, YWRoamingServiceState) {
    /**
     *  漫游服务已关闭
     */
    YWRoamingServiceStateDisable = 0,
    /**
     *  漫游服务已开启
     */
    YWRoamingServiceStateEnable = 1
};

@protocol IYWRoamingService <NSObject>

/**
 *  查询漫游服务的开启状态
 */
- (void)getRoamingServiceState:(void (^)(YWRoamingServiceState state, NSError *error))completion;

/**
 *  设置漫游服务的开启状态
 */
- (void)setRoamingServiceState:(YWRoamingServiceState)state completion:(void (^)(NSError * error))completion;

/**
 *  漫游要求提供密码进行验证的回调
 *
 *  @param block 将用户所输入的漫游密码作为参数调用该 block 以进行漫游密码授权
 */
- (void)setDidReceiveRoamingAuthenticationChangllengeBlock:(YWDidReceiveRoamingAuthenticationChallengeBlock)block;

/**
 *  是否自动漫游最近联系人的本地开关
 *  默认为打开
 */
@property (nonatomic, assign) BOOL enableLocalAutoRoamingRecent;

/**
 *  本地控制漫游最近联系人的数量
 *  默认是20
 *  最大数目由服务端控制，目前是100
 */
@property (nonatomic, readwrite) NSNumber *localAutoRoamingCount;


@end
#endif
