//
//  YIBaseNavigationController.m
//  Dobby
//
//  Created by efeng on 14-5-17.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//


@interface YIBaseNavigationController ()

@end

@implementation YIBaseNavigationController

#pragma mark 一个类只会调用一次

+ (void)initialize {

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationBar.tintColor = kAppColorWhite;
    self.navigationBar.barTintColor = kAppColorMain;

    NSDictionary *titleAttributes = @{
            NSFontAttributeName : kAppBigFont,
            NSForegroundColorAttributeName : kAppColorWhite
    };
    self.navigationBar.titleTextAttributes = titleAttributes;
    self.navigationBar.translucent = YES;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

//- (void)longPress:(id)sender {
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
