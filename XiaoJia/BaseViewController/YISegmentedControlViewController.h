//
//  YISegmentedControlViewController.h
//  Dobby
//
//  Created by efeng on 14-5-20.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

#import "YIBaseViewController.h"


@interface YISegmentedControlViewController : YIBaseViewController


@property(nonatomic, assign) UIViewController *selectedViewController;
@property(nonatomic, strong) UISegmentedControl *segmentedControl;
@property(nonatomic, assign) NSInteger selectedViewControllerIndex;
@property(nonatomic, strong) UIView *sgmctrContainerView; // 包含子VC的View的View

- (void)bindViewControllersToSegmentedControl:(NSArray *)viewControllers;

- (void)setSelectedViewControllerIndex:(NSInteger)index;

// 子类重写
- (void)selectCompletion;
@end
