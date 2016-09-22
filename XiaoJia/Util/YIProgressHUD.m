//
//  YIProgressHUD.m
//  YIBox
//
//  Created by efeng on 16/3/4.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "YIProgressHUD.h"

@implementation YIProgressHUD

+ (void)showProgressHUDText:(NSString *)text {
    // 显示
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[mAppDelegate window] animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.yOffset = mScreenHeight / 2.f - 80.f;
    hud.margin = 10.f;
    [hud show:YES];
    hud.labelText = text;
    // 1秒后隐藏
    [hud hide:YES afterDelay:2.f];
}

@end
