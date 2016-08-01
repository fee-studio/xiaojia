//
//
//
//
//  Created by lbxia on 15/10/21.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "SubLBXScanViewController.h"
#import "MyQRViewController.h"
#import "ScanResultViewController.h"


@interface SubLBXScanViewController ()

@end

@implementation SubLBXScanViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [YICommonUtil appName];

    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    self.view.backgroundColor = [UIColor blackColor];

    UIBarButtonItem *wxScanItem = [[UIBarButtonItem alloc] initWithTitle:@"微信二维码"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(wxScanAction:)];
    self.navigationItem.rightBarButtonItems = @[wxScanItem];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (_isQQSimulator) {
        [self drawBottomItems];
        [self drawTitle];
        [self.view bringSubviewToFront:_topTitle];
    } else {
        _topTitle.hidden = YES;
    }
}

- (void)wxScanAction:(UIBarButtonItem *)item {
    [YIConfigUtil toOpenWxScan];
}

//绘制扫描区域
- (void)drawTitle {
    if (!_topTitle) {
        self.topTitle = [[UILabel alloc] init];
        _topTitle.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 60);
        _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2, CGRectGetHeight(self.view.frame) / 2 + 120);

        //3.5inch iphone
        if ([UIScreen mainScreen].bounds.size.height <= 568) {
            _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2, CGRectGetHeight(self.view.frame) / 2 + 80);
        }

        _topTitle.textAlignment = NSTextAlignmentCenter;
        _topTitle.font = kAppSmlFont;
        _topTitle.numberOfLines = 0;
        _topTitle.text = @"将取景框对准二维码, 即可自动扫描";
        _topTitle.textColor = [UIColor whiteColor];
        [self.view addSubview:_topTitle];
    }
}

- (void)drawBottomItems {
    if (_bottomItemsView) {
        return;
    }

    self.bottomItemsView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame) - 164,
            CGRectGetWidth(self.view.frame), 100)];

    _bottomItemsView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];

    [self.view addSubview:_bottomItemsView];

    CGSize size = CGSizeMake(65, 87);
    self.btnFlash = [[UIButton alloc] init];
    _btnFlash.bounds = CGRectMake(0, 0, size.width, size.height);
    _btnFlash.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame) * 2 / 3, CGRectGetHeight(_bottomItemsView.frame) / 2);
    [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    [_btnFlash addTarget:self action:@selector(openOrCloseFlash) forControlEvents:UIControlEventTouchUpInside];

    self.btnPhoto = [[UIButton alloc] init];
    _btnPhoto.bounds = _btnFlash.bounds;
    _btnPhoto.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame) * 1 / 3, CGRectGetHeight(_bottomItemsView.frame) / 2);
    [_btnPhoto setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_photo_nor"] forState:UIControlStateNormal];
    [_btnPhoto setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_photo_down"] forState:UIControlStateHighlighted];
    [_btnPhoto addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];

//	self.btnMyQR = [[UIButton alloc]init];
//	_btnMyQR.bounds = _btnFlash.bounds;
//	_btnMyQR.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame) * 3/4, CGRectGetHeight(_bottomItemsView.frame)/2);
//	[_btnMyQR setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_myqrcode_nor"] forState:UIControlStateNormal];
//	[_btnMyQR setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_myqrcode_down"] forState:UIControlStateHighlighted];
//	[_btnMyQR addTarget:self action:@selector(myQRCode) forControlEvents:UIControlEventTouchUpInside];

    [_bottomItemsView addSubview:_btnFlash];
    [_bottomItemsView addSubview:_btnPhoto];
//	[_bottomItemsView addSubview:_btnMyQR];

}

- (void)showError:(NSString *)str {
    [LBXAlertAction showAlertWithTitle:@"提示" msg:str chooseBlock:nil buttonsStatement:@"知道了", nil];
}


- (void)scanResultWithArray:(NSArray<LBXScanResult *> *)array {

    if (array.count < 1) {
        [self popAlertMsgWithScanResult:nil];

        return;
    }

    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
    for (LBXScanResult *result in array) {

        NSLog(@"scanResult:%@", result.strScanned);
    }

    LBXScanResult *scanResult = array[0];

    NSString *strResult = scanResult.strScanned;

    self.scanImage = scanResult.imgScanned;

    if (!strResult) {

        [self popAlertMsgWithScanResult:nil];

        return;
    }

    //震动提醒
    [LBXScanWrapper systemVibrate];
    //声音提醒
    [LBXScanWrapper systemSound];


    //[self popAlertMsgWithScanResult:strResult];

    [self showNextVCWithScanResult:scanResult];

}

- (void)popAlertMsgWithScanResult:(NSString *)strResult {
    if (!strResult) {
        strResult = @"未发现二维码/条码";
    }

    __weak __typeof(self) weakSelf = self;
    [LBXAlertAction showAlertWithTitle:@"扫码内容" msg:strResult chooseBlock:^(NSInteger buttonIdx) {
        //点击完，继续扫码
        [weakSelf reStartDevice];
    }                 buttonsStatement:@"知道了", nil];
}

- (void)showNextVCWithScanResult:(LBXScanResult *)strResult {
    ScanResultViewController *vc = [ScanResultViewController new];
    vc.imgScan = strResult.imgScanned;
    vc.strScan = strResult.strScanned;
    vc.strCodeType = strResult.strBarCodeType;
    [self.navigationController pushViewController:vc animated:YES];

//	// todo ...
//	NSString *strScanned = strResult.strScanned;
//	if ([strScanned hasPrefix:@"http"]) {
//		[YIConfigUtil toOpenUrl:strScanned];
//	}

}


#pragma mark -底部功能项

//打开相册
- (void)openPhoto {
    if ([LBXScanWrapper isGetPhotoPermission]) {
        [self openLocalPhoto];
    } else {
        [self showError:@"      请到设置->隐私中开启本程序相册权限     "];
    }
}

//开关闪光灯
- (void)openOrCloseFlash {

    [super openOrCloseFlash];


    if (self.isOpenFlash) {
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_down"] forState:UIControlStateNormal];
    }
    else
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
}


#pragma mark -底部功能项


- (void)myQRCode {
    MyQRViewController *vc = [MyQRViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
