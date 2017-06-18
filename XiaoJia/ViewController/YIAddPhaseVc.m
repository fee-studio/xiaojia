//
// Created by efeng on 16/9/3.
// Copyright (c) 2016 buerguo. All rights reserved.
//

#import <iOS-Category/Categories.h>
#import "YIAddPhaseVc.h"
#import "YIAddPhaseCell.h"
#import "YIMonthButton.h"
#import "YIPhase.h"
#import "YITextField.h"
#import "YIAddBillVc.h"


@interface YIAddPhaseVc () <UITableViewDelegate, UITableViewDataSource, YIAddPhaseCellDelegate> {
    UIBarButtonItem *finishItem;
	YITextField *tfName;
    UITableView *tableView;
    NSMutableArray *years;

    NSMutableArray *selectedDate;
	
	
	YIPhase *willAddPhase;
}

@end

@implementation YIAddPhaseVc {

}

- (instancetype)init {
    self = [super init];
    if (self) {
        years = [NSMutableArray arrayWithCapacity:10];
        selectedDate = [NSMutableArray arrayWithCapacity:10];
		
		willAddPhase = [[YIPhase alloc] init];
		willAddPhase.name = @"临时数据请删除！";
		willAddPhase.isTemp = YES;
    }

    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"添加阶段";
    self.edgesForExtendedLayout = UIRectEdgeNone;

	[self loadUI];

	[self loadDATA];
}

- (void)loadUI {
	UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
																   style:UIBarButtonItemStylePlain
																  target:self
																  action:@selector(cancelItemAction:)];
	self.navigationItem.leftBarButtonItem = cancelItem;
	
	
	finishItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
												  style:UIBarButtonItemStylePlain
												 target:self
												 action:@selector(finishItemAction:)];
	self.navigationItem.rightBarButtonItem = finishItem;
	
	
	// set name toolbar
	tfName = [[YITextField alloc] init];
	tfName.backgroundColor = [UIColor oldLaceColor];
	tfName.placeholder = @"请输入此阶段的名字，如：第一家公司期间";
	tfName.font = kAppMidFont;
	[self.view addSubview:tfName];
	[tfName mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(tfName.superview);
		make.top.equalTo(tfName.superview);
		make.width.equalTo(tfName.superview);
		make.height.equalTo(@44);
	}];
	
	tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
	tableView.delegate = self;
	tableView.dataSource = self;
	[tableView registerClass:YIAddPhaseCell.class forCellReuseIdentifier:NSStringFromClass(YIAddPhaseCell.class)];
	tableView.rowHeight = mScreenWidth / 6.f * 2.f + 2.f;
	[self.view addSubview:tableView];
	[tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(tfName.mas_bottom);
		make.left.equalTo(tableView.superview);
		make.width.equalTo(tableView.superview);
		make.bottom.equalTo(tableView.superview);
	}];
}

- (void)cancelItemAction:(UIBarButtonItem *)item {
	// 删除数据
	[[RLMRealm defaultRealm] beginWriteTransaction];
	[[RLMRealm defaultRealm] deleteObject:willAddPhase];
	[[RLMRealm defaultRealm] commitWriteTransaction];
	
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)finishItemAction:(UIBarButtonItem *)item {
//    [[RLMRealm defaultRealm] beginWriteTransaction];
//    YIFamily *family = [[YIFamily alloc] init];
//    family.name = textField.text;
//    [[RLMRealm defaultRealm] addObject:family];
//    [[RLMRealm defaultRealm] commitWriteTransaction];
	
	if ([tfName.text.trimWhitespace isEqualToString:@""]) {
		[YIProgressHUD showProgressHUDText:@"请先填写阶段的名字"];
		return;
	}
//	if (!(willAddPhase.startDate && willAddPhase.endDate)) {
//		[YIProgressHUD showProgressHUDText:@"请先选择正确的开始日期与结束日期"];
//		return;
//	}
	if (selectedDate.count < 2) {
		[YIProgressHUD showProgressHUDText:@"请先选择正确的开始日期与结束日期"];
		return;
	}

    NSDate *startDate = [(YIMonthButton *)[selectedDate firstObject] month];
    NSDate *endDate = [(YIMonthButton *)[selectedDate lastObject] month];

    [[RLMRealm defaultRealm] beginWriteTransaction];
	willAddPhase.name = tfName.text.trimWhitespace;
    willAddPhase.isTemp = NO;
    [[RLMRealm defaultRealm] commitWriteTransaction];

    if ([_delegate respondsToSelector:@selector(addPhaseSuccessWith:)]) {
          [_delegate addPhaseSuccessWith:willAddPhase];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadDATA {
	NSDate *today = [NSDate date];
	NSDateComponents *dateComponents = [[NSCalendar currentCalendar]
			components:NSCalendarUnitDay
					| NSCalendarUnitMonth
					| NSCalendarUnitYear
			  fromDate:today];
	NSInteger year = [dateComponents year];
	
	// table view datasource
    for (NSInteger i = year - 30; i <= year; ++i) {
        [years addObject:@(i)];
    }

    // http://stackoverflow.com/questions/16071503/how-to-tell-when-uitableview-has-completed-reloaddata
    dispatch_async(dispatch_get_main_queue(), ^{
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:30]
                         atScrollPosition:UITableViewScrollPositionMiddle
                                 animated:NO];
    });
	
	// 进来就添加一条默认的数据
	[[RLMRealm defaultRealm] beginWriteTransaction];
	[_phaseList addObject:willAddPhase];
	[[RLMRealm defaultRealm] commitWriteTransaction];
	
	[tableView reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; {
    return years.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YIAddPhaseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(YIAddPhaseCell.class) forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell setupCell:[years[indexPath.section] intValue]];

    int year = [years[indexPath.section] intValue];
    [cell setupCellWithYear:year andSelectedPhase:_phaseList];

    cell.delegate = self;
    return cell;

/*
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.userInteractionEnabled = NO;
//        cell.textLabel.text = @"1 2 3 4 5 6 7 8 9 10 11 12";

        UIView *lastView;
        for (int i = 0; i < 6; ++i) {
            YIMonthButton *button = [[YIMonthButton alloc] init];
            [button setTitle:[@(i+1) stringValue]];
            [button setYear:[years[indexPath.section] intValue] month:[button.title intValue]];
            [button addTarget:self action:@selector(monthBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastView? lastView.mas_right:button.superview);
                make.top.equalTo(button.superview);
                if (lastView) {
                    make.width.equalTo(lastView);

                }
                make.height.equalTo(button.mas_width);
                if (i == 6-1 && lastView) {
                    make.right.equalTo(button.superview);
                }

            }];

            lastView = button;
        }

        for (int i = 0; i < 6; ++i) {
            YIMonthButton *button = [YIMonthButton instance];
            [button setTitle:[@(i+1+6) stringValue]];
            [button setYear:[years[indexPath.section] intValue] month:[button.title intValue]];
            [button addTarget:self action:@selector(monthBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {

                if (i == 0) {
                    make.left.equalTo(button.superview);
                    make.top.equalTo(lastView.mas_bottom);
                } else {
                    make.top.equalTo(lastView.mas_top);
                    make.left.equalTo(lastView.mas_right);
                }

                if (lastView) {
                    make.width.equalTo(lastView);

                }
                make.height.equalTo(button.mas_width);
                if (i == 6-1 && lastView) {
                    make.right.equalTo(button.superview);
                }


            }];

            lastView = button;
        }
    }

    return cell;
    */
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath; {
//    return mScreenWidth / 6.f * 2.f;
//}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//	YIAddBillVc *vc = [[YIAddBillVc alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//}


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section; {
    return [NSString stringWithFormat:@"%@", years[section]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section; {
    return 40.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section; {
    return 0.01f;
}

#pragma mark - YIAddPhaseCellDelegate

- (void)selectedDateButton:(YIMonthButton *)button; {
//	if (willAddPhase.startDate && willAddPhase.endDate
//		&& [willAddPhase.startDate compare:willAddPhase.endDate] == NSOrderedSame) {
//		[selectedDate removeAllObjects];
//	}
	
//	NSDate *startDate = [(YIMonthButton *)[selectedDate firstObject] month];
//	NSDate *endDate = [(YIMonthButton *)[selectedDate lastObject] month];
//	if (startDate && endDate && [startDate compare:endDate] == NSOrderedSame) {
//		[selectedDate removeAllObjects];
//	}
	

    NSDate *curDate = [button month];
	// 第一个时间元素-可以加入
	if (selectedDate.count == 0) {
		button.type = MonthButtonTypeStart;
		button.selected = !button.selected;
		[selectedDate addObject:button];
	} else {
		NSDate *lastDate = [(YIMonthButton *) [selectedDate firstObject] month];
		// 当前时间 大于 上一个时间, 可以加入
		if ([lastDate compare:curDate] == NSOrderedAscending || [lastDate compare:curDate] == NSOrderedSame) {
			button.type = MonthButtonTypeEnd;
			button.selected = !button.selected;
			[selectedDate addObject:button];
		}
	}
	
	
	
	
//    // 第一个时间元素-可以加入
//    if (selectedDate.count == 0) {
//		button.type = MonthButtonTypeStart;
//		button.selected = !button.selected;
//        [selectedDate addObject:button];
//    } else {
//        if (selectedDate.count >= 2) {
//			if (button.type == MonthButtonTypeStart) {
//			} else if (button.type == MonthButtonTypeEnd) {
//			} else {
//				
//			}
//			
//            [selectedDate removeLastObject];
//		} else {
//			if (button.type == MonthButtonTypeStart) {
//				button.selected = !button.selected;
//			} else if (button.type == MonthButtonTypeEnd) {
//			} else {
//				
//			}
//		}
//        NSDate *lastDate = [(YIMonthButton *) [selectedDate firstObject] month];
//        // 当前时间 大于 上一个时间, 可以加入
//        if ([lastDate compare:curDate] == NSOrderedAscending) {
//			button.type = MonthButtonTypeEnd;
//			button.selected = !button.selected;
//            [selectedDate addObject:button];
//        } else { // 不可以加入
//
//        }
//    }
	
	// 更新数据
	if (selectedDate.count >= 2) {
		// 保存数据
		NSDate *startDate = [(YIMonthButton *)[selectedDate firstObject] month];
		NSDate *endDate = [(YIMonthButton *)[selectedDate lastObject] month];
		
		[[RLMRealm defaultRealm] beginWriteTransaction];
		willAddPhase.startDate = startDate;
		willAddPhase.endDate = endDate;
		[[RLMRealm defaultRealm] commitWriteTransaction];
		
		[tableView reloadData];
		
		// 相同的话，清理所有数据
		if ([startDate compare:endDate] == NSOrderedSame) {
			[selectedDate removeAllObjects];
		}
	}


}


@end
