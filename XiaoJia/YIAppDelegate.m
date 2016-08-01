//
//  AppDelegate.m
//  BaoBaoJi
//
//  Created by efeng on 15/9/5.
//  Copyright (c) 2015年 buerguo. All rights reserved.
//
// 解决启动是黑屏的问题

#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "YIIndexVc.h"
#import "TorchObject.h"
#import "iVersion.h"
#import "YISplashScreen.h"
#import "YIInitUtil.h"
#import "YIBlurVc.h"


@interface YIAppDelegate () <CLLocationManagerDelegate,
        UIViewControllerTransitioningDelegate,
        UIDocumentInteractionControllerDelegate> {

}
@property(strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation YIAppDelegate

+ (void)initialize {
    NSLog(@"=== initialize");

#ifdef DEBUG
//    [[AFNetworkActivityLogger sharedLogger] startLogging];
#endif

    [iVersion sharedInstance].appStoreID = 1083816988;
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	/*
    // 初始化基本要用到东西.
    [YIInitUtil loadBaseInit];

//    // 初始化网络配置
//    [self initNetConfig];
//
//    // 初始化图片缓存
//    [self initImageConfig];

//    // 初始化友盟统计插件
//    [self initUMeng:launchOptions];

//    // 初始化全局数据
//    [self initGlobalData];

    // 注册错误处理通知
    [self registerErrorHandleNotification];

    // 加载其他的任务
    [self loadOtherTasks:launchOptions];

    // 启动定位
//    [self startLocation];

    // 获取运营商的信息
    [self carrierOperator];

//     加载AVOSCloud
//    [self loadAVOSCloud:launchOptions];

    // 心跳
//    [self startHeartBeat];

    [self loadShortcutItems];

	 */

    return YES;
}

#pragma mark -

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // todo ...
//	return [self loadTempViewController];

    [self checkShortcutItem:launchOptions];

    // 加载应用
    [self loadMainViewController];

//	[[YISplashScreen new] loadSplashScreen2];

    // 动态闪屏图
    if (!mGlobalData.notShowSplashScreen) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            [[YISplashScreen new] loadSplashScreen];
        }
    }

    return YES;
}

- (BOOL)loadTempViewController {
	UIViewController *vc = [UIViewController new];
	vc.view.backgroundColor = [UIColor redColor];
	YIBaseNavigationController *mainNc = [[YIBaseNavigationController alloc] initWithRootViewController:vc];
	self.window = [[UIWindow alloc] initWithFrame:mScreenBounds];
	[self.window setRootViewController:mainNc];
	[self.window makeKeyAndVisible];
	return YES;
}

#pragma mark - 初始化工作开始

- (void)loadShortcutItems {
    if ([UIMutableApplicationShortcutItem class]) {
        //创建快捷item的icon 即UIApplicationShortcutItemIconFile
        UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"flashlight64"];

        //创建快捷item的userinfo 即UIApplicationShortcutItemUserInfo
        NSDictionary *info1 = @{@"url" : @"xiaojia://flashlight"};

        NSString *subTitle;
        mGlobalData.flashlight = [YIFlashlight sharedInstance];
        if (mGlobalData.flashlight.type == FlashlightTypeFlash) {
            subTitle = @"闪光灯照明";
        } else if (mGlobalData.flashlight.type == FlashlightTypeScreen) {
            subTitle = @"屏幕光照明";
        }

        //创建ShortcutItem
        UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc] initWithType:@"3dtouch.flashlight"
                                                                                          localizedTitle:@"手电筒"
                                                                                       localizedSubtitle:subTitle
                                                                                                    icon:icon1
                                                                                                userInfo:info1];

        [UIApplication sharedApplication].shortcutItems = @[item1];
    }
}

- (void)loadAVOSCloud:(NSDictionary *)launchOptions {


}

// http://blog.csdn.net/decajes/article/details/41807977
- (void)carrierOperator {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *mCarrier = [NSString stringWithFormat:@"%@", [carrier carrierName]];
//    mGlobalData.carrier = mCarrier;
}

#pragma mark 定位

- (void)startLocation {
    // 判断定位操作是否被允许
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [_locationManager requestAlwaysAuthorization];
        }
        // 开始定位
        [_locationManager startUpdatingLocation];
    } else {
        // 提示用户无法进行定位操作
    }
}

/*
//定位代理经纬度回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [manager stopUpdatingLocation];
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    
    CLLocationCoordinate2D coor = currentLocation.coordinate;
    NSString *latitude = [NSString stringWithFormat:@"%.8f", coor.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%.8f", coor.longitude];
    
    mGlobalData.latitude = latitude;
    mGlobalData.longitude = longitude;
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:currentLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       for (CLPlacemark *placemark in placemarks) {
                           NSDictionary *address = [placemark addressDictionary];
                           
                           mGlobalData.country = [address objectForKey:@"Country"];
                           mGlobalData.province = [address objectForKey:@"City"];
                           mGlobalData.city = [address objectForKey:@"State"];
                           mGlobalData.district = [address objectForKey:@"SubLocality"];
                           mGlobalData.street = [address objectForKey:@"Street"];
                       }
                   }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}
 */

#pragma mark 其他

- (void)loadOtherTasks:(NSDictionary *)launchOptions {
    // 1，统计启动次数
    NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotification) {
        [MobClick event:UMENG_EVENT_CLICK_REMOTE_NOTIFICATION];
    } else {
        [MobClick event:UMENG_EVENT_CLICK_APP_ICON];
    }
}

#pragma mark 心跳记录

- (void)startHeartBeat {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60.0
                                                      target:self
                                                    selector:@selector(timerFire)
                                                    userInfo:nil
                                                     repeats:YES];
    [timer fire];
}

/*
- (void)timerFire {
    AVQuery *query = [LCClientEntity query];
    [query whereKey:@"idfv" equalTo:[UIDevice vendorId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        LCClientEntity *bm = nil;
        if (error || objects == nil || objects.count == 0) {
            bm = [LCClientEntity object];
        } else {
            LCClientEntity *object = objects[0];
            bm = [LCClientEntity objectWithoutDataWithObjectId:object.objectId];
        }
        
        bm.appVersion = [YICommonUtil appVersion];
        bm.appChannel = [YIConfigUtil channelName];
        bm.osName = [UIDevice systemName];
        bm.osVersion = [UIDevice systemVersion];
        bm.deviceModel = [UIDevice deviceModel];
        bm.idfv = [UIDevice vendorId];
//        bm.deviceToken = [mGlobalData deviceToken];
//        bm.netType = [mGlobalData netType];
//        bm.provider = [mGlobalData carrier];
//        bm.country = [mGlobalData country];
//        bm.province = [mGlobalData province];
//        bm.city = [mGlobalData city];
//        bm.district = [mGlobalData district];
//        bm.street = [mGlobalData street];
//        bm.longitude = [mGlobalData longitude];
//        bm.latitude = [mGlobalData latitude];
        bm.resolutionWidth = [NSString stringWithFormat:@"%f", [UIScreen DPISize].width];
        bm.resolutionHeight = [NSString stringWithFormat:@"%f", [UIScreen DPISize].height];
        [bm saveInBackground];
    }];
}
 

#pragma mark 初始化网络

- (void)initNetConfig {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [YINetworkManager startMonitoring];
}

#pragma mark init image config

- (void)initImageConfig {
    [SDImageCache sharedImageCache].maxCacheAge = 3 * 30 * 24 * 60 * 60;
    [SDImageCache sharedImageCache].maxCacheSize = 100 * 1024 * 1024;
}
 */

#pragma mark init global data

- (void)initGlobalData {
    // 从User Default加载参数进内存
    [mGlobalData loadDefaultValue];

    // 清理所有缓存数据
//    NSString *curVersionCode = [YICommonUtil appVersion];
//    if (![mGlobalData.savedVersionCode isEqualToString:curVersionCode]) {
//        [LCClientEntity clearAllCacheData];
//        [mGlobalData setSavedVersionCode:curVersionCode];
//    }
}

#pragma mark init UMeng

- (void)initUMeng:(NSDictionary *)launchOptions {
//    [MobClick startWithAppkey:UMENG_APP_KEY reportPolicy:SEND_INTERVAL channelId:[YICommonUtil channelName]];
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    [MobClick setAppVersion:version];
//
//    // 友盟反馈
//    [UMFeedback setAppkey:UMENG_APP_KEY];

    /*
     友盟通知 暂不用

    if (IOS_8_OR_LATER) {
        //register remoteNotification types
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序

        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;

        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];

        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];

        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
    } else {
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    }
     */

    /*
    [UMessage setLogEnabled:YES];
    
    // 关闭状态时点击反馈消息进入反馈页
    NSDictionary *notificationDict = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    [UMFeedback didReceiveRemoteNotification:notificationDict];
    [[UMFeedback sharedInstance] setFeedbackViewController:nil shouldPush:YES];
    
    [self.window.rootViewController presentViewController:[UMFeedback feedbackViewController] animated:YES completion:NULL];
     */
}

#pragma mark 注册错误处理通知

- (void)registerErrorHandleNotification {
    // 注册ServerErrorCode通知
    [mNotificationCenter addObserver:self
                            selector:@selector(handleAppError:)
                                name:APP_ERROR_HANDLE_NOTIFICATION
                              object:nil];
}

#pragma mark Notification - 处理错误

- (void)handleAppError:(NSNotification *)notification {
    NSError *error = [notification object];//获取到传递的对象
    NSInteger errorCode = error.code;
    NSString *errorMsg = [error userInfo][NSLocalizedDescriptionKey];
//    [MobClick event:EMMA_HANDLE_ERROR attributes:@{@"error_code": @(errorCode), @"error_msg" : errorMsg}];

    switch (errorCode) {
        case ErrorCodeTokenExpired: {
            [TSMessage showNotificationWithTitle:@"请重新登录账号"
                                        subtitle:errorMsg
                                            type:TSMessageNotificationTypeWarning];
            mGlobalData.login = NO;
            [mNotificationCenter postNotificationName:TOGGLE_LOGIN_STATUS_NOTIFICATION object:nil];
            break;
        }
        case ErrorCodeNeedUpdate: {
            NSString *title = [NSString stringWithFormat:@"%@更新啦，升级赚大钱吧~", [YICommonUtil appName]];
            [TSMessage showNotificationWithTitle:title
                                            type:TSMessageNotificationTypeWarning];
            break;
        }
        case ErrorCodeNetworkNotReachable:
        case ErrorCodeServerDown:
        default: {
            if (errorMsg.isOK) {
                [TSMessage showNotificationWithTitle:errorMsg
                                                type:TSMessageNotificationTypeWarning];
            } else {
                [TSMessage showNotificationWithTitle:@"请稍后再试"
                                                type:TSMessageNotificationTypeWarning];
            }
            break;
        }
    }
}

#pragma mark ViewController调度

// 加载引导页
- (void)loadWelcomeViewController {
//    UIViewController *welcomeVC = [[YIWelcomeVc alloc] init];
//    [self.window.rootViewController addChildViewController:welcomeVC];
//    [self.window.rootViewController.view addSubview:welcomeVC.view];

    mGlobalData.isLaunched = YES;
}

- (void)checkShortcutItem:(NSDictionary *)launchOptions {
    if ([UIApplicationShortcutItem class]) {
        // 3D touch 检测
        UIApplicationShortcutItem *item = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf) {
                [strongSelf actionWithShortcutItem:item];
            }
        });
    }
}

- (void)loadMainViewController {
//	YIMosaicsVc *vc = [[YIMosaicsVc alloc] init];
//	YIBlurVc *vc = [[YIBlurVc alloc] init];
    YIIndexVc *vc = [[YIIndexVc alloc] init]; // todo ...
//	UIViewController *vc = [UIViewController new];
    YIBaseNavigationController *mainNc = [[YIBaseNavigationController alloc] initWithRootViewController:vc];
    self.window = [[UIWindow alloc] initWithFrame:mScreenBounds];
    [self.window setRootViewController:mainNc];
    [self.window makeKeyAndVisible];
}

/*
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_seleced_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"tabbar_icon_zhaobiao", @"tabbar_icon_yunli", @"tabbar_icon_zhanghu"];
    NSArray *tabBarItemTitles = @[@"宝记", @"宝宝列表", @"我的"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unselectedImage];
        NSDictionary *textAttributes = nil;
        textAttributes = @{NSForegroundColorAttributeName : kAppColorMain};
        [item setSelectedTitleAttributes:textAttributes];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        index++;
    }
}
 */


/*
#pragma mark 初始化工作完毕
#pragma mark - RDVTabBarControllerDelegate
- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController; {
    return YES;
}

- (void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController; {
    
}
 */

#pragma mark - iCloud、预览文件 功能相关的代码在这里

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options {
	
    [self previewDocument:url];

    /*
    // 文件名
    NSString *path = [url absoluteString];
    NSString *name = [[path lastPathComponent] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSDate *date = [NSDate date];
    NSTimeInterval interval = date.timeIntervalSince1970;
    NSString *time = [@(interval) stringValue];
    NSString *uuid = [[NSUUID UUID] UUIDString];

    NSMutableString *fileName = [NSMutableString string];
    [fileName appendString:time];
    [fileName appendString:@"-"];
    [fileName appendString:uuid];
    [fileName appendString:@"-"];
    [fileName appendString:name];

    // 保存文件
    NSData *fileData = [NSData dataWithContentsOfURL:url];
    NSString *filePath= [[self localFilePath] stringByAppendingPathComponent:fileName];
    //	BOOL ok = [fileData writeToFile:filePath atomically:YES];
    NSError *error;
    BOOL ooook = [fileData writeToFile:filePath options:NSDataWritingAtomic error:&error];

    // 读取文件
    NSData *data=[NSData dataWithContentsOfFile:filePath options:0 error:NULL];

    //	// iCloud
    //	UIDocument *document = [[UIDocument alloc] initWithFileURL:url];
    //	[document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
    //		NSLog(@"success = %d", success);
    //	}];
     */

    [self syncFileToIcloudDrive:url];

    return YES;
}

- (void)syncFileToIcloudDrive:(NSURL *)url {
    // Let's get the root directory for storing the file on iCloud Drive
    [self rootDirectoryForICloud:^(NSURL *ubiquityURL) {
        NSLog(@"1. ubiquityURL = %@", ubiquityURL);
        if (ubiquityURL) {
            // We also need the 'local' URL to the file we want to store
            NSURL *localURL = url;//[self localPathForResource:@"demo" ofType:@"pdf"];
            NSLog(@"2. localURL = %@", localURL);

            // Now, append the local filename to the ubiquityURL
            ubiquityURL = [ubiquityURL URLByAppendingPathComponent:localURL.lastPathComponent];
            NSLog(@"3. ubiquityURL = %@", ubiquityURL);

            // And finish up the 'store' action
            NSError *error;
            if (![[NSFileManager defaultManager] setUbiquitous:YES itemAtURL:localURL destinationURL:ubiquityURL error:&error]) {
                NSLog(@"Error occurred: %@", error);
            }
        }
        else {
            NSLog(@"Could not retrieve a ubiquityURL");
        }
    }];
}

- (void)rootDirectoryForICloud:(void (^)(NSURL *))completionHandler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *rootDirectory = [[[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil] URLByAppendingPathComponent:@"Documents"];

        if (rootDirectory) {
            if (![[NSFileManager defaultManager] fileExistsAtPath:rootDirectory.path isDirectory:nil]) {
                NSLog(@"Create directory");
                [[NSFileManager defaultManager] createDirectoryAtURL:rootDirectory withIntermediateDirectories:YES attributes:nil error:nil];
            }
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(rootDirectory);
        });
    });
}

- (NSURL *)localPathForResource:(NSString *)resource ofType:(NSString *)type {
    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *resourcePath = [[documentsDirectory stringByAppendingPathComponent:resource] stringByAppendingPathExtension:type];
    return [NSURL fileURLWithPath:resourcePath];
}

- (void)previewDocument:(NSURL *)url {
    // 预览文件
    UIDocumentInteractionController *controller = [UIDocumentInteractionController interactionControllerWithURL:url];
    controller.delegate = self;
    [controller presentPreviewAnimated:YES];
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self.window.rootViewController;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller {
    return self.window.rootViewController.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller {
    return self.window.rootViewController.view.frame;
}

#pragma mark - APNS Notification

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    mGlobalData.deviceToken = [deviceToken hexadecimalString];

    NSLog(@"推送注册成功: Device Token is %@", mGlobalData.deviceToken);

    // 友盟
    [UMessage registerDeviceToken:deviceToken];
    [UMessage addAlias:[UMFeedback uuid] type:[UMFeedback messageType] response:^(id responseObject, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error);
            NSLog(@"%@", responseObject);
        }
    }];

    /*
    // AVOSCLOUD
    AVInstallation *currentInstallation = [AVInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
	 */
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"推送注册失败: Error is %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"=== 收到推送通知 ===");

//    int notificationType = [userInfo[@"t"] intValue];
//    NSDictionary *aps = userInfo[@"aps"];
//    id alert = aps[@"alert"];
//    NSString *message = nil;
}

#pragma mark - 3D touch 回调

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL succeeded))completionHandler NS_AVAILABLE_IOS(9_0); {
    if (shortcutItem) {
        [self actionWithShortcutItem:shortcutItem];
    }

    if (completionHandler) {
        completionHandler(YES);
    }
}

- (void)actionWithShortcutItem:(UIApplicationShortcutItem *)item {
    if ([item.type isEqualToString:@"3dtouch.flashlight"]) {
        if (mGlobalData.flashlight.type == FlashlightTypeFlash) {
            [[TorchObject sharedInstance] setTorchOn:YES];
        } else if (mGlobalData.flashlight.type == FlashlightTypeScreen) {
            [[UIScreen mainScreen] setBrightness:1.0];
        }
    }
}

/*
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [AVOSCloudSNS handleOpenURL:url];
}
 */

#pragma mark -

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

    if (mGlobalData.flashlight) {
        if (mGlobalData.flashlight.type == FlashlightTypeScreen) {
            [[UIScreen mainScreen] setBrightness:mGlobalData.flashlight.brightness];
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    // 手电筒回设为默认值
//	if (mGlobalData.flashlight) {
//		if (mGlobalData.flashlight.type == FlashlightTypeFlash) {
//			[[TorchObject sharedInstance] setTorchOn:NO];
//		} else if (mGlobalData.flashlight.type == FlashlightTypeScreen) {
//			CGFloat bb = mGlobalData.flashlight.brightness;
//			[[UIScreen mainScreen] setBrightness:mGlobalData.flashlight.brightness];
//		}
//	}

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSInteger num = application.applicationIconBadgeNumber;
    if (num != 0) {
        /*
        AVInstallation *currentInstallation = [AVInstallation currentInstallation];
        [currentInstallation setBadge:0];
        [currentInstallation saveEventually];
         */
        application.applicationIconBadgeNumber = 0;
    }
    [application cancelAllLocalNotifications];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.buerguo.BaoBaoJi" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BaoBaoJi" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }

    // Create the coordinator and store

    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BaoBaoJi.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
