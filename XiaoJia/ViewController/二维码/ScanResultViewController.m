//
//  ScanResultViewController.m
//  LBXScanDemo
//
//  Created by lbxia on 15/11/17.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "ScanResultViewController.h"
#import "TOWebViewController.h"

@interface ScanResultViewController ()

@property(weak, nonatomic) IBOutlet UIImageView *scanImg;
@property(weak, nonatomic) IBOutlet UILabel *labelScanText;
@property(weak, nonatomic) IBOutlet UILabel *labelScanCodeType;

@property(weak, nonatomic) IBOutlet UILabel *lblOfCanOperate;
@property(weak, nonatomic) IBOutlet UILabel *lblOfCanOperateTitle;
@end

@implementation ScanResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [YICommonUtil appName];

    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    if ([_strScan hasPrefix:@"http"]) {
        _lblOfCanOperate.hidden = NO;
        _lblOfCanOperateTitle.hidden = NO;

        _lblOfCanOperate.text = _strScan;
        _lblOfCanOperate.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toPreviewWebPage)];
        [_lblOfCanOperate addGestureRecognizer:tap];
    } else {
        _lblOfCanOperate.hidden = YES;
        _lblOfCanOperateTitle.hidden = YES;
    }

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    _scanImg.image = _imgScan;
    _labelScanText.text = _strScan;
    _labelScanCodeType.text = [NSString stringWithFormat:@"码的类型:%@", _strCodeType];
}

- (void)toPreviewWebPage {
    TOWebViewController *vc = [[TOWebViewController alloc] initWithURLString:_strScan];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
