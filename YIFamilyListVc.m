//
//  YIFamilyListVc.m
//  XiaoJia
//
//  Created by efeng on 16/9/3.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "YIFamilyListVc.h"
#import <Realm/Realm.h>
#import "YIIncomeTag.h"
#import "YIExpenses.h"
#import "YIExpensesTag.h"
#import "YIFamily.h"
#import "YIAddFamilyVc.h"
#import "YIAddPhaseVc.h"
#import "YIPhaseListVc.h"
#import "YIRealmUtil.h"
#import "YIBillChartVc.h"


@interface YIFamilyListVc () <UITableViewDelegate, UITableViewDataSource>{
    UITableView *tableView;
    RLMResults<YIFamily *> *families;
}

@end

@implementation YIFamilyListVc

- (void)viewDidLoad {
    [super viewDidLoad];

//    [[YIRealmUtil instance] buildDefaultData];
    [[YIRealmUtil instance] initRealm];

    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithTitle:@"添加"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(addItemAction:)];
    self.navigationItem.rightBarButtonItem = addItem;

    tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableView.superview);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // 刷新数据源
    families = [YIFamily allObjects];
    [tableView reloadData];

    NSLog(@"families %@", families);
}

#pragma mark -

- (void)addItemAction:(UIBarButtonItem *)buttonItem {
    YIAddFamilyVc *vc = [[YIAddFamilyVc alloc] init];
    YIBaseNavigationController *nc = [[YIBaseNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:^{

    }];
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return families.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    YIFamily *family = families[indexPath.row];
    cell.textLabel.text = family.name;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    YIAddPhaseVc *vc = [[YIAddPhaseVc alloc] init];

    YIPhaseListVc *vc = [[YIPhaseListVc alloc] init];
    vc.family = families[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section; {
    return 20.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section; {
    return 0.01f;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[RLMRealm defaultRealm] beginWriteTransaction];
        [[RLMRealm defaultRealm] deleteObject:families[indexPath.row]];
        [[RLMRealm defaultRealm] commitWriteTransaction];

        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
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
