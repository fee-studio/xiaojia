//
//  YIConfigUtil.h
//  Dobby
//
//  Created by efeng on 14-6-30.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>


#define APP_ERROR_HANDLE_NOTIFICATION   @"app_error_handle_notification"
#define SHARE_CALLBACK_NOTIFICATION     @"share_callback_notification"
#define TOGGLE_LOGIN_STATUS_NOTIFICATION  @"toggle_login_status_notification"
#define AUTO_CLOSE_HONGBAO_NOTIFICATION @"auto_close_hongbao_notification"
#define REFRESH_ORDER_DATA_IN_INDEXVC_NOTITICATION    @"refresh_order_data_in_index_vc_notification"
#define REFRESH_PROFIT_DATA_IN_INDEXVC_NOTITICATION   @"refresh_profit_data_in_index_vc_notification"


#define PARAMETERS_LOST @"参数缺失_本地"


typedef NS_ENUM(NSUInteger, ServerType) {
    ServerTypeRelease = 0,  // 正式服务器
    ServerTypeDevTest = 1,  // 开发测试服务器
    ServerTypeIntegrationTest = 2, // 集成测试服务器
};

typedef NS_ENUM(NSUInteger, NotificationType) {
    NotificationTypeNormal = 1, // 普通类型
    NotificationTypeFollowCode = 2, // 关注小号
    NotificationTypeHongBao = 3,
};


/**
* 推广渠道
*/
static NSString *const APP_CHANNEL_FAN_YONG = @"fan_yong";
static NSString *const APP_CHANNEL_CI = @"ci";
static NSString *const APP_CHANNEL_DEFAULT = @"default";

static NSString *const APP_CHANNEL_PYQ = @"app_peng_you_quan_fen_xiang";
static NSString *const APP_CHANNEL_FRIEND = @"app_hao_you_fen_xiang";

// ===========================================================================


// ===========================================================================


@interface YIConfigUtil : NSObject

// 账户信息保存路径
+ (NSString *)userInfoSavedPath;


/**
*  从网络下载的文件保存到指定的文件夹 - 文件夹名就是订单id号 (Library/Caches/${orderId})
*
*  @param orderId 订单的id号
*
*  @return 指定的目录
*/
+ (NSURL *)downloadFileSaveToTargetFolder:(NSString *)orderId;

/**
*  静默登录
*/
//+ (void)silentLogin;

/**
*  缩略图地址格式化
*  if size == CGSizeZero 是默认的原图的大小
*/
+ (NSURL *)thumbURLWithString:(NSString *)string andSize:(CGSize)size;

/**
*  服务器当前的时间.准确的时间
*
*  @return 服务器当前的时间.准确的时间
*/
+ (NSInteger)currentTimeAtServer;

/**
*  本地当前的时间
*
*  @return 本地当前的时间
*/
+ (NSInteger)currentTimeAtLocal;


+ (NSString *)getMacAddress __deprecated_msg("方法过期，ios7以后不能用。");

+ (NSString *)macaddress __deprecated_msg("方法过期，ios7以后不能用。");

+ (ALAuthorizationStatus)checkAlbumAuthorization;

@end
