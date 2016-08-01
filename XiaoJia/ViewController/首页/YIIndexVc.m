//
//  YIIndexVc.m
//  YIBox
//
//  Created by efeng on 16/1/31.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "YIIndexVc.h"
#import "LBXScanViewStyle.h"
#import "SubLBXScanViewController.h"
#import "YIShareUtil.h"
#import "iVersion.h"
#import "YIPrivatePhotoVc.h"
#import "YIPasswordManager.h"


@interface YIIndexVc () <UIDocumentPickerDelegate> {
    PPSEnterHideState curPrivatePhotoEnterState; // 当前私密照入口的状态
}

@property(nonatomic, strong) NSArray *tools;

@end

@implementation YIIndexVc

- (instancetype)init {
    self = [super init];
    if (self) {
    }

    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];




//	UIImageView *bgIv = [UIImageView new];
//	bgIv.image = [UIImage imageNamed:@"launch_bg2"];
//	[self.view insertSubview:bgIv atIndex:0];
//	[bgIv mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.edges.equalTo(bgIv.superview);
//	}];

//	self.baseTableView.backgroundColor = [UIColor clearColor];

//	UIBarButtonItem *cancelBBI = [[UIBarButtonItem alloc] initWithTitle:@"取消"
//																style:UIBarButtonItemStylePlain
//															   target:self
//															   action:@selector(cancelButtonTapped:)];
//	self.navigationItem.leftBarButtonItem = cancelBBI;

//	[mNotificationCenter addObserver:self selector:@selector(defaultToolEnter:) name:@"default-tool-enter" object:nil];
//	[mNotificationCenter postNotificationName:@"default-tool-enter" object:nil];

    [self defaultToolEnter:nil];
}

- (void)defaultToolEnter:(id)sender {
    YIBaseViewController *vc;
    if (mGlobalData.homeVc == nil || [mGlobalData.homeVc isEqualToString:NSStringFromClass([self class])]) {
        [mGlobalData setHomeVc:NSStringFromClass([YIIndexVc class])];
    } else {
        Class target = NSClassFromString(mGlobalData.homeVc);
        vc = (YIBaseViewController *) [[target alloc] init];
        [self.navigationController pushViewController:vc animated:NO];
        return;
    }
}

//- (void)cancelButtonTapped:(id)sender {
//	[self dismissViewControllerAnimated:YES completion:nil];
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass(self.class)];
    // 刷新私密照片入口的进入状态
    curPrivatePhotoEnterState = mGlobalData.privateSetting.enterHideState;
    // 刷新列表
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass(self.class)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)loadData {
    /*
    NSString *flashlightDetail = @"";
    if (mGlobalData.flashlight.type == FlashlightTypeScreen) {
        flashlightDetail = @"屏幕光";
    } else if (mGlobalData.flashlight.type == FlashlightTypeFlash) {
        flashlightDetail = @"闪光灯";
    }

    NSArray *willTools =
            @[
                    @[
                            @{
                                    @"id" : @(1001),
                                    @"image" : @"gaosimohu_icon",
                                    @"name" : @"图片-高斯模糊",
                                    @"detail" : @"",
                                    @"target" : NSStringFromClass(YIBlurVc.class)
                            },
                            @{
                                    @"id" : @(1002),
                                    @"image" : @"ninegrid_icon",
                                    @"name" : @"朋友圈-九宫格",
                                    @"detail" : @"",
                                    @"target" : NSStringFromClass(YINineGridVc.class)
                            },
                            @{
                                    @"id" : @(1003),
                                    @"image" : @"flashlight_icon",
                                    @"name" : @"手电筒",
                                    @"detail" : flashlightDetail,
                                    @"target" : NSStringFromClass(YIFlashlightVc.class)
                            },
                            @{
                                    @"id" : @(1004),
                                    @"image" : @"qr_code_icon",
                                    @"name" : @"扫一扫/二维码",
                                    @"detail" : @"",
                                    @"target" : [NSNull null]
                            },
                            @{
                                    @"id" : @(1005),
                                    @"image" : @"calculator_icon",
                                    @"name" : @"竖式计算器",
                                    @"detail" : @"",
                                    @"target" : NSStringFromClass(YICalculatorVc.class)
                            },
                    ],
                    @[
                            @{
                                    @"id" : @(2003),
                                    @"image" : @"setting",
                                    @"name" : @"设置",
                                    @"detail" : @"",
                                    @"target" : [NSNull null]
                            },
                            @{
                                    @"id" : @(2001),
                                    @"image" : @"my_collection",
                                    @"name" : @"去评分",
                                    @"detail" : @"",
                                    @"target" : [NSNull null]
                            },
                            @{
                                    @"id" : @(2002),
                                    @"image" : @"my_share",
                                    @"name" : @"分享是您给我们最大的鼓励",
                                    @"detail" : @"",
                                    @"target" : [NSNull null]
                            },
                            //                            @{
                            //                                    @"id" : @(2003),
                            //                                    @"image" : @"gaosimohu_icon",
                            //                                    @"name" : @"捐赠",
                            //                                    @"detail" : @"",
                            //                                    @"target" : NSStringFromClass(YIDonateVc.class)
                            //                            },
                    ]
            ];
     */


    NSString *pathIndexPlist = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"plist"];
    NSArray *willTools = [NSArray arrayWithContentsOfFile:pathIndexPlist];

    if (curPrivatePhotoEnterState == PPSEnterHideStateClosed) {
        NSDictionary *privatePhoto = @{
                @"id" : @(1008),
                @"image" : @"private_photos",
                @"name" : @"私密照片",
                @"detail" : @"",
                @"target" : NSStringFromClass(YIPrivatePhotoVc.class)
        };

        NSMutableArray *willToolsMa = [NSMutableArray arrayWithArray:willTools];
        NSMutableArray *willToolList = [NSMutableArray arrayWithArray:willToolsMa[0]];
        [willToolList addObject:privatePhoto];
        willToolsMa[0] = willToolList;

        willTools = willToolsMa;
    }

    self.tools = willTools;
    [self.baseTableView reloadData];
}

#pragma mark - table view delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _tools.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tools[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"IndexCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.imageView.image = [UIImage imageNamed:_tools[indexPath.section][indexPath.row][@"image"]];
    cell.textLabel.text = _tools[indexPath.section][indexPath.row][@"name"];
    cell.textLabel.textColor = kAppColorTextDeep;
    cell.detailTextLabel.text = _tools[indexPath.section][indexPath.row][@"detail"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    id targetObject = _tools[indexPath.section][indexPath.row][@"target"];
    NSNumber *itemId = _tools[indexPath.section][indexPath.row][@"id"];
    NSInteger itemIdCode = [itemId integerValue];

    if ([targetObject isEmpty]) {
        if (itemIdCode == 1004) {
            [self openQrCodeVc];
        } else if (itemIdCode == 2001) {
            [[iVersion sharedInstance] openAppPageInAppStore];
        } else if (itemIdCode == 2002) {
            [YIShareUtil toWxShareAppPromotionPage];
        } else if (itemIdCode == 1007) {
            UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc]
                    initWithDocumentTypes:@[@"public.data"]
                                   inMode:UIDocumentPickerModeOpen];

            documentPicker.delegate = self;
            documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
            [self presentViewController:documentPicker animated:YES completion:nil];
        }
    } else {
        if (itemIdCode == 1008) {
            if (mGlobalData.privateSetting.simplePasswordState == PPSSimplePasswordStateOpen
                    && mGlobalData.privateSetting.fingerprintState == PPSFingerprintStateOpen) {
                if ([mGlobalData.privateSetting.simplePassword isEmpty]) {
                    // 设置密码
                    [[YIPasswordManager sharedInstance] createPasscodeViewControllerWithType:BKPasscodeViewControllerNewPasscodeType
                                                                      andCreateCompleteBlock:^(UIViewController *vc) {
                                                                          YIBaseNavigationController *bnc = [[YIBaseNavigationController alloc] initWithRootViewController:vc];
                                                                          [self presentViewController:bnc animated:YES completion:nil];
                                                                      }
                                                                         andDidFinishedBlock:^{
                                                                             YIPrivatePhotoVc *vc = [[YIPrivatePhotoVc alloc] init];
                                                                             [self.navigationController pushViewController:vc animated:YES];
                                                                         }];
                    return;
                } else {
                    [[YIPasswordManager sharedInstance] createPasscodeViewControllerWithType:BKPasscodeViewControllerCheckPasscodeType
                                                                      andCreateCompleteBlock:^(UIViewController *vc) {
                                                                          YIBaseNavigationController *bnc = [[YIBaseNavigationController alloc] initWithRootViewController:vc];
                                                                          [self presentViewController:bnc animated:YES completion:nil];
                                                                      }
                                                                         andDidFinishedBlock:^{
                                                                             YIPrivatePhotoVc *vc = [[YIPrivatePhotoVc alloc] init];
                                                                             [self.navigationController pushViewController:vc animated:YES];
                                                                         }];
                    return;
                }
            } else if (mGlobalData.privateSetting.simplePasswordState == PPSSimplePasswordStateOpen) {
                if ([mGlobalData.privateSetting.simplePassword isEmpty]) {
                    // 设置密码
                    [[YIPasswordManager sharedInstance] createPasscodeViewControllerWithType:BKPasscodeViewControllerNewPasscodeType
                                                                      andCreateCompleteBlock:^(UIViewController *vc) {
                                                                          YIBaseNavigationController *bnc = [[YIBaseNavigationController alloc] initWithRootViewController:vc];
                                                                          [self presentViewController:bnc animated:YES completion:nil];
                                                                      }
                                                                         andDidFinishedBlock:^{
                                                                             YIPrivatePhotoVc *vc = [[YIPrivatePhotoVc alloc] init];
                                                                             [self.navigationController pushViewController:vc animated:YES];
                                                                         }];
                    return;
                } else {
                    [[YIPasswordManager sharedInstance] createPasscodeViewControllerWithType:BKPasscodeViewControllerCheckPasscodeType
                                                                      andCreateCompleteBlock:^(UIViewController *vc) {
                                                                          YIBaseNavigationController *bnc = [[YIBaseNavigationController alloc] initWithRootViewController:vc];
                                                                          [self presentViewController:bnc animated:YES completion:nil];
                                                                      }
                                                                         andDidFinishedBlock:^{
                                                                             YIPrivatePhotoVc *vc = [[YIPrivatePhotoVc alloc] init];
                                                                             [self.navigationController pushViewController:vc animated:YES];
                                                                         }];
                    return;
                }
            } else if (mGlobalData.privateSetting.fingerprintState == PPSFingerprintStateOpen) {

            } else {

            }
        }

        Class target = NSClassFromString(targetObject);
        YIBaseViewController *vc = [[target alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == _tools.count - 1) {
        return 30.f;
    }
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == _tools.count - 1) {
        UILabel *footerLbl = [[UILabel alloc] init];

        if (mGlobalData.privateSetting.promptOnVersion == 1) {
            footerLbl.text = @"点我三下";
            footerLbl.textColor = kAppColorRed;
        } else if (mGlobalData.privateSetting.promptOnVersion == 2) {
            footerLbl.text = @"再点我三下哈";
            footerLbl.textColor = kAppColorMain;
        } else {
            footerLbl.text = [NSString stringWithFormat:@"版本 %@", [YICommonUtil appVersion]];
            footerLbl.textColor = kAppColorTextLight;
        }
        footerLbl.textAlignment = NSTextAlignmentCenter;

        footerLbl.font = kAppSmlFont;
        footerLbl.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(togglePrivatePhoto:)];
        tap.numberOfTapsRequired = 3;
        [footerLbl addGestureRecognizer:tap];
        return footerLbl;
    }
    return nil;
}

#pragma mark -

- (void)togglePrivatePhoto:(UITapGestureRecognizer *)tap {
    curPrivatePhotoEnterState = !curPrivatePhotoEnterState;

    if (mGlobalData.privateSetting.promptOnVersion == 1) {
        mGlobalData.privateSetting.promptOnVersion = 2;
    } else if (mGlobalData.privateSetting.promptOnVersion == 2) {
        mGlobalData.privateSetting.promptOnVersion = 3;
    }
    [mGlobalData.privateSetting saveData];

    [self loadData];
}

#pragma mark - UIDocumentPickerDelegate

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url; {
    [mAppDelegate previewDocument:url];
}

#pragma mark -模仿qq界面

- (void)openQrCodeVc {
    //设置扫码区域参数设置
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc] init];

    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;

    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;

    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;

    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;

    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;

    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;

    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];

    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    vc.isQQSimulator = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
