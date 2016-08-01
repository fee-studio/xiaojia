//
//  YIPhotoPreviewViewController.m
//  LoveWallpaper
//
//  Created by efeng on 14-8-19.
//  Copyright (c) 2014年 buerguo. All rights reserved.
//
// todo 预览时白屏 解决

#import "YIPhotoPreviewViewController.h"
#import "YIPhotoPreviewCell.h"
#import "YIPreviewLayout.h"
#import "YITransitionPreviewToPhotoList.h"
#import "YIPrivatePhotoVc.h"


@interface YIPhotoPreviewViewController () <UINavigationControllerDelegate, UIScrollViewDelegate> {

    BOOL isHidden;
}

@property(nonatomic, weak) UIButton *myBackBtn;
@property(nonatomic, weak) UIView *myToolView;

@end

@implementation YIPhotoPreviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    YIPreviewLayout *pl = [[YIPreviewLayout alloc] init];
    self.layout = pl;

    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.baseCollectionView registerClass:[YIPhotoPreviewCell class] forCellWithReuseIdentifier:@"PreviewCell"];

    self.baseCollectionView.pagingEnabled = YES;
    self.baseCollectionView.showsHorizontalScrollIndicator = NO;
    self.baseCollectionView.showsVerticalScrollIndicator = NO;

    YIPreviewLayout *automationLayout = (YIPreviewLayout *) self.baseCollectionView.collectionViewLayout;
    [automationLayout registerClass:[YIPhotoPreviewCell class] forDecorationViewOfKind:@"FloorPlan"];

    [self setupToolView];

//	self.automaticallyAdjustsScrollViewInsets = NO;
}

// 加载工具栏
- (void)setupToolView {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backBtn.superview).offset(20);
        make.bottom.equalTo(backBtn.superview).offset(-20);
        make.width.equalTo(@64);
        make.height.equalTo(@64);
    }];

//    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, mScreenHeight - 44, mScreenWidth, 44)];
//    toolView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
//    [self.view addSubview:toolView];
//    
//    UIButton *downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    downloadBtn.frame = CGRectMake(0, 0, mScreenWidth/3, 44);
//    [downloadBtn setTitle:@"保存" forState:UIControlStateNormal];
//    downloadBtn.backgroundColor = [UIColor clearColor];
//    [downloadBtn addTarget:self action:@selector(downloadBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [toolView addSubview:downloadBtn];
//    
//    UIButton *previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    previewBtn.frame = CGRectMake(mScreenWidth/3, 0, mScreenWidth/3, 44);
//    [previewBtn setTitle:@"预览" forState:UIControlStateNormal];
//    previewBtn.backgroundColor = [UIColor clearColor];
//    [previewBtn addTarget:self action:@selector(previewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [toolView addSubview:previewBtn];
//    
//    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    shareBtn.frame = CGRectMake(mScreenWidth/3*2, 0, mScreenWidth/3, 44);
//    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
//    shareBtn.backgroundColor = [UIColor clearColor];
//    [shareBtn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [toolView addSubview:shareBtn];

//    _myBackBtn = backBtn;
//    _myToolView = toolView;
//    
//    
//    _myBackBtn.alpha = 0;
//    _myToolView.alpha = 0;
//    
//    CGRect rect = _myToolView.frame;
//    rect.origin.y += rect.size.height;
//    _myToolView.frame = rect;
//    
//    isHidden = YES;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];

//    Method original = class_getInstanceMethod([UITabBar class], @selector(actionForLayer:forKey:));
//    Method custom = class_getInstanceMethod([UITabBar class], @selector(customActionForLayer:forKey:));
//    
//    class_replaceMethod([UITabBar class], @selector(actionForLayer:forKey:), method_getImplementation(custom), method_getTypeEncoding(custom));
//    class_addMethod([UITabBar class], @selector(defaultActionForLayer:forKey:), method_getImplementation(original), method_getTypeEncoding(original));

}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:YES];

//    self.navigationController.delegate = self;

//    [self setControlsHidden:YES animated:NO];

    // Hide or show the toolbar at the bottom of the screen.
//    [self.navigationController setToolbarHidden:YES animated:NO]; 

    // hide status bar
//	[[UIApplication sharedApplication] setStatusBarHidden:YES];

    // hide navigation bar
    [self.navigationController setNavigationBarHidden:YES animated:YES];

//    [self.leveyTabBarController hidesTabBar:YES animated:YES];

//	[self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
//	[self.navigationController.navigationBar setShadowImage:[UIImage new]];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];


//    [self.leveyTabBarController hidesTabBar:NO animated:NO];
//    [self refreshPhotoListViewControllerCellPosition];

//	[self.navigationController.navigationBar lt_reset];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    // scrolling here does work,but in viewDidLoad not work!
    [self.baseCollectionView scrollToItemAtIndexPath:_curIndexPath
                                    atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                            animated:NO];
}

#pragma mark - collection data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    YIPhotoPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PreviewCell" forIndexPath:indexPath];
    NSString *photoPath = [_photoParentPath stringByAppendingPathComponent:_photoArray[indexPath.item]];
    [cell setupCell:photoPath];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [self setToolViewHidden:!isHidden animated:YES];
}

#pragma mark - Delegate 

- (void)refreshPhotoListViewControllerCellPosition {

    if (_delegate && [_delegate respondsToSelector:@selector(myScrollToItemAtIndexPath:)]) {
        [_delegate myScrollToItemAtIndexPath:_curIndexPath];
    }
}

#pragma mark - UIScrollViewDelegate 

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView; {

    if ([scrollView isKindOfClass:[UICollectionView class]]) {

        UICollectionView *tmpCV = (UICollectionView *) scrollView;
        _curIndexPath = [tmpCV indexPathForItemAtPoint:tmpCV.contentOffset]; // 有坐标计算当前的indexpath
//        [self asynDownloadPhotos];
//        [self refreshPhotoListViewControllerCellPosition];
    }
}

#pragma mark - 工具栏操作

- (void)previewBtnAction:(id)sender {


}

#pragma mark - UINavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    // Check if we're transitioning from this view controller to a DSLFirstViewController
    if (fromVC == self) {
        if ([toVC isKindOfClass:[YIPrivatePhotoVc class]]) {
            return [[YITransitionPreviewToPhotoList alloc] init];
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//	if ([viewController isKindOfClass:[YINewestListViewController class]])
//	{
////        [self.leveyTabBarController hidesTabBar:NO animated:YES];
//	}
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
