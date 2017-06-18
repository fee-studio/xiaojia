//
//  YISplashScreen.m
//  Emma
//
//  Created by efeng on 15/12/5.
//  Copyright © 2015年 weiboyi. All rights reserved.
//

#import "YISplashScreen.h"
#import "YIInitUtil.h"


@interface YISplashScreen () {
    UIView *launchView;
    BOOL tagWillRemoveSplashScreen;
}


@end


@implementation YISplashScreen

- (void)loadSplashScreen2 {
    launchView = [[NSBundle mainBundle] loadNibNamed:@"Launch" owner:nil options:nil][0];
    [[mAppDelegate window] addSubview:launchView];
    [launchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([mAppDelegate window]);
    }];

    UIImageView *logoIv = [UIImageView new];
    logoIv.image = [UIImage imageNamed:@"launch_bg2@2x.jpg"];
    [launchView addSubview:logoIv];
    [logoIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(logoIv.superview);
    }];

    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha = 0.98f;
    [launchView addSubview:effectView];
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(effectView.superview);
    }];
}

- (void)loadSplashScreen {    
    launchView = [[NSBundle mainBundle] loadNibNamed:@"Launch" owner:nil options:nil][0];
    [[mAppDelegate window] addSubview:launchView];
    [launchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([mAppDelegate window]);
    }];

    UIImageView *logoIv = [UIImageView new];
    logoIv.image = [UIImage imageNamed:@"launch_logo"];
    [launchView addSubview:logoIv];
    [logoIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(logoIv.superview);
        make.centerY.equalTo(logoIv.superview).offset(-100);
    }];

    UILabel *sloganLbl = [UILabel new];
    sloganLbl.backgroundColor = [UIColor clearColor];
    sloganLbl.text = @"未来世界，因你而美";
    sloganLbl.font = [UIFont systemFontOfSize:16];
    sloganLbl.textColor = kAppColorWhite;
    [launchView addSubview:sloganLbl];
    [sloganLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(sloganLbl.superview);
    }];

    UILabel *appNameLbl = [UILabel new];
    appNameLbl.backgroundColor = [UIColor clearColor];
    appNameLbl.text = [YICommonUtil appName];
    appNameLbl.font = [UIFont systemFontOfSize:50];
    appNameLbl.textColor = kAppColorWhite;
    [launchView addSubview:appNameLbl];
    [appNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(appNameLbl.superview);
        make.centerY.equalTo(appNameLbl.superview).offset(100);
    }];

    logoIv.alpha = 0.f;
    sloganLbl.alpha = 0.f;
    appNameLbl.alpha = 0.f;

    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         logoIv.alpha = 1.0f;
                     } completion:^(BOOL finished) {
                logoIv.alpha = 1.0f;
            }];

    [UIView animateWithDuration:1
                          delay:0.8
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         sloganLbl.alpha = 1.0f;
                     } completion:^(BOOL finished) {
                sloganLbl.alpha = 1.0f;
            }];

    [UIView animateWithDuration:1
                          delay:1.6
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         appNameLbl.alpha = 1.0f;
                     } completion:^(BOOL finished) {
                appNameLbl.alpha = 1.0f;

                // 显示完再消失
                [UIView animateWithDuration:0.5
                                      delay:0.2
                                    options:UIViewAnimationOptionCurveEaseIn
                                 animations:^{
                                     logoIv.alpha = 0.0f;
                                     sloganLbl.alpha = 0.0f;
                                     appNameLbl.alpha = 0.0f;
                                 } completion:^(BOOL finished) {
                            logoIv.alpha = 0.0f;
                            sloganLbl.alpha = 0.0f;
                            appNameLbl.alpha = 0.0f;
                        }];
            }];


    // 不再显示
    UIButton *neverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [neverBtn setTitle:@"不再显示" forState:UIControlStateNormal];
    neverBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [neverBtn addTarget:self action:@selector(notShowSplashScreen:) forControlEvents:UIControlEventTouchUpInside];
    [launchView addSubview:neverBtn];
    [neverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(neverBtn.superview).offset(30);
        make.right.equalTo(neverBtn.superview).offset(-20);
    }];

    // 不再显示
    UIButton *poweredBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [poweredBtn setTitle:@"POWERED BY XIAOJIA" forState:UIControlStateNormal];
    poweredBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//	[poweredBtn addTarget:self action:@selector(notShowSplashScreen:) forControlEvents:UIControlEventTouchUpInside];
    [launchView addSubview:poweredBtn];
    [poweredBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(poweredBtn.superview).offset(-20);
        make.centerX.equalTo(poweredBtn.superview);
    }];

    // 3秒后消失
    [self performSelector:@selector(removeSplashScreen:) withObject:@(2) afterDelay:3.0f];
}

- (void)removeSplashScreen:(id)args {
    BOOL willRemoveSplashScreen = NO;
    if ([args isKindOfClass:[UIButton class]]) {
        UIButton *tmpBtn = (UIButton *) args;
        NSNumber *tag = @(tmpBtn.tag);
        willRemoveSplashScreen = [tag boolValue];
    } else {
        willRemoveSplashScreen = [args boolValue];
    }

    if (tagWillRemoveSplashScreen == NO) {
        tagWillRemoveSplashScreen = willRemoveSplashScreen;
        if (launchView) {
            [UIView animateWithDuration:1
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 launchView.alpha = 0.0f;
                             } completion:^(BOOL finished) {
                        if (finished) {
                            [launchView removeFromSuperview];
                            launchView = nil;

                            [self performSelector:@selector(registerApns) withObject:nil afterDelay:1];
                        }
                    }];
        }
    }
}

- (void)notShowSplashScreen:(UIButton *)button {
    [mGlobalData setNotShowSplashScreen:YES];
    [self removeSplashScreen:button];
}

- (void)registerApns {
    // 注册APNS
    [YIInitUtil registerAPNS];
}


@end
