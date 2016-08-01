//
//  YIBaseScrollViewController.m
//  Dobby
//
//  Created by efeng on 15/6/23.
//  Copyright (c) 2015年 weiboyi. All rights reserved.
//

@interface YIBaseScrollViewController () <UIScrollViewDelegate>


@end

@implementation YIBaseScrollViewController

- (void)loadView {

    self.view = [[UIView alloc] initWithFrame:mScreenBounds];
    self.view.backgroundColor = [UIColor whiteColor];

    self.scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
//	self.edgesForExtendedLayout = UIRectEdgeAll;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
