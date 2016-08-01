//
// Created by efeng on 16/7/18.
// Copyright (c) 2016 buerguo. All rights reserved.
//

#import "YIMosaicsView.h"
#import "EditView.h"


@interface YIMosaicsView () <UIScrollViewDelegate> {
    UIScrollView *scrollView;
    UIImageView *imageView;
    UIImage *mosaicsImage;
}

@property(nonatomic) UIScrollView *scrollView;

@end

@implementation YIMosaicsView

@synthesize editView;
@synthesize scrollView;

- (instancetype)initWithMosaicsImage:(UIImage *)aMosaicsImage {
    self = [super init];
    if (self) {
        mosaicsImage = aMosaicsImage;

        // 1.设置scroll view的基本属性
        scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = kAppColorLightGray;
        [self addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(scrollView.superview);
        }];

        // 2.设置scroll view与zoom相关的属性
        scrollView.minimumZoomScale = 1.0;
        scrollView.maximumZoomScale = 1.0;
        scrollView.bouncesZoom = YES;
        scrollView.delegate = self;

        // 3.添加一张图片
        [self loadMosaicsView:mosaicsImage];
    }

    return self;
}

+ (instancetype)viewWithMosaicsImage:(UIImage *)aMosaicsImage {
    return [[self alloc] initWithMosaicsImage:aMosaicsImage];
}

- (void)loadMosaicsView:(UIImage *)image {
    if (editView) {
        [editView removeFromSuperview];
        editView = nil;
    }

    editView = [EditView viewWithImage:image];
    [self addSubview:editView];

    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;

    CGFloat viewW = mScreenWidth;// 300.f;
    CGFloat viewH = mScreenHeight - 49.f * 2 - 20.f - 44.f - 20.f;// 500.f;

    CGFloat width, height;
    if (imageW / imageH > viewW / viewH) {
        width = viewW;
        height = viewW / (imageW / imageH);
    } else {
        width = viewH * (imageW / imageH);
        height = viewH;
    }
    [editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
        make.center.equalTo(editView.superview);
    }];
}

#pragma mark -

- (UIImage *)savedImage {
    return [editView savedImage];
}

#pragma mark - UIScrollView Delegate

/* 在scrollview中Zoom的目标视图 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return editView;
}

/* scrollview将要开始Zooming */
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    NSLog(@"Begin Zooming");
}

/* scrollview已经发生了Zoom事件 */
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    NSLog(@"Did Zoom");
}

/* scrollview完成Zooming */
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    NSLog(@"1 %@", NSStringFromCGRect(scrollView.bounds));
    NSLog(@"2 %@", NSStringFromCGRect(scrollView.frame));
    NSLog(@"3 %@", NSStringFromCGSize(scrollView.contentSize));

    NSLog(@"4 %@", NSStringFromCGRect(view.bounds));
    NSLog(@"5 %@", view);
    NSLog(@"6 %@", NSStringFromCGRect(view.frame));
    NSLog(@"7 %f", scale);

//	[editView mas_updateConstraints:^(MASConstraintMaker *make) {
//		make.center.equalTo(editView.superview);
//	}];

    NSLog(@"zoomscale = %f", scrollView.zoomScale);

//self.scrollView.contentSize=CGSizeMake(1280, 1280);

//    if (self.scrollView.zoomScale > 1) {
//        imageView.center = CGPointMake(self.scrollView.contentSize.width / 2, self.scrollView.contentSize.height / 2);
//    }
//    else {
//        imageView.center = self.center;
//    }
//
//    CGSize size = self.scrollView.contentSize;
//    NSLog(@"Content size of scroll view");
//    NSLog(@"w = %f, h = %f", size.width, size.height);
//    NSLog(@"----------------------------");
//
//    NSLog(@"zoomscale = %f", self.scrollView.zoomScale);
//    NSLog(@"----------------------------");
//
//    CGRect boundsOfScrollView = self.scrollView.bounds;
//    NSLog(@"Bounds of scroll view");
//    NSLog(@"x = %f, y = %f", boundsOfScrollView.origin.x, boundsOfScrollView.origin.y);
//    NSLog(@"w = %f, h = %f", boundsOfScrollView.size.width, boundsOfScrollView.size.height);
}


@end