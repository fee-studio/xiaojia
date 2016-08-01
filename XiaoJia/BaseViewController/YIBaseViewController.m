//
//  YIBaseViewController.m
//  Dobby
//
//  Created by efeng on 14-5-17.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

#import "YIMessagesViewController.h"


@interface YIBaseViewController ()

@end

@implementation YIBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = [YICommonUtil appName];

//		UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_100"]];
//		[titleView setFrame:CGRectMake(0, 0, 40, 40)];
//		self.navigationItem.titleView = titleView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

//	UIImageView *bgIv = [UIImageView new];
//	bgIv.image = [UIImage imageNamed:@"launch_bg2"];
//	[self.view insertSubview:bgIv atIndex:0];
//	[bgIv mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.edges.equalTo(bgIv.superview);
//	}];

//	self.edgesForExtendedLayout = UIRectEdgeNone; // 对navigation进行任何风格的设置都不会再生效, 怪怪..

    // register for keyboard notifications
    [mNotificationCenter addObserver:self
                            selector:@selector(keyboardWillShow:)
                                name:UIKeyboardWillShowNotification
                              object:self.view.window];
    // register for keyboard notifications
    [mNotificationCenter addObserver:self
                            selector:@selector(keyboardWillHide:)
                                name:UIKeyboardWillHideNotification
                              object:self.view.window];
/*
#if DEBUG
	if (self.rdv_tabBarController) {
		self.rdv_tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"FLEX" style:UIBarButtonItemStylePlain target:self action:@selector(flexButtonTapped:)];
	} else {
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"FLEX" style:UIBarButtonItemStylePlain target:self action:@selector(flexButtonTapped:)];
	}
#endif
 */

    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithTitle:@"FLEX" style:UIBarButtonItemStylePlain target:self action:@selector(flexButtonTapped:)];
//	UIBarButtonItem *feedbackItem = [[UIBarButtonItem alloc] initWithTitle:@"反馈" style:UIBarButtonItemStylePlain target:self action:@selector(feedbackAction:)];
//	UIBarButtonItem *feedbackItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"my_feedback"] style:UIBarButtonItemStylePlain target:self action:@selector(feedbackAction:)];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"feedback"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 30, 30)];
    [button addTarget:self action:@selector(feedbackAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *feedbackItem = [[UIBarButtonItem alloc] initWithCustomView:button];

#if DEBUG
    self.navigationItem.rightBarButtonItems = @[feedbackItem, flexItem];
#else
    self.navigationItem.rightBarButtonItems = @[feedbackItem];
#endif

    /*
    // 左侧按钮
    if (mGlobalData.homeVc == nil
            || [mGlobalData.homeVc isEqualToString:NSStringFromClass([YIIndexVc class])]
            || [self isKindOfClass:[YIIndexVc class]]) {

    } else {
        UIBarButtonItem *homeBBi = [[UIBarButtonItem alloc] initWithTitle:@"首页"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(homeButtonTapped:)];
        self.navigationItem.leftBarButtonItem = homeBBi;
    }
     */
}

#if DEBUG

- (void)flexButtonTapped:(id)sender {
    [[FLEXManager sharedManager] showExplorer];
}

#endif

//- (void)homeButtonTapped:(id)sender {
//    YIIndexVc *vc = [[YIIndexVc alloc] init];
//	YIBaseNavigationController *bnc = [[YIBaseNavigationController alloc] initWithRootViewController:vc];
//	[self presentViewController:bnc animated:YES completion:nil];
////    [self.navigationController pushViewController:vc animated:YES];
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass(self.class)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass(self.class)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self hideKeyboard:nil];
}

#pragma mark - keyboard selector

/**
 *  隐藏键盘
 */
- (void)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}

- (void)keyboardWillShow:(NSNotification *)n {
    _keyboardIsShown = YES;
}

- (void)keyboardWillHide:(NSNotification *)n {
    _keyboardIsShown = NO;
}

#pragma mark -

#pragma mark - MBProgressHUD 相关方法

- (void)showLoadingView {
    [self hideKeyboard:nil];
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)showLoadingViewToWindow {
    [self hideKeyboard:nil];
    HUD = [MBProgressHUD showHUDAddedTo:[mAppDelegate window] animated:YES];
}

- (void)showLoadingViewNoInteraction {
    [self hideKeyboard:nil];
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.userInteractionEnabled = NO;
}

- (void)hideLoadingView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)hideLoadingViewToWindow {
    [MBProgressHUD hideHUDForView:self.view.window animated:YES];
}

- (void)showLoadingViewWithText:(NSString *)text {
    [self hideKeyboard:nil];
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = text;
}

- (void)showLoadingViewDefaultText {
    [self hideKeyboard:nil];
    [self showLoadingViewWithText:@"正在加载中..."];
}

#pragma mark -

- (void)feedbackAction:(id)sender {
//    [MobClick event:CLICK_FEEDBACK_ENTER];
    YIMessagesViewController *vc = [YIMessagesViewController messagesViewController];
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    HUD = nil;
}

@end
