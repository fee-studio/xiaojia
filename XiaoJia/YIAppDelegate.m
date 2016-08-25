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
	

    return YES;
}

#pragma mark -

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // todo ...
//	return [self loadTempViewController];


	[self callThisInDidFinishLaunching];

	NSString *myDeviceId = [CloudPushSDK getDeviceId];
	NSLog(@"my deivce id === %@", myDeviceId);
	
	NSLog(@"收到通知一条1");
	// 打印自定义参数
	NSLog(@"自定义参数为 ： %@",launchOptions);
	
	[self registerAPNS:application :launchOptions];
	[self init_tae];
	
	// 同时监听网络连接
	[self listenerOnChannelOpened];
	[self registerMsgReceive];
	
	
	
	
	
	
	
	
	
	
	
	

	//设置 AppKey 及 LaunchOptions
	[UMessage startWithAppkey:@"56bd835ce0f55ac2400003b4" launchOptions:launchOptions];
	//1.3.0版本开始简化初始化过程。如不需要交互式的通知，下面用下面一句话注册通知即可。
	[UMessage registerForRemoteNotifications];
	//for log
	[UMessage setLogEnabled:YES];
	
	// 检测3DTouch快捷键支持
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

#pragma mark - apns

// ====================================== SDK Method. ==================================
#pragma mark 初始化服务
- (void)init_tae{
	
	//sdk初始化
//	[[ALBBSDK sharedInstance] setDebugLogOpen:TRUE];// 测试时打开
	[[ALBBSDK sharedInstance] asyncInit:^{
		NSLog(@"======================> 初始化成功");
		/*
		 VIP
		 在后台做推送测试的时候，
		 注意不是用这个device id,
		 在log里面找一个叫realDeviceId的才可以测试成功。
		 好郁闷~
		 不过，
		 后来发现这个也可以用。操
		 */
		NSLog(@"======================> DeviceID：%@", [CloudPushSDK getDeviceId]);
	}failure:^(NSError *error) {
		NSLog(@"======================> 初始化失败:%@",error);
	}];
}

- (void) listenerOnChannelOpened {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChannelOpened:) name:@"CCPDidChannelConnectedSuccess" object:nil]; // 注册
}

#pragma mark 注册苹果的推送
-(void) registerAPNS :(UIApplication *)application :(NSDictionary *)launchOptions{
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
	{
		// iOS 8 Notifications
		[application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
		[application registerForRemoteNotifications];
	}
	else
	{
		// iOS < 8 Notifications
		[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
	}
	[CloudPushSDK handleLaunching:launchOptions]; // 作为 apns 消息统计
}

#pragma mark 注册接收CloudChannel推送下来的消息
- (void) registerMsgReceive {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMessageReceived:) name:@"CCPDidReceiveMessageNotification" object:nil]; // 注册
}

#pragma mark 推送下来的消息抵达的处理示例
- (void)onChannelOpened:(NSNotification *)notification {
//	[MsgToolBox showAlert:@"温馨提示" content:@"消息通道建立成功"];
	NSLog(@"温馨提示---消息通道建立成功");
}

// 推送下来的消息抵达的处理示例（上线前如果不使用消息，则不要此外代码））
- (void)onMessageReceived:(NSNotification *)notification {
	NSData *data = [notification object];
	NSString *message = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
	// 报警提示
	if(![NSThread isMainThread])
	{
		dispatch_async(dispatch_get_main_queue(), ^{
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"有消息抵达" message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
			[alertView show];
		});
	} else {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"有消息抵达" message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
		[alertView show];
	}
}


/**
 *  您需要在-[AppDelegate application:didFinishLaunchingWithOptions:]中第一时间设置此回调
 *  在IMSDK截获到Push通知并需要您处理Push时，IMSDK会自动调用此回调
 */
- (void)exampleHandleAPNSPush
{
	
	__weak typeof(self) weakSelf = self;
	
	[[[YWAPI sharedInstance] getGlobalPushService] addHandlePushBlockV4:^(NSDictionary *aResult, BOOL *aShouldStop) {
		
		NSLog(@"冯夷夷 handle apns push");
		
		BOOL isLaunching = [aResult[YWPushHandleResultKeyIsLaunching] boolValue];
		UIApplicationState state = [aResult[YWPushHandleResultKeyApplicationState] integerValue];
		NSString *conversationId = aResult[YWPushHandleResultKeyConversationId];
		Class conversationClass = aResult[YWPushHandleResultKeyConversationClass];
		
		
		if (conversationId.length <= 0) {
			return;
		}
		
		if (conversationClass == NULL) {
			return;
		}

//		if (isLaunching) {
//			/// 用户划开Push导致app启动
//			
//			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//				if ([self exampleIsPreLogined]) {
//					/// 说明已经预登录成功
//					YWConversation *conversation = nil;
//					if (conversationClass == [YWP2PConversation class]) {
//						conversation = [YWP2PConversation fetchConversationByConversationId:conversationId creatIfNotExist:YES baseContext:weakSelf.ywIMKit.IMCore];
//					} else if (conversationClass == [YWTribeConversation class]) {
//						conversation = [YWTribeConversation fetchConversationByConversationId:conversationId creatIfNotExist:YES baseContext:weakSelf.ywIMKit.IMCore];
//					}
//					if (conversation) {
//						[weakSelf exampleOpenConversationViewControllerWithConversation:conversation fromNavigationController:[weakSelf conversationNavigationController]];
//					}
//				}
//			});
//			
//		} else {
//			/// app已经启动时处理Push
//			
//			if (state != UIApplicationStateActive) {
//				if ([self exampleIsPreLogined]) {
//					/// 说明已经预登录成功
//					YWConversation *conversation = nil;
//					if (conversationClass == [YWP2PConversation class]) {
//						conversation = [YWP2PConversation fetchConversationByConversationId:conversationId creatIfNotExist:YES baseContext:weakSelf.ywIMKit.IMCore];
//					} else if (conversationClass == [YWTribeConversation class]) {
//						conversation = [YWTribeConversation fetchConversationByConversationId:conversationId creatIfNotExist:YES baseContext:weakSelf.ywIMKit.IMCore];
//					}
//					if (conversation) {
//						[weakSelf exampleOpenConversationViewControllerWithConversation:conversation fromNavigationController:[weakSelf conversationNavigationController]];
//					}
//				}
//			} else {
//				/// 应用处于前台
//				/// 建议不做处理，等待IM连接建立后，收取离线消息。
//			}
//		}
	} forKey:self.description ofPriority:YWBlockPriorityDeveloper];
}

/**
 *  程序完成启动，在appdelegate中的 application:didFinishLaunchingWithOptions:一开始的地方调用
 */
- (void)callThisInDidFinishLaunching
{
	// 云推送
#if DEBUG
	[[[YWAPI sharedInstance] getGlobalPushService] setXPushCertName:@"sandbox"];
#else
	[[[YWAPI sharedInstance] getGlobalPushService] setXPushCertName:@"production"];
#endif
	
	if ([self exampleInit]) {
		// 在IMSDK截获到Push通知并需要您处理Push时，IMSDK会自动调用此回调
		[self exampleHandleAPNSPush];

		// 在IMSDK收到反馈消息通知时，IMSDK会自动调用此回调
		[self exampleListenFeedbackNewMessage];
	} else {
		/// 初始化失败，需要提示用户
		UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"错误" message:@"SDK初始化失败, 请检查网络后重试" delegate:self cancelButtonTitle:@"重试" otherButtonTitles:nil];
		[av show];
	}
}

/**
 *  初始化示例代码
 */
- (BOOL)exampleInit;
{
	/// 开启日志
	[[YWAPI sharedInstance] setLogEnabled:YES];
	
	NSLog(@"SDKVersion:%@", [YWAPI sharedInstance].YWSDKIdentifier);
	
	NSError *error = nil;
	
	/// 异步初始化IM SDK
	// 设置环境，开发者可以不设置。默认是 线上环境 YWEnvironmentRelease
	// todo ...
//	[[YWAPI sharedInstance] setEnvironment:[self lastEnvironment].intValue];
//	[[YWAPI sharedInstance] setEnvironment:YWEnvironmentSandBox];
	[[YWAPI sharedInstance] setEnvironment:YWEnvironmentRelease];
	
	if ([self lastEnvironment].intValue == YWEnvironmentRelease || [self lastEnvironment].intValue == YWEnvironmentPreRelease) {
		//#warning TODO: CHANGE TO YOUR AppKey
		/// 线上环境，更换成你自己的AppKey
		[[YWAPI sharedInstance] syncInitWithOwnAppKey:@"23437490" getError:&error];
	} else {
		// OpenIM内网环境，暂时不向开发者开放，需要测试环境的，自行申请另一个Appkey作为测试环境
		//        [[YWAPI sharedInstance] syncInitWithOwnAppKey:@"4272" getError:&error];
		[[YWAPI sharedInstance] syncInitWithOwnAppKey:@"23437490" getError:&error];
	}
	
	if (error.code != 0 && error.code != YWSdkInitErrorCodeAlreadyInited) {
		/// 初始化失败
		return NO;
	} else {
		if (error.code == 0) {
			/// 首次初始化成功
			/// 获取一个IMKit并持有
			self.ywIMKit = [[YWAPI sharedInstance] fetchIMKitForOpenIM];
			[[self.ywIMKit.IMCore getContactService] setEnableContactOnlineStatus:YES];

            [self.ywIMKit setFetchProfileForPersonBlock:^(YWPerson *aPerson, YWTribe *aTribe, YWProfileProgressBlock aProgressBlock, YWProfileCompletionBlock aCompletionBlock) {
                if (aPerson.personId.length == 0) {
                    return;
                }

                /// 如果你接入使用反馈功能并希望能够自定义显示头像，可参考如下实现：
                /// 登陆反馈请替换使用YWFeedbackServiceForIMCore(self.ywIMKit.IMCore)，并只需拦截FeedbackReceiver
                if ([YWAnonFeedbackService isFeedbackSender:aPerson]) {
                    YWProfileItem *item = [YWProfileItem new];
                    item.person = aPerson;
                    item.avatar = [UIImage imageNamed:@"icloud-icon"];
                    aCompletionBlock(YES, item);
                    return;
                } else if ([YWAnonFeedbackService isFeedbackReceiver:aPerson]) {
                    YWProfileItem *item = [YWProfileItem new];
                    item.person = aPerson;
                    item.displayName = @"您好, 请直言";
                    item.avatar = [UIImage imageNamed:@"icon_120"];
                    aCompletionBlock(YES, item);
                    return;
                }

                /// Demo中模拟了异步获取Profile的过程，你需要根据实际情况，从你的服务器获取用户profile
                YWProfileItem *item = [YWProfileItem new];
                item.person = aPerson;
                // 如果先获取了部分信息，那么可以通过aProgressBlock回调，可以回调多次
                item.displayName = @"我是昵称";
                aProgressBlock(item);

                // 异步获取其他信息
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    // 获取全部信息，通过aCompletionBlock回调，第一个参数为YES时更新缓存，aCompletionBlock只能回调一次，一旦回调后请不要使用aCompletionBlock或者aProgressBlock回调。
                    item.avatar = [UIImage imageNamed:@"demo_head_120"];
                    aCompletionBlock(YES, item);
                });
            }];


        } else {
			/// 已经初始化
		}
		return YES;
	}
}

- (NSNumber *)lastEnvironment
{
	NSNumber *environment = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastEnvironment"];
	if (environment == nil) {
		return @(YWEnvironmentRelease);
	}
	return environment;
}

- (void)exampleListenFeedbackNewMessage
{
	NSLog(@"匿名账号消息监听");
	__weak typeof(self) weakSelf = self;
	/// 这里演示的是匿名账号消息监听，云旺账号参考exampleListenNewMessage
	[YWAnonFeedbackService setOnNewMessageBlock:^(BOOL aIsLaunching, UIApplicationState aState) {
		if ( aIsLaunching || aState != UIApplicationStateActive ) {
			[YWAnonFeedbackService makeFeedbackConversationWithCompletionBlock:^(YWFeedbackConversation *conversation, NSError *error) {
				NSLog(@"继续再往下做。");
//				[weakSelf exampleOpenFeedbackViewController:YES fromViewController:weakSelf.window.rootViewController];
			}];
		} else {
			/// 播放声音或者跳转打开反馈页面等方式提醒用户有新的反馈消息
			NSLog(@"继续再往下做。。。。");
		}
	}];
	
	

//	__weak typeof(self) weakSelf = self;
//	/// 这里演示的是匿名账号消息监听，云旺账号反馈请参考exampleListenNewMessage和exampleHandleAPNSPush
//	[YWAnonFeedbackService setOnNewMessageBlock:^(BOOL aIsLaunching, UIApplicationState aState) {
//		if ( aIsLaunching || aState != UIApplicationStateActive ) {
//			[YWAnonFeedbackService makeFeedbackConversationWithCompletionBlock:^(YWFeedbackConversation *conversation, NSError *error) {
//				[weakSelf exampleOpenFeedbackViewController:YES fromViewController:[weakSelf rootNavigationController]];
//			}];
//		} else {
//			/// 播放声音或者跳转打开反馈页面等方式提醒用户有新的反馈消息
//		}
//	}];
}


- (BOOL)openIMInit;
{
//	/// 设置环境
//	[[YWAPI sharedInstance] setEnvironment:YWEnvironmentRelease];
//	/// 开启日志
//	[[YWAPI sharedInstance] setLogEnabled:YES];
// 
//	NSLog(@"SDKVersion:%@", [YWAPI sharedInstance].YWSDKIdentifier);
// 
//	NSError *error = nil;
// 
//	/// 异步初始化IM SDK
//	[[YWAPI sharedInstance] syncInitWithOwnAppKey:@"23437490" getError:&error];
// 
//	if (error.code != 0 && error.code != YWSdkInitErrorCodeAlreadyInited) {
//		/// 初始化失败
//		return NO;
//	} else {
//		if (error.code == 0) {
//			/// 首次初始化成功
//			/// 获取一个IMKit并持有
//			self.ywIMKit = [[YWAPI sharedInstance] fetchIMKitForOpenIM];
//		} else {
//			/// 已经初始化
//		}
//		return YES;
//	}
	
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

#pragma mark - iCloud、预览文件 功能相关的代码在这里 & 微信分享回调

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options {
	NSString *scheme = [url scheme];
	// 只有在file回调时候才能这样
	if ([scheme isEqualToString:@"file"]) {
		[self previewDocument:url];
		[self syncFileToIcloudDrive:url];
	}

	return YES;
	
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
	// 关键
	[CloudPushSDK registerDevice:deviceToken];

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
	[UMessage didReceiveRemoteNotification:userInfo];
	
//    int notificationType = [userInfo[@"t"] intValue];
//    NSDictionary *aps = userInfo[@"aps"];
//    id alert = aps[@"alert"];
//    NSString *message = nil;
	
	/// app open
	
	NSLog(@"收到通知一条2~");
	// 打印自定义参数
	NSLog(@"自定义参数为 ： %@",userInfo);
	
	[CloudPushSDK handleReceiveRemoteNotification:userInfo];

}

/// iOS8下申请DeviceToken
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
	if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)]) {
		[[UIApplication sharedApplication] registerForRemoteNotifications];
	}
}
#endif

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
