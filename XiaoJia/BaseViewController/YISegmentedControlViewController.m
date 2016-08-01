//
//  YISegmentedControlViewController.m
//  Dobby
//
//  Created by efeng on 14-5-20.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//
//  界面中以UISegmentedControl为主体布局的UIViewController,都要继承此类.


@interface YISegmentedControlViewController ()

@end

@implementation YISegmentedControlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.sgmctrContainerView = self.view;

    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] init];
        _segmentedControl.tintColor = kAppColorMain;
    } else {
        [_segmentedControl removeAllSegments];
    }

    [_segmentedControl addTarget:self action:@selector(segmentedControlSelected:) forControlEvents:UIControlEventValueChanged];
}

- (void)bindViewControllersToSegmentedControl:(NSArray *)viewControllers {
    if ([_segmentedControl numberOfSegments] > 0) {
        return;
    }

    for (int i = 0; i < [viewControllers count]; i++) {
        [self pushViewController:viewControllers[i] title:[viewControllers[i] title]];
    }
    [_segmentedControl setSelectedSegmentIndex:0];
    self.selectedViewControllerIndex = 0;
}

- (void)pushViewController:(UIViewController *)viewController title:(NSString *)title {
    [_segmentedControl insertSegmentWithTitle:title atIndex:_segmentedControl.numberOfSegments animated:NO];
    [self addChildViewController:viewController];

    [_segmentedControl sizeToFit];
}

#pragma mark - segmented control method

- (void)segmentedControlSelected:(id)sender {
    self.selectedViewControllerIndex = _segmentedControl.selectedSegmentIndex;
}

- (void)setSelectedViewControllerIndex:(NSInteger)index {

    if (!_selectedViewController) {

        _selectedViewController = self.childViewControllers[index];
        [self.sgmctrContainerView addSubview:[_selectedViewController view]];

        [_selectedViewController view].frame = self.sgmctrContainerView.bounds;

        [_selectedViewController didMoveToParentViewController:self];

    } else if (index != _selectedViewControllerIndex) {

        [self transitionFromViewController:_selectedViewController
                          toViewController:self.childViewControllers[index]
                                  duration:0.0f
                                   options:UIViewAnimationOptionTransitionNone
                                animations:nil
                                completion:^(BOOL finished) {
                                    _selectedViewController = self.childViewControllers[index];
                                    _selectedViewControllerIndex = index;
                                    if ([self respondsToSelector:@selector(selectCompletion)]) {
                                        [self selectCompletion];
                                    }

                                    [_selectedViewController view].frame = self.sgmctrContainerView.bounds;
                                }];
    }

    [_segmentedControl setSelectedSegmentIndex:index];
}

- (void)selectCompletion {


}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
