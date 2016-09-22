//
//  YIBillListVc.m
//  XiaoJia
//
//  Created by efeng on 16/9/20.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "YIBillListVc.h"
#import "YIAddBillVc.h"

@interface YIBillListVc () <UITableViewDataSource, UITableViewDelegate>
{
	UITableView *tableView;
}

@end


@implementation YIBillListVc


- (void)viewDidLoad {
	[super viewDidLoad];
	self.edgesForExtendedLayout = UIRectEdgeNone;
	
	[self loadData];
	
	UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithTitle:@"添加"
																style:UIBarButtonItemStylePlain
															   target:self
															   action:@selector(addBillItemAction:)];
	self.navigationItem.rightBarButtonItem = addItem;
	
	
	tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
	tableView.delegate = self;
	tableView.dataSource = self;
	tableView.allowsMultipleSelectionDuringEditing = NO;
	[self.view addSubview:tableView];
	[tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(tableView.superview);
	}];
}

- (void)loadData {
	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	
	[tableView reloadData];
}

- (void)addBillItemAction:(UIBarButtonItem *)addItem {
	YIAddBillVc *vc = [[YIAddBillVc alloc] init];
	vc.phase = _phase;
	[self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
	return 2;  // 0: 支出 1: 收入
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		return self.phase.expensesList.count;
	} else {
		return self.phase.incomeList.count;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.selectionStyle = UITableViewCellSelectionStyleDefault;
	
	if (indexPath.section == 0) {
		YIExpenses *expenses = self.phase.expensesList[indexPath.row];
		cell.textLabel.text = expenses.expensesTag.name;
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %f",expenses.frequency.name, expenses.money];
	} else  {
		YIIncome *income = self.phase.incomeList[indexPath.row];
		cell.textLabel.text = income.incomeTag.name;
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %f",income.frequency.name, income.money];
	}
	
	return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath; {
//    return mScreenWidth / 6.f * 2.f;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section; {
	if (section == 0) {
		return @"支出";
	} else {
		return @"收入";
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section; {
	return 40.f;
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
		if (indexPath.section == 0) {
			[[RLMRealm defaultRealm] beginWriteTransaction];
			[self.phase.expensesList removeObjectAtIndex:indexPath.row];
			[[RLMRealm defaultRealm] commitWriteTransaction];
		} else {
			[[RLMRealm defaultRealm] beginWriteTransaction];
			[self.phase.incomeList removeObjectAtIndex:indexPath.row];
			[[RLMRealm defaultRealm] commitWriteTransaction];
		}
		
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}

#pragma mark -


@end
