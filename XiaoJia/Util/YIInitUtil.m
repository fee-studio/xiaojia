//
//  YIInitUtil.m
//  YIBox
//
//  Created by efeng on 16/3/7.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "YIInitUtil.h"

@implementation YIInitUtil

+ (YIInitUtil *)instance {
    static YIInitUtil *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {

    }

    return self;
}

+ (void)loadBaseInit {
    [self initUmeng];

    [mGlobalData loadDefaultValue];
}

// http://www.jianshu.com/p/803bfaae989e
+ (void)registerAPNS {
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound
                                                                             categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
#else
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
#endif
}

+ (void)initUmeng {
    UMConfigInstance.appKey = UMENG_APP_KEY;
    UMConfigInstance.channelId = [YICommonUtil channelName];
    [MobClick startWithConfigure:UMConfigInstance];

    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];

    // 友盟反馈
    [UMFeedback setAppkey:UMENG_APP_KEY];
}


@end
