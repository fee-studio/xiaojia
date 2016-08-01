//
// Created by efeng on 16/3/11.
// Copyright (c) 2016 buerguo. All rights reserved.
//

#import "YICalculatorVc.h"
#import "YICalculatorView.h"

@interface YICalculatorVc () <YICalculatorViewDelegate> {
    YICalculatorView *calculatorView;

}

@property(nonatomic, strong) YICalculatorManager *calManager;

@end

@implementation YICalculatorVc {

}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.calManager = [[YICalculatorManager alloc] init];
    }

    return self;
}


//- (void)loadView {
//	self.view = [UIView new];
//	calculatorView = [[YICalculatorView alloc] init];
//    calculatorView.delegate = self;
//    [self.view addSubview:calculatorView];
//	UIEdgeInsets padding = UIEdgeInsetsMake(64, 0, 0, 0);
//	[calculatorView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.edges.equalTo(calculatorView.superview).with.insets(padding);
//	}];
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    calculatorView = [[YICalculatorView alloc] init];
    calculatorView.delegate = self;
    calculatorView.calManager = self.calManager;
    [self.view addSubview:calculatorView];
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [calculatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(calculatorView.superview).with.insets(padding);
    }];

    [self setupBackBtn];
}

// 加载工具栏
- (void)setupBackBtn {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.alpha = 0.7f;
    [backBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backBtn.superview).offset(10);
        make.top.equalTo(backBtn.superview).offset(20);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar lt_reset];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma mark - YICalculatorViewDelegate

- (void)clickButtonTag:(int)tag {
    // 每次输入 默认都是正常的输入
    self.calManager.abnormalInput = NO;

    if (tag >= 3001 && tag <= 3005) {
        // 加减乘除等于号(二元运算符)
        [self binaryOperatorPressed:tag];
    } else if (tag >= 2001 && tag <= 2004) {
        // 一元运算符
        [self unaryOperatorPressed:tag];
    } else if (tag >= 1000 && tag <= 1010) {
        // 数字
        [self numberPressed:tag];
    }

    if (self.calManager.abnormalInput == NO) {
        // 记入输入队列
        [self.calManager inputObject:tag];

        // 显示竖式
        [calculatorView drawLblCurNumberText:self.calManager.currentNumber
                                    operator:self.calManager.operator
                              writeInLastLbl:self.calManager.writeInLastLbl
                                    nextLine:self.calManager.writeNextLine
                                  isOperator:self.calManager.writeIsOperator
                                    isResult:self.calManager.writeResult];

        self.calManager.writeOp = OPERATOR_NULL;
    }
}

#pragma mark - 不同类型的按钮

- (void)numberPressed:(int)tag {
    int digit = tag - 1000;
    // 计算当前的值
    [self.calManager calCurrentNumberWithDigit:digit];
    [calculatorView setDisplayLblText:self.calManager.currentNumber];
}

- (void)binaryOperatorPressed:(int)tag {
    [self.calManager calCurrentNumberWithBinaryOperator:tag];
    [calculatorView setDisplayLblText:self.calManager.currentNumber];
}

- (void)unaryOperatorPressed:(int)tag {
    [self.calManager calCurrentNumberWithUnaryOperator:tag];
    [calculatorView setDisplayLblText:self.calManager.currentNumber];
}


- (void)dealloc {
    calculatorView = nil;
}


@end