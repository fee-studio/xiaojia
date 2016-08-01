//
//  YITransitionPreviewToPhotoList.m
//  LoveWallpaper
//
//  Created by efeng on 14-9-9.
//  Copyright (c) 2014年 buerguo. All rights reserved.
//

#import "YITransitionPreviewToPhotoList.h"

#import "YIPrivatePhotoVc.h"
#import "YIPhotoPreviewViewController.h"
#import "YIPhotoCollectionViewLayout.h"

@implementation YITransitionPreviewToPhotoList


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    /*
    YIPhotoPreviewViewController *fromViewController = (YIPhotoPreviewViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    YIPhotoListViewController *toViewController = (YIPhotoListViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView *fromView = fromViewController.view;
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.frame = toFrame;
    UIView *toView = toViewController.view;
    [containerView addSubview:toView];
    
    UIView *toItemView = [toViewController.baseCollectionView cellForItemAtIndexPath:fromViewController.curIndexPath]; // TODO 这里有空的
    
    __block UIView *toItemViewSnap = [toItemView snapshotViewAfterScreenUpdates:NO];
    toItemViewSnap.frame = fromFrame;//fromView.frame;//fromFrame;
    CGRect targetFrame = [containerView convertRect:toItemView.frame fromView:toItemView.superview];
    
    NSLog(@"to item view = %@, target frame = %@",toItemView, NSStringFromCGRect(targetFrame));
    [containerView addSubview:toItemViewSnap];
    // {{0, 225}, {106, 159}} {{107, 225}, {106, 159}} {{214, 225}, {106, 159}}
    // {{0, 192.5}, {106, 159}}
    [UIView animateWithDuration:duration animations:^{
        
        toItemViewSnap.frame = targetFrame;
        
    } completion:^(BOOL finished) {
        
        toItemViewSnap.hidden = YES;
        [toItemViewSnap removeFromSuperview];
        toItemViewSnap = nil;
        
        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
     
     */

    YIPhotoPreviewViewController *fromViewController = (YIPhotoPreviewViewController *) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    YIPrivatePhotoVc *toViewController = (YIPrivatePhotoVc *) [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    // 1,拿到 from view & to view
    UIView *fromView = fromViewController.baseCollectionView; // 这里用baseCollectionView不用view是为了不显示工具栏
    UIView *toView = toViewController.view;

    // 2,拿到 作动画的view 并初始化正确的frame
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    fromView.frame = fromFrame;
    __block UIView *animationView = [fromView snapshotViewAfterScreenUpdates:NO];

    // 5,把toView & 全动画的view加入到containerView 注意顺序
    [containerView addSubview:toView];
    [containerView addSubview:animationView];

    // 3,赋值给toView正确的frame,很重要.
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.frame = toFrame;

    // 4,修正toView的UI.显示tabbar & 滚动到指定的位置
    // **** 做点非动画的事情 ****
//     [toViewController.leveyTabBarController hidesTabBar:NO animated:YES]; // 这里就不需要显示这个啦.
    [fromViewController refreshPhotoListViewControllerCellPosition];
    // **** 做点非动画的事情 ****

    // 6,计算目标位置
    CGRect targetFrame = CGRectZero;
    CGRect toFrame2 = toViewController.view.frame; // 再拿到经过第4步修正后toViewController.view的frame
    YIPhotoCollectionViewLayout *layout = (YIPhotoCollectionViewLayout *) toViewController.baseCollectionView.collectionViewLayout;
    CGFloat x = floorf((fromViewController.curIndexPath.item % 3) * (layout.itemSize.width + layout.minimumInteritemSpacing));
    // int y = toFrame2.size.height + toFrame2.origin.y - layout.itemSize.height; // 滚动到底时用这个
    CGFloat y = floorf((toFrame2.size.height - layout.itemSize.height) / 2.f + toFrame2.origin.y); // 滚动到垂直居中用这个. // TODO: 最前和最后两排可能要做处理.
    CGFloat w = layout.itemSize.width;
    CGFloat h = layout.itemSize.height;

    targetFrame = CGRectMake(x, y, w, h);

    // 7,最后作动画
    [UIView animateWithDuration:duration animations:^{
        animationView.frame = targetFrame;
    }                completion:^(BOOL finished) {

        [animationView removeFromSuperview];
        animationView = nil;

        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

@end
