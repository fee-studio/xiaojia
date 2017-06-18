//
// Created by efeng on 16/9/6.
// Copyright (c) 2016 buerguo. All rights reserved.
//

#import "YIPhaseListVc.h"
#import "YIAddPhaseVc.h"
#import "YIPhase.h"
#import "YIAddBillVc.h"
#import "YIBillListVc.h"
#import "YIBillChartVc.h"
#import "YIChartJsVc.h"


@interface YIPhaseListVc() <UITableViewDataSource, UITableViewDelegate, YIAddPhaseVcDelegate>
{
    UITableView *tableView;
//    NSMutableArray<YIPhase *> *phases;
}

@end

@implementation YIPhaseListVc {

}

- (instancetype)init {
    self = [super init];
    if (self) {
//        phases = [NSMutableArray arrayWithCapacity:10];
    }

    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"阶段列表";
	
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithTitle:@"添加"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(addItemAction:)];
	
	UIBarButtonItem *creatChartItem = [[UIBarButtonItem alloc] initWithTitle:@"生成报表"
																style:UIBarButtonItemStylePlain
															   target:self
															   action:@selector(createChartItemAction:)];
	
//    self.navigationItem.rightBarButtonItem = addItem;
	self.navigationItem.rightBarButtonItems = @[addItem, creatChartItem];


    tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsMultipleSelectionDuringEditing = NO;
//    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableView.superview);
    }];
}

- (void)addItemAction:(UIBarButtonItem *)buttonItem {
    YIAddPhaseVc *vc = [[YIAddPhaseVc alloc] init];
    vc.phaseList = self.family.phaseList;
    vc.delegate = self;
    YIBaseNavigationController *nc = [[YIBaseNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:NULL];
}


- (void)createChartItemAction:(UIBarButtonItem *)bbi {
//	YIBillChartVc *vc = [[YIBillChartVc alloc] init];
    YIChartJsVc *vc = [[YIChartJsVc alloc] init];
	vc.family = _family;
	YIBaseNavigationController *nc = [[YIBaseNavigationController alloc] initWithRootViewController:vc];
	[self presentViewController:nc animated:YES completion:NULL];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.family.phaseList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;

    YIPhase *phase = self.family.phaseList[indexPath.row];
    cell.textLabel.text = [phase name];
    NSString *startDate = [phase.startDate convertDateToStringWithFormat:@"yyyy年MM月"];
    NSString *endDate = [phase.endDate convertDateToStringWithFormat:@"yyyy年MM月"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", startDate, endDate];
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath; {
//    return mScreenWidth / 6.f * 2.f;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

	YIPhase *phase = self.family.phaseList[indexPath.row];
	YIBillListVc *vc = [[YIBillListVc alloc] init];
	vc.phase = phase;
    [self.navigationController pushViewController:vc animated:YES];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section; {
return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section; {
    return 20.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section; {
    return 0.01f;
}

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		[[RLMRealm defaultRealm] beginWriteTransaction];
		[self.family.phaseList removeObjectAtIndex:indexPath.row];
		[[RLMRealm defaultRealm] commitWriteTransaction];
		
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - YIAddPhaseVcDelegate

- (void)addPhaseSuccessWith:(YIPhase *)phase;
{
//    [[RLMRealm defaultRealm] beginWriteTransaction];
//    [self.family.phaseList addObject:phase];
//    [[RLMRealm defaultRealm] commitWriteTransaction];	
	[tableView reloadData];
}

@end
