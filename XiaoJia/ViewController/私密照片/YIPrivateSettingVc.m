//
//  YIPrivateSettingVc.m
//  YIBox
//
//  Created by efeng on 16/2/27.
//  Copyright © 2016年 buerguo. All rights reserved.
//

// todo 占了多少空间了。

#import "YIPrivateSettingVc.h"
#import "BKTouchIDManager.h"
#import "YIPasswordManager.h"


@interface YIPrivateSettingVc ()

@property(nonatomic, strong) NSArray *settingData;

@property(strong, nonatomic) UISwitch *enterHideSwitch;
@property(strong, nonatomic) UISwitch *simplePasswordSwitch;
@property(strong, nonatomic) UISwitch *fingerprintPasswordSwitch;

@end

@implementation YIPrivateSettingVc

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadSwitchData];
    [self loadSettingData];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self action:@selector(dismiss:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)dismiss:(UIBarButtonItem *)item {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// 保存Touch Id
- (void)saveTouchIdPassword {
    BKTouchIDManager *touchIDManager = [[BKTouchIDManager alloc] initWithKeychainServiceName:@"BKPasscodeSampleService"];
    if (mGlobalData.privateSetting.fingerprintState) {
        [touchIDManager savePasscode:mGlobalData.privateSetting.simplePassword completionBlock:^(BOOL success) {
            if (success) {
            }
        }];
    } else {
        [touchIDManager deletePasscodeWithCompletionBlock:^(BOOL success) {
            if (success) {
            }
        }];
    }
}

- (void)loadSwitchData {
    self.enterHideSwitch = [[UISwitch alloc] init];
    [self.enterHideSwitch addTarget:self action:@selector(enterHideSwitchAction) forControlEvents:UIControlEventValueChanged];
    self.simplePasswordSwitch = [[UISwitch alloc] init];
    [self.simplePasswordSwitch addTarget:self action:@selector(simplePasswordSwitchAction) forControlEvents:UIControlEventValueChanged];
    self.fingerprintPasswordSwitch = [[UISwitch alloc] init];
    [self.fingerprintPasswordSwitch addTarget:self action:@selector(fingerprintPasswordSwitchAction) forControlEvents:UIControlEventValueChanged];

    self.enterHideSwitch.on = mGlobalData.privateSetting.enterHideState ? PPSEnterHideStateOpen : PPSEnterHideStateClosed;
    self.simplePasswordSwitch.on = mGlobalData.privateSetting.simplePasswordState = YES;
    self.fingerprintPasswordSwitch.on = mGlobalData.privateSetting.fingerprintState ? PPSFingerprintStateOpen : PPSFingerprintStateClosed;

    self.simplePasswordSwitch.enabled = NO;
}

- (void)enterHideSwitchAction {
    mGlobalData.privateSetting.enterHideState = _enterHideSwitch.on ? PPSEnterHideStateOpen : PPSEnterHideStateClosed;
    [mGlobalData.privateSetting saveData];
}

- (void)simplePasswordSwitchAction {
    mGlobalData.privateSetting.simplePasswordState = _simplePasswordSwitch.on ? PPSSimplePasswordStateOpen : PPSSimplePasswordStateClosed;
    [mGlobalData.privateSetting saveData];
}

- (void)fingerprintPasswordSwitchAction {
    mGlobalData.privateSetting.fingerprintState = _fingerprintPasswordSwitch.on ? PPSFingerprintStateOpen : PPSFingerprintStateClosed;
    [mGlobalData.privateSetting saveData];
    [self saveTouchIdPassword];
}

- (void)loadSettingData {
    self.settingData = @[
            @{
                    @"header_hint" : @"",
                    @"cell" : @[@{
                    @"title" : @"隐藏入口",
                    @"sub_title" : @"是否默认隐藏私密照片的入口？",
                    @"switch_type" : @(1001)
            }
            ],
                    @"footer_hint" : @"连续点击应用首页底部的版本号处3次 即可显示/隐藏私密照片的入口哦~"
            },
            @{
                    @"header_hint" : @"",
                    @"cell" : @[@{
                    @"title" : @"修改密码",
                    @"sub_title" : @"",
                    @"switch_type" : @(1004)
            }
            ],
                    @"footer_hint" : @""
            },
            @{
                    @"header_hint" : @"",
                    @"cell" : @[@{
                    @"title" : @"简单密码",
                    @"sub_title" : @"",
                    @"switch_type" : @(1002)
            },
                    @{
                            @"title" : @"指纹密码(Touch ID)",
                            @"sub_title" : @"",
                            @"switch_type" : @(1003)
                    }
            ],
                    @"footer_hint" : @"1.为了安全，简单密码是必须开启的！\n2.请先启用手机的Touch ID，指纹密码才能正常工作！"
            },
    ];
}

#pragma mark - table view delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _settingData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_settingData[section][@"cell"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    NSString *title = _settingData[indexPath.section][@"cell"][indexPath.row][@"title"];
    NSString *subTitle = _settingData[indexPath.section][@"cell"][indexPath.row][@"sub_title"];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = subTitle;

    NSNumber *switchType = _settingData[indexPath.section][@"cell"][indexPath.row][@"switch_type"];
    switch ([switchType intValue]) {
        case 1001:
            cell.accessoryView = self.enterHideSwitch;
            break;
        case 1002:
            cell.accessoryView = self.simplePasswordSwitch;
            break;
        case 1003:
            cell.accessoryView = self.fingerprintPasswordSwitch;
            break;
        case 1004:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        default:
            break;
    }

    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section; {
    NSString *headerHint = _settingData[section][@"header_hint"];
    return headerHint;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section; {
    NSString *footerHint = _settingData[section][@"footer_hint"];
    return footerHint;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSNumber *switchType = _settingData[indexPath.section][@"cell"][indexPath.row][@"switch_type"];
    switch ([switchType intValue]) {
        case 1001:
            break;
        case 1002:
            break;
        case 1003:
            break;
        case 1004: {
            [[YIPasswordManager sharedInstance] createPasscodeViewControllerWithType:BKPasscodeViewControllerChangePasscodeType
                                                              andCreateCompleteBlock:^(UIViewController *vc) {
                                                                  YIBaseNavigationController *bnc = [[YIBaseNavigationController alloc] initWithRootViewController:vc];
                                                                  [self presentViewController:bnc animated:YES completion:nil];
                                                              }
                                                                 andDidFinishedBlock:^{

                                                                 }];
            break;
        }
        default:
            break;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section; {
    return 20.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section; {
    if (section == 0) {
        return 45.f;
    } else if (section == 1) {
        return 0.01;
    } else if (section == 2) {
        return 60.f;
    } else {
        return 0.01;
    }
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
