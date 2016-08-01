//
//  YIFlashlightVc.m
//  YIBox
//
//  Created by efeng on 2/13/16.
//  Copyright © 2016 buerguo. All rights reserved.
//

#import "YIFlashlightVc.h"
#import "SevenSwitch.h"
#import "TorchObject.h"

@interface YIFlashlightVc () {
    UIView *typeView;
    UILabel *titleLbl;

    UIButton *switchBtn;
}
@end

@implementation YIFlashlightVc

- (instancetype)init {
    self = [super init];
    if (self) {

    }

    return self;
}

/* todo ...
 1,手电筒详情页
	1,是否启用(这个可以没有)
	2,启用的方式 屏幕/闪光灯
	3,使用方法/帮助
	4,
 
 
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadFlashlightTypeView];
    [self loadOnOffView];
    [self loadWhyUseMeView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (switchBtn && ![[TorchObject sharedInstance] isTorchOn]) {
        [self switchBtnAction:switchBtn];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (switchBtn && [[TorchObject sharedInstance] isTorchOn]) {
        [self switchBtnAction:switchBtn];
    }
}

- (void)loadWhyUseMeView {
    UILabel *lbl = [[UILabel alloc] init];
    lbl.numberOfLines = 0;
    lbl.textColor = kAppColorTextMid;
    [self.view addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbl.superview).offset(10);
        make.right.equalTo(lbl.superview).offset(-10);
        make.top.equalTo(typeView.mas_bottom).offset(20);
    }];

    lbl.text = @"为什么选择我?\r\t 1,支持3D-Touch的手电筒. \r\t\t\t\t 如果您是iPhone6s系列的手机, 幸运啦. 你可在主屏幕上用力按App的图标, 直接使用手电筒. \r\t 2,两种模式的手电筒可自由切换. \r\t\t\t\t 屏幕光更省电而闪光灯更明亮,可方便切换到自己喜欢的方式哦.";
}

- (void)loadOnOffView {
    switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [switchBtn addTarget:self action:@selector(switchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:switchBtn];
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(mScreenWidth / 2.0);
        make.height.mas_equalTo(mScreenWidth / 2.0);
        make.bottom.equalTo(switchBtn.superview).offset(-50);
        make.centerX.equalTo(switchBtn.superview);

        switchBtn.layer.borderColor = [kAppColorMain CGColor];
        switchBtn.layer.borderWidth = 2.f;
        switchBtn.layer.cornerRadius = mScreenWidth / 2.f / 2.f;
        switchBtn.layer.masksToBounds = YES;
    }];

    titleLbl = [[UILabel alloc] init];
    titleLbl.font = [UIFont systemFontOfSize:25];
    titleLbl.numberOfLines = 0;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = kAppColorMain;
    [switchBtn addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(titleLbl.superview);
    }];

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"打开\r手电筒"];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0, 2)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:NSMakeRange(3, 3)];
    titleLbl.attributedText = str;
}

- (void)switchBtnAction:(UIButton *)btn {
    btn.selected = !btn.selected;

    btn.backgroundColor = btn.selected ? kAppColorMain : [UIColor clearColor];
    titleLbl.textColor = btn.selected ? [UIColor whiteColor] : kAppColorMain;

    if (btn.selected) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"关闭\r手电筒"];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0, 2)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:NSMakeRange(3, 3)];
        titleLbl.attributedText = str;
    } else {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"打开\r手电筒"];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0, 2)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:NSMakeRange(3, 3)];
        titleLbl.attributedText = str;
    }

    if (btn.selected) {
        // 此时是打开的状态
        if (mGlobalData.flashlight.type == FlashlightTypeScreen) {
            [[TorchObject sharedInstance] setTorchOn:NO];
            [[UIScreen mainScreen] setBrightness:1.0f];
        } else if (mGlobalData.flashlight.type == FlashlightTypeFlash) {
            [[TorchObject sharedInstance] setTorchOn:YES];
            [[UIScreen mainScreen] setBrightness:mGlobalData.flashlight.brightness];
        }
    } else {
        // 此时是关闭的状态
        [[UIScreen mainScreen] setBrightness:mGlobalData.flashlight.brightness];
        [[TorchObject sharedInstance] setTorchOn:NO];
    }
}

- (void)loadFlashlightTypeView {
    typeView = [[UIView alloc] init];
    typeView.backgroundColor = kAppColorWhite;
    [self.view addSubview:typeView];
    [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typeView.superview).offset(64 + 20);
        make.left.equalTo(typeView.superview);
        make.width.equalTo(typeView.superview);
        make.height.equalTo(@44);
    }];

    UILabel *label = [[UILabel alloc] init];
    label.text = @"手电筒类型";
    label.textColor = kAppColorTextDeep;
    [typeView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.superview).offset(10);
        make.centerY.equalTo(label.superview);
    }];

    // 开关
    SevenSwitch *mySwitch3 = [[SevenSwitch alloc] initWithFrame:CGRectZero];
    [mySwitch3 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [typeView addSubview:mySwitch3];
    [mySwitch3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mySwitch3.superview).offset(-10);
        make.centerY.equalTo(mySwitch3.superview);
        make.width.equalTo(@80);
        make.height.equalTo(@34);
    }];

    mySwitch3.thumbTintColor = kAppColorWhite;
    mySwitch3.borderColor = mySwitch3.onTintColor = mySwitch3.activeColor = mySwitch3.inactiveColor = kAppColorMain;
    mySwitch3.shadowColor = [UIColor clearColor];

    mySwitch3.onLabel.text = @"屏幕光";
    mySwitch3.onLabel.textColor = kAppColorWhite;
    mySwitch3.offLabel.text = @"闪光灯";
    mySwitch3.offLabel.textColor = kAppColorWhite;

    if (mGlobalData.flashlight.type == FlashlightTypeFlash) {
        [mySwitch3 setOn:NO];
    } else if (mGlobalData.flashlight.type == FlashlightTypeScreen) {
        [mySwitch3 setOn:YES];
    }
}

- (void)switchChanged:(SevenSwitch *)sender {
    NSLog(@"Changed value to: %@", sender.on ? @"ON" : @"OFF");

    if (sender.on) {
        // 当前为屏幕光
        mGlobalData.flashlight.type = FlashlightTypeScreen;
    } else {
        // 当前为闪光灯
        mGlobalData.flashlight.type = FlashlightTypeFlash;
    }

    // 主要为了更新loadShortcutItems方法中subTitle的提示语.
    [mAppDelegate loadShortcutItems];
}


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
