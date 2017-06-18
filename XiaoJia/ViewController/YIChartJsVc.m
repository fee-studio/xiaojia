//
// Created by efeng on 16/9/23.
// Copyright (c) 2016 buerguo. All rights reserved.
//

#import "YIChartJsVc.h"

@interface YIChartJsVc () <UIWebViewDelegate> {
    UIWebView *yiWebView;


}

@property WebViewJavascriptBridge *bridge;

@end

@implementation YIChartJsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"效果报表图";

    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(cancelItemAction:)];
    self.navigationItem.leftBarButtonItem = cancelItem;

    [self loadUI];
}

- (void)cancelItemAction:(UIBarButtonItem *)bbi {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)loadUI {
    yiWebView = [[UIWebView alloc] init];
    yiWebView.scalesPageToFit = YES;
    yiWebView.delegate = self;
    [self.view addSubview:yiWebView];
    [yiWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(yiWebView.superview);
    }];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"ChartIndex" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [yiWebView loadRequest:request];

    self.bridge = [WebViewJavascriptBridge bridgeForWebView:yiWebView];

    [self.bridge registerHandler:@"oc-get-chart-config" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC Echo called with: %@", data);
        NSArray *configs = [self getConfigData];
        NSLog(@"cccccc = %@", configs);
        responseCallback(configs);
    }];
}

- (NSArray *)monthLabels:(YIPhase *)phase {
    NSMutableArray *months = [NSMutableArray arrayWithCapacity:10];

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
            [months addObject:[NSString stringWithFormat:@"%ld年%ld月", year, month]];
        }
    }

    return months;
}

- (NSMutableArray *)getConfigData {
    NSMutableArray *chartConfigArray = [NSMutableArray array];

    NSMutableArray *totalBalanceChartDataArray = [NSMutableArray array];
    NSMutableArray *totalBalanceChartLabelArray = [NSMutableArray array];

    NSMutableArray *futureTotalBalanceChartDataArray = [NSMutableArray array];

    float lastExpenses = 0.f;
    float lastIncome = 0.f;

//    for (YIPhase *phase in self.family.phaseList) {
    for (int f = 0; f < self.family.phaseList.count; f++) {
        YIPhase *phase = self.family.phaseList[f];

        NSMutableDictionary *chartConfig = [NSMutableDictionary dictionary];
        NSArray *monthLabels = [self monthLabels:phase];
        NSMutableArray *datasets = [NSMutableArray array];

        // 支出部分
        NSMutableArray *expensesLines = [NSMutableArray array];
        for (YIExpenses *expenses in phase.expensesList) {
            YIFrequency *frequency = expenses.frequency;
            float money4Month = [self calMoneyToMonthUnit:frequency.id
                                                    money:expenses.money
                                              phaseLength:monthLabels.count];

            NSMutableArray *data = [NSMutableArray array];
            for (int i = 0; i < monthLabels.count; i++) {
                [data addObject:@(money4Month)];
            }
            NSDictionary *dataset = @{
                    @"label" : expenses.expensesTag.name,
                    @"data" : data,
                    @"fill" : @(false)};

            [expensesLines addObject:dataset];
        }

        // [1] add single expenses line
        [datasets addObjectsFromArray:expensesLines];


        // 总的支出数据
        NSMutableArray *totalExpensesData;
        for (int i = 0; i < expensesLines.count; i++) {
            NSArray *expensesMoney = expensesLines[i][@"data"];
            // 初始化
            if (totalExpensesData == nil) {
                totalExpensesData = [NSMutableArray array];
                for (int k = 0; k < expensesMoney.count; ++k) {
                    [totalExpensesData addObject:@(0)];
                }
            }
            for (int j = 0; j < expensesMoney.count; j++) {
                totalExpensesData[j] = @([totalExpensesData[j] floatValue] + [expensesMoney[j] floatValue]);
            }
        }

        NSDictionary *totalExpensesLine = @{
                @"label" : @"总支出",
                @"data" : totalExpensesData,
                @"fill" : @(false)};
        // [2] add total expenses line
        [datasets addObject:totalExpensesLine];


        // 收入部分
        NSMutableArray *incomeLines = [NSMutableArray array];
        for (YIIncome *income in phase.incomeList) {
            YIFrequency *frequency = income.frequency;
            float money4Month = [self calMoneyToMonthUnit:frequency.id
                                                    money:income.money
                                              phaseLength:monthLabels.count];

            NSMutableArray *data = [NSMutableArray array];
            for (int i = 0; i < monthLabels.count; i++) {
                [data addObject:@(money4Month)];
            }
            NSDictionary *dataset = @{
                    @"label" : income.incomeTag.name,
                    @"data" : data,
                    @"fill" : @(false)};

            [incomeLines addObject:dataset];
        }
        // [3] add single income line
        [datasets addObjectsFromArray:incomeLines];


        // 总的收入数据
        NSMutableArray *totalIncomeData;
        for (int i = 0; i < incomeLines.count; i++) {
            NSArray *incomeMoney = incomeLines[i][@"data"];
            // 初始化
            if (totalIncomeData == nil) {
                totalIncomeData = [NSMutableArray array];
                for (int k = 0; k < incomeMoney.count; ++k) {
                    [totalIncomeData addObject:@(0)];
                }
            }
            for (int j = 0; j < incomeMoney.count; j++) {
                totalIncomeData[j] = @([totalIncomeData[j] floatValue] + [incomeMoney[j] floatValue]);
            }
        }

        NSDictionary *totalIncomeLine = @{
                @"label" : @"总收入",
                @"data" : totalIncomeData,
                @"fill" : @(false)};
        // [4] add total income line
        [datasets addObject:totalIncomeLine];

        // 总结余金额
        NSMutableArray *balanceAmountData = [NSMutableArray array];
        for (int i = 0; i < totalIncomeData.count; i++) {
            float income = [totalIncomeData[i] floatValue];
            float expenses = [totalExpensesData[i] floatValue];
            float preBalance = (i > 0) ? [balanceAmountData[i - 1] floatValue] : 0.f;
            balanceAmountData[i] = @(income - expenses + preBalance);
        }
        NSDictionary *balanceAmountLine = @{
                @"label" : @"结余金额",
                @"data" : balanceAmountData,
                @"fill" : @(true)};

        // [5] add balance amount line
        [datasets addObject:balanceAmountLine];

//        chartConfig[@"line_single_expenses"] = [self setupConfigName:[NSString stringWithFormat:@"【%@】各项支出图",phase.name] labels:monthLabels datasets:expensesLines];
//        chartConfig[@"line_single_income"] = [self setupConfigName:[NSString stringWithFormat:@"【%@】各项收入图",phase.name]  labels:monthLabels datasets:incomeLines];
//        chartConfig[@"line_balance_amount"] = [self setupConfigName:[NSString stringWithFormat:@"【%@】结余图",phase.name]  labels:monthLabels datasets:@[balanceAmountLine]];
        chartConfig[@"line_total"] = [self setupConfigName:[NSString stringWithFormat:@"【%@】收入支出图", phase.name] labels:monthLabels datasets:datasets];


//        NSMutableArray *totalBalanceAmountData = [NSMutableArray array];
        for (int j = 0; j < totalIncomeData.count; j++) {
            float income = [totalIncomeData[j] floatValue];
            float expenses = [totalExpensesData[j] floatValue];
            float preBalance = totalBalanceChartDataArray.count > 0 ? [[totalBalanceChartDataArray lastObject] floatValue] : 0.f;
            [totalBalanceChartDataArray addObject:@(income - expenses + preBalance)];
        }
        NSDictionary *totalBalanceAmountLine = @{
                @"label" : @"总结余金额",
                @"data" : totalBalanceChartDataArray,
                @"fill" : @(true)};

        [totalBalanceChartLabelArray addObjectsFromArray:monthLabels];

        chartConfig[@"line_total_balance"] = [self setupConfigName:@"总结余图"
                                                            labels:totalBalanceChartLabelArray
                                                          datasets:@[totalBalanceAmountLine]];

        if (f == self.family.phaseList.count - 1) {
            lastIncome = [[totalIncomeData firstObject] floatValue];
            lastExpenses = [[totalExpensesData firstObject] floatValue];
            [futureTotalBalanceChartDataArray addObject:[totalBalanceChartDataArray lastObject]];
        }

        [chartConfigArray addObject:chartConfig];
    }

    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 12; j++) {
            float income = lastIncome;
            float expenses = lastExpenses;
            float preBalance = futureTotalBalanceChartDataArray.count > 0 ? [[futureTotalBalanceChartDataArray lastObject] floatValue] : 0.f;
            [futureTotalBalanceChartDataArray addObject:@(income - expenses + preBalance)];
        }
		// todo .....
        NSLog(@"哇哦~未来%d年你将会有%@大洋啦", i+1, [futureTotalBalanceChartDataArray lastObject]);
    }

    return chartConfigArray;
}

- (NSDictionary *)setupConfigName:(NSString *)name
                           labels:(NSArray *)labels
                         datasets:(NSArray *)datasets {
    NSDictionary *config = @{
            @"type" : @"line",
            @"data" : @{
                    @"labels" : labels,
                    @"datasets" : datasets,
            },
            @"options" : @{
                    @"responsive" : @(YES),
                    @"title" : @{
                            @"display" : @(YES),
                            @"text" : name,
                    },
                    @"hover" : @{
                            @"mode" : @"dataset",
                    },
            }
    };
    return config;
}

- (float)calMoneyToMonthUnit:(int)frequencyId money:(float)money phaseLength:(int)length {
    float money4Month;
    switch (frequencyId) {
        case 3000: { // only one
            money4Month = money / length;
            break;
        }
        case 3001: { // daily
            money4Month = money * 30;
            break;
        }
        case 3002: { // weekly
            money4Month = money * 4;
            break;
        }
        case 3003: { // every half moon
            money4Month = money * 2;
            break;
        }
        case 3004: { // monthly
            money4Month = money;
            break;
        }
        case 3005: { // yearly
            money4Month = money / 12.f;
            break;
        }
        default:
            break;
    }

    return money4Month;
}

#pragma mark - UIWebViewDelegate

- (BOOL)           webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
            navigationType:(UIWebViewNavigationType)navigationType; {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView; {

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

}

//重置 webView 的 html viewport 属性，变成不可缩放，并且缩放比例为1.0，并执行javaScript
#define QUOTE(...) #__VA_ARGS__
const char *webViewHeightJSString = QUOTE(
        var viewportmeta = document.querySelector('meta[name="viewport"]');
        if (viewportmeta) {
            viewportmeta.content = 'width=device-width, initial-scale=1.0,      minimum-scale=1.0, maximum-scale=1.0, user-scalable=no';
        }
);
#undef QUOTE

@end
