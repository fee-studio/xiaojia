//
//  YIBaseTableViewController.m
//  Dobby
//
//  Created by efeng on 14-5-30.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

#import "YIBaseTableViewController.h"

@interface YIBaseTableViewController ()

@end

@implementation YIBaseTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
- (void)loadView {
    
    [super loadView];
    
    if (_isPlainTableViewStyle) {
        _baseTableView = [[UITableView alloc]
                          initWithFrame:self.view.bounds
                          style:UITableViewStylePlain];
    } else {
        _baseTableView = [[UITableView alloc]
                          initWithFrame:self.view.bounds
                          style:UITableViewStyleGrouped];
    }
    
    // 1.初始化base tableview
    _baseTableView.delegate = self;
    _baseTableView.dataSource = self;
    [_baseTableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    [self.view addSubview:_baseTableView];
    //    });

}
 */

- (void)viewDidLoad {
    [super viewDidLoad];
//	self.edgesForExtendedLayout = UIRectEdgeAll;

    if (_isPlainTableViewStyle) {
        _baseTableView = [[UITableView alloc]
                initWithFrame:self.view.bounds
                        style:UITableViewStylePlain];
    } else {
        _baseTableView = [[UITableView alloc]
                initWithFrame:self.view.bounds
                        style:UITableViewStyleGrouped];
    }

    // 1.初始化base tableview
    _baseTableView.delegate = self;
    _baseTableView.dataSource = self;

//    [_baseTableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];

//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.view addSubview:_baseTableView];
//        [_baseTableView reloadData];
//    });

//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul), ^{
//        //BlahBlah
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            //update your UIView
//            [self.view addSubview:_baseTableView];
//            [_baseTableView reloadData];
//        });
//    });

    [self.view addSubview:_baseTableView];
    [_baseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    [_baseTableView reloadData];

    /*
    if (self.rdv_tabBarController.tabBar.translucent) {
        CGFloat tabBarHeight = CGRectGetHeight(self.rdv_tabBarController.tabBar.frame);
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, tabBarHeight, 0);

        _baseTableView.contentInset = insets;
        _baseTableView.scrollIndicatorInsets = insets;
    }
     */
}

// 2.集成刷新控件
- (void)setRefreshType:(TableViewRefreshType)refreshType {
    _refreshType = refreshType;
/*
    switch (refreshType) {
        case TableViewRefreshTypeAll:
            [self setupRefresh];
            break;
        case TableViewRefreshTypeHeader: {
            MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
//            header.ignoredScrollViewContentInsetTop = 117+44;
            self.baseTableView.mj_header = header;
            // 马上进入刷新状态
            [self.baseTableView.mj_header beginRefreshing];
            break;
        }
        case TableViewRefreshTypeFooter:
            self.baseTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
            self.baseTableView.mj_footer.hidden = YES;
            break;
        case TableViewRefreshTypeHeaderNoAutoRefresh:
            self.baseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
            break;
        case TableViewRefreshTypeHeaderNoAnimation:
        default:
            self.baseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
            break;
    }
 */
}

/**
*  集成刷新控件
*/
- (void)setupRefresh {
    /*
    self.baseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    [self.baseTableView.mj_header beginRefreshing];

    self.baseTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    self.baseTableView.mj_footer.hidden = YES;
     */
}

#pragma mark 开始进入刷新状态

- (void)headerRefreshing {
    // 1.添加数据
    [self refreshData];
}

- (void)footerRefreshing {
    // 1.添加数据
    [self loadMoreData];
}

- (void)endRefreshingView:(BOOL)isHeader {
    /*
    if (isHeader) {
        [self.baseTableView.header endRefreshing];
    } else {
        [self.baseTableView.footer endRefreshing];
    }
     */
}

#pragma mark - Header & Footer

- (void)refreshData {
}

- (void)loadMoreData {
}

#pragma mark - table view delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = @"敬请期待~";

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section; {
    return 20.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section; {
    return 0.01f;
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _baseTableView.delegate = nil;
    _baseTableView.dataSource = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
