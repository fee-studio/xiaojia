//
//  YIBillChartVc.m
//  XiaoJia
//
//  Created by efeng on 16/9/21.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "YIBillChartVc.h"

@interface YIBillChartVc ()
{
	NSMutableArray *months;
}

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic) PNLineChart * lineChart;

@end

@implementation YIBillChartVc

- (void)viewDidLoad {
    [super viewDidLoad];
	self.edgesForExtendedLayout = UIRectEdgeNone;
	
	UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
																style:UIBarButtonItemStylePlain
															   target:self
															   action:@selector(cancelItemAction:)];
	self.navigationItem.leftBarButtonItem = cancelItem;

	
	
	[self loadData];
	
	[self loadUI];
}

- (void)loadData {
	
	months = [NSMutableArray arrayWithCapacity:10];
	
	YIPhase *phase = [self.family.phaseList firstObject];
	NSDate *startDate = phase.startDate;
	NSDate *endDate = phase.endDate;
	
	NSDateComponents *startDateComponents = [[NSCalendar currentCalendar]
											 components:NSCalendarUnitDay
											 | NSCalendarUnitMonth
											 | NSCalendarUnitYear
											 fromDate:startDate];
	NSInteger startYear = [startDateComponents year];
	NSInteger startMonth = [startDateComponents month];
	NSInteger startDay = [startDateComponents day];
	
	NSDateComponents *endDateComponents = [[NSCalendar currentCalendar]
										   components:NSCalendarUnitDay
										   | NSCalendarUnitMonth
										   | NSCalendarUnitYear
										   fromDate:endDate];
	NSInteger endYear = [endDateComponents year];
	NSInteger endMonth = [endDateComponents month];
	NSInteger endDay = [endDateComponents day];
	
	
	for (NSInteger year = startYear; year <= endYear; year++) {
		NSInteger tmpStartMonth;
		NSInteger tmpEndMonth;
		
		if (startYear == endYear) {
			tmpStartMonth = startMonth;
			tmpEndMonth = endMonth;
		} else {
			if (year == startYear) {
				tmpStartMonth = startMonth;
				tmpEndMonth = 12;
			} else if (year == endYear) {
				tmpStartMonth = 1;
				tmpEndMonth = endMonth;
			} else {
				tmpStartMonth = 1;
				tmpEndMonth = 12;
			}
		}
		
		for (NSInteger month = tmpStartMonth; month <= tmpEndMonth; month++) {
			[months addObject:[NSString stringWithFormat:@"%ld,%ld",year, month]];
		}
	}
	
	
	NSLog(@"month finally = %@", months);
	
	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:NSCalendarUnitMonth
											   fromDate:startDate
												 toDate:endDate
												options:NSCalendarWrapComponents];
	
	NSArray *monthSymbols = [calendar monthSymbols];
	NSLog(@"%@", monthSymbols);
	
	NSInteger value = [components valueForComponent:NSCalendarUnitMonth];
	NSLog(@"vvvvvvalue = %ld", value);
	
	NSInteger day = components.day;
	NSLog(@"dddddddddday = %d", day);
	
	NSInteger month = components.month;
	NSLog(@"mmmmmmmonth = %d", month);

	
	NSInteger year = components.year;
	NSLog(@"yyyyyyyyear = %d", year);

	
//	NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//	NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:startDate toDate:endDate options:0];
//	return components.day;
}

- (void)loadUI {
	self.titleLabel = [[UILabel alloc] init];
	self.titleLabel.textAlignment = NSTextAlignmentCenter;
	self.titleLabel.text = @"支出趋势";
	[self.view addSubview:self.titleLabel];
	[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(_titleLabel.superview);
		make.top.equalTo(_titleLabel.superview);
		make.width.equalTo(_titleLabel.superview);
		make.height.equalTo(@44);
	}];
	
//	self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectZero];
	self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 44, mScreenWidth*2, 300)];
	self.lineChart.backgroundColor = [UIColor clearColor];
	[self.lineChart setXLabels:months];  // x轴的坐标
	self.lineChart.showCoordinateAxis = YES;
	
	
	self.lineChart.yLabelFormat = @"%1.f";
	// added an examle to show how yGridLines can be enabled
	// the color is set to clearColor so that the demo remains the same
	self.lineChart.yGridLinesColor = [UIColor clearColor];
	self.lineChart.showYGridLines = YES;
	
	//Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
	//Only if you needed
	// todo y轴应该做成动态的
	self.lineChart.yFixedValueMax = 30000.0;
	self.lineChart.yFixedValueMin = 0.0;
	[self.lineChart setYLabels:@[@"0",@"5000",@"10000",@"15000",@"20000",@"25000",@"30000"]];
	
	NSUInteger count4Month = months.count;
	NSAssert(count4Month > 0, @"月数必须大于0个哦！");
	NSMutableArray *lineCharts = [NSMutableArray array];
	
	float allExpensesMoney = 0.f;
	float allIncomeMoney = 0.f;
	
	YIPhase *phase = [self.family.phaseList firstObject];
	// 支出部分
	for (YIExpenses *expenses in phase.expensesList) {
		float money4Month;
		YIFrequency *frequency = expenses.frequency;
		switch (frequency.id) {
			case 3000:{ // only one
				money4Month = expenses.money / count4Month;
				break;
			}
			case 3001:{ // daily
				money4Month = expenses.money * 30;
				break;
			}
			case 3002:{ // weekly
				money4Month = expenses.money * 4;
				break;
			}
			case 3003:{ // every half moon
				money4Month = expenses.money * 2;
				break;
			}
			case 3004:{ // monthly
				money4Month = expenses.money;
				break;
			}
			case 3005:{ // yearly
				money4Month = expenses.money / 12.f;
				break;
			}
			default:
				break;
		}
		PNLineChartData *data01 = [PNLineChartData new];
		data01.dataTitle = expenses.expensesTag.name;
		data01.color = PNRed;
		data01.itemCount = count4Month;
		data01.inflexionPointColor = PNRed;
		data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
		data01.getData = ^(NSUInteger index) {
			return [PNLineChartDataItem dataItemWithY:money4Month];
		};
		[lineCharts addObject:data01];
		
		allExpensesMoney += money4Month;
		PNLineChartData *dataAll = [PNLineChartData new];
		dataAll.dataTitle = expenses.expensesTag.name;
		dataAll.color = PNRed;
		dataAll.itemCount = count4Month;
		dataAll.inflexionPointColor = PNRed;
		dataAll.inflexionPointStyle = PNLineChartPointStyleTriangle;
		dataAll.getData = ^(NSUInteger index) {
			return [PNLineChartDataItem dataItemWithY:allExpensesMoney];
		};
		[lineCharts addObject:dataAll];
		

	}

	// 收入部分
	for (YIIncome *income in phase.incomeList) {
		float money4Month;
		NSAssert(count4Month > 0, @"月数必须大于0个哦！");
		YIFrequency *frequency = income.frequency;
		switch (frequency.id) {
			case 3000:{ // only one
				money4Month = income.money / count4Month;
				break;
			}
			case 3001:{ // daily
				money4Month = income.money * 30;
				break;
			}
			case 3002:{ // weekly
				money4Month = income.money * 4;
				break;
			}
			case 3003:{ // every half moon
				money4Month = income.money * 2;
				break;
			}
			case 3004:{ // monthly
				money4Month = income.money;
				break;
			}
			case 3005:{ // yearly
				money4Month = income.money / 12.f;
				break;
			}
			default:
				break;
		}
		
		PNLineChartData *data01 = [PNLineChartData new];
		data01.dataTitle = income.incomeTag.name;
		data01.color = PNFreshGreen;
		data01.itemCount = count4Month;
		data01.inflexionPointColor = PNFreshGreen;
		data01.inflexionPointStyle = PNLineChartPointStyleCircle;
		data01.getData = ^(NSUInteger index) {
			return [PNLineChartDataItem dataItemWithY:money4Month];
		};
		[lineCharts addObject:data01];
		
		
		allIncomeMoney += money4Month;
		PNLineChartData *dataAll = [PNLineChartData new];
		dataAll.dataTitle = income.incomeTag.name;
		dataAll.color = PNFreshGreen;
		dataAll.itemCount = count4Month;
		dataAll.inflexionPointColor = PNFreshGreen;
		dataAll.inflexionPointStyle = PNLineChartPointStyleCircle;
		dataAll.getData = ^(NSUInteger index) {
			return [PNLineChartDataItem dataItemWithY:allIncomeMoney];
		};
		[lineCharts addObject:dataAll];

	}
	
	
	
	
/*
	// Line Chart #2
	NSArray * data02Array = @[@0.0, @180.1, @26.4, @202.2, @126.2, @167.2, @276.2];
	PNLineChartData *data02 = [PNLineChartData new];
	data02.dataTitle = @"Beta";
	data02.color = PNTwitterColor;
	data02.alpha = 0.5f;
	data02.itemCount = data02Array.count;
	data02.inflexionPointStyle = PNLineChartPointStyleCircle;
	data02.getData = ^(NSUInteger index) {
		CGFloat yValue = [data02Array[index] floatValue];
		return [PNLineChartDataItem dataItemWithY:yValue];
	};
 */
	
	self.lineChart.chartData = lineCharts;
	[self.lineChart strokeChart];
//	self.lineChart.delegate = self;
	
	[self.scrollView addSubview:self.lineChart];
	self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.lineChart.bounds), CGRectGetHeight(self.view.bounds));
//	[self.lineChart mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.top.equalTo(_titleLabel.mas_bottom);
//		make.left.equalTo(self.lineChart.superview);
//		make.width.equalTo(@640);
//		make.height.equalTo(@300);
//	}];
	
	self.lineChart.legendStyle = PNLegendItemStyleStacked;
	self.lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
	self.lineChart.legendFontColor = [UIColor skyBlueColor];
	
	UIView *legend = [self.lineChart getLegendWithMaxWidth:320];
	[legend setFrame:CGRectMake(20, 300+44+10, legend.frame.size.width, legend.frame.size.width)]; // todo ...
	[self.view addSubview:legend];	
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	
}

- (void)cancelItemAction:(UIBarButtonItem *)bbi
{
	[self dismissViewControllerAnimated:YES completion:NULL];
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
