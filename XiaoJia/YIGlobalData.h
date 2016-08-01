//
//  YIGlobalData.h
//  Dobby
//
//  Created by efeng on 14-6-4.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YIConfigUtil.h"
#import "YIFlashlight.h"
#import "YIPrivateSetting.h"


#define mGlobalData [YIGlobalData sharedInstance]

/**
*  需要持久化的属性的key
*/
#define kLogin                  @"isLoginKey" // 是否已登录
#define kDeviceToken            @"deviceToken"  // 设备Token（APNS推送）
#define kLaunched               @"app_launched"
#define kDebugOn                @"debug_on"
#define kShowFeature            @"show_app_new_featrue"
#define kSavedVersionCode       @"saved_version_code"
#define kNotShowSplashScreen    @"not_show_splash_screen"
#define kHomeVc    @"home_vc"

static NSString *const RELOAD_USER_DATA_NOTIFICATION = @"reload_user_data_notification";

@class YIBaseNavigationController;

@interface YIGlobalData : NSObject


//@property(nonatomic, strong) LCUserEntity *user;
//@property(nonatomic, strong) LCBabyEntity *curBaby;

@property(nonatomic, strong) NSString *homeVc;
@property(nonatomic, assign) BOOL login;  // 是否已登录
@property(nonatomic, assign) BOOL isLaunched; // 用在显示欢迎页上
@property(nonatomic, assign) BOOL isShowFeature; // 用在显示新功能介绍上
@property(nonatomic, assign) BOOL debugOn;
@property(nonatomic, assign) NSInteger serverTime;
@property(nonatomic, assign) NSInteger localTimeOffset;  // 本地时间差 = 服务器时间戳 - 接收到服务器时间时的本机时间
@property(nonatomic, strong) NSString *deviceToken;  // 设备Token（APNS推送)
//@property(nonatomic, strong) NSString *savedVersionCode; // 升级版本用来清理缓存数据
//@property(nonatomic, strong) NSString *latitude;
//@property(nonatomic, strong) NSString *longitude;
//@property(nonatomic, strong) NSString *country;
//@property(nonatomic, strong) NSString *province;
//@property(nonatomic, strong) NSString *city;
//@property(nonatomic, strong) NSString *district;
//@property(nonatomic, strong) NSString *street;
//@property(nonatomic, strong) NSString *carrier; // 运营商
@property(nonatomic, strong) NSString *netType; // 网络类型
//@property(nonatomic, strong) NSString *flight;

@property(nonatomic, strong) YIFlashlight *flashlight;

@property(nonatomic, strong) YIPrivateSetting *privateSetting;

@property(nonatomic, assign) BOOL notShowSplashScreen;


+ (YIGlobalData *)sharedInstance;

- (void)loadDefaultValue;


@end
