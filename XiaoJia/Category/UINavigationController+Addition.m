//
//  UINavigationController+Addition.m
//  Dobby
//
//  Created by efeng on 14/10/30.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

@implementation UINavigationController (Addition)


- (NSArray *)popToViewControllerBackLevel:(NSUInteger)level animated:(BOOL)animated {

    NSMutableArray *vcs = [NSMutableArray arrayWithArray:self.viewControllers];
    NSUInteger count = vcs.count;
    if (level <= count - 1) {
        UIViewController *targetVC = vcs[count - 1 - level];
        return [self popToViewController:targetVC animated:animated];
    } else {
        return [self popToRootViewControllerAnimated:animated];
    }
}

// Ps. leve 从前面数 从0开始代表第一个
- (NSArray *)popToViewControllerFrontLevel:(NSInteger)level animated:(BOOL)animated {

    NSMutableArray *vcs = [NSMutableArray arrayWithArray:self.viewControllers];
    NSUInteger count = vcs.count;
    if (level < count && level >= 0) {
        UIViewController *targetVC = vcs[level];
        return [self popToViewController:targetVC animated:animated];
    } else {
        return [self popToRootViewControllerAnimated:animated];
    }
}


@end
