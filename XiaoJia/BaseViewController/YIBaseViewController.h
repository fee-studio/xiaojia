//
//  YIBaseViewController.h
//  Dobby
//
//  Created by efeng on 14-5-17.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PODS_HEADER.h"

@interface YIBaseViewController : UIViewController <MBProgressHUDDelegate> {

    MBProgressHUD *HUD;
}

@property(nonatomic, assign) BOOL keyboardIsShown;


- (void)showLoadingView;

- (void)showLoadingViewWithText:(NSString *)text;

- (void)showLoadingViewDefaultText;

- (void)showLoadingViewToWindow;

- (void)hideLoadingViewToWindow;

- (void)showLoadingViewNoInteraction;

- (void)hideLoadingView;

- (void)hideKeyboard:(id)sender;

- (void)keyboardWillShow:(NSNotification *)n;

- (void)keyboardWillHide:(NSNotification *)n;


@end




