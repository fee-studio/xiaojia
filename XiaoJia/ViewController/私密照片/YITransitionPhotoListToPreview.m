//
//  YITransitionPhotoListToPreview.m
//  LoveWallpaper
//
//  Created by efeng on 14-9-9.
//  Copyright (c) 2014年 buerguo. All rights reserved.
//

#import "YITransitionPhotoListToPreview.h"

#import "YIPrivatePhotoVc.h"
#import "YIPhotoPreviewViewController.h"


@implementation YITransitionPhotoListToPreview


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    YIPrivatePhotoVc *fromViewController = (YIPrivatePhotoVc *) [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    YIPhotoPreviewViewController *toViewController = (YIPhotoPreviewViewController *) [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    /*
     UIView *curPage = [fromViewController.baseCollectionView cellForItemAtIndexPath:toViewController.curIndexPath];
     __block UIView *fromView = [curPage snapshotViewAfterScreenUpdates:NO];
     fromView.frame = [containerView convertRect:curPage.frame fromView:curPage.superview];
     curPage.hidden = YES;
     
     UIView *toView = toViewController.view;
     toView.frame = [transitionContext finalFrameForViewController:toViewController];
     toView.hidden = YES;
     
     [containerView addSubview:toView];
     [containerView addSubview:fromView];
     
     [UIView animateWithDuration:duration animations:^{
     
     CGRect frame = [containerView convertRect:toView.frame fromView:toView];
     fromView.frame = frame;
     
     } completion:^(BOOL finished) {
     // Clean up
     toView.hidden = NO;
     curPage.hidden = NO;
     
     [UIView animateWithDuration:0.2
     animations:^{
     fromView.alpha = 0.f;
     } completion:^(BOOL finished) {
     [fromView removeFromSuperview];
     fromView = nil;
     }];
     
     // Declare that we've finished
     [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
     }];
     */

    UIView *curPage = [fromViewController.baseCollectionView cellForItemAtIndexPath:toViewController.curIndexPath];
    __block UIView *fromView = [curPage snapshotViewAfterScreenUpdates:NO];
    fromView.frame = [containerView convertRect:curPage.frame fromView:curPage.superview];

    UIView *toView = toViewController.view;
    toView.frame = [transitionContext finalFrameForViewController:toViewController];
    toView.hidden = YES;

    [containerView addSubview:toView];
    [containerView addSubview:fromView];

    [UIView animateWithDuration:duration animations:^{

        fromView.frame = toView.frame;

    }                completion:^(BOOL finished) {

        [fromView removeFromSuperview];
        fromView = nil;
        toView.hidden = NO;

        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}


@end
