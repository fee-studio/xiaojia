//
//  YICalculatorManager.h
//  FYCalculator
//
//  Created by efeng on 14-8-28.
//  Copyright (c) 2014年 buerguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YICalculatorView;


#define kSign0 @"0"
#define kSign1 @"1"
#define kSign2 @"2"
#define kSign3 @"3"
#define kSign4 @"4"
#define kSign5 @"5"
#define kSign6 @"6"
#define kSign7 @"7"
#define kSign8 @"8"
#define kSign9 @"9"
#define kSignDecimalPoint @"."

#define kSignAdd @"+"
#define kSignMinus @"-"
#define kSignMultiple @"x"
#define kSignDivision @"÷"
#define kSignPercent @"%"
#define kSignNegative @"~"
#define kSignBackspace @"<"
#define kSignClear @"c"
#define kSignClearScreen @"clear"
#define kSignEqual @"="
#define kSign @""


static const int DIGIT_ZERO = 1000;
static const int DIGIT_ONE = 1001;
static const int DIGIT_TWO = 1002;
static const int DIGIT_THREE = 1003;
static const int DIGIT_FOUR = 1004;
static const int DIGIT_FIVE = 1005;
static const int DIGIT_SIX = 1006;
static const int DIGIT_SEVEN = 1007;
static const int DIGIT_EIGHT = 1008;
static const int DIGIT_NINE = 1009;

static const int DIGIT_DOT = 1010;

static const int OPERATOR_DELETE = 2001;
static const int OPERATOR_CLEAR = 2002;
static const int OPERATOR_PERCENT = 2003;
static const int OPERATOR_NEGATIVE = 2004;

static const int OPERATOR_NULL = 0;
static const int OPERATOR_ADD = 3001;
static const int OPERATOR_MINUS = 3002;
static const int OPERATOR_MULTIPLE = 3003;
static const int OPERATOR_DIVISION = 3004;
static const int OPERATOR_EQUAL = 3005;


#pragma mark -

@interface YICalculatorManager : NSObject

@property(nonatomic, strong) YICalculatorView *calculatorView;

@property(nonatomic, assign) int maxLengthDecimal; // 小数位 最大的个数 默认为 6
@property(nonatomic, assign) BOOL enableArithmeticPriority;  // 算术优先级 默认为 NO
@property(nonatomic, assign) int maxLengthNumber;  // 数字 最大的个数 默认为12

@property(nonatomic, assign) double tempNumber; // 临时的值
@property(nonatomic, assign) int operator; // 操作符
@property(nonatomic, assign) double currentNumber; // 当前的值
@property(nonatomic, assign) BOOL isDecimal; //是否是小数
@property(nonatomic, assign) int decimals;   //小数位数

@property(nonatomic, assign) BOOL abnormalInput; // 异常输入

@property(nonatomic, strong) NSMutableArray *inputs; // 输入队列


#pragma mark - ---UI---
@property(nonatomic, assign) int writeOp;

@property(nonatomic, assign) BOOL writeResult;
@property(nonatomic, assign) BOOL writeInLastLbl;
@property(nonatomic, assign) BOOL writeNextLine;
@property(nonatomic, assign) BOOL writeIsOperator;
#pragma mark - ---UI---


#pragma mark -

- (void)inputObject:(int)tag;

- (double)calCurrentNumberWithDigit:(int)digit;

- (double)calCurrentNumberWithBinaryOperator:(int)tag;

- (double)calCurrentNumberWithUnaryOperator:(int)tag;

- (double)calCurrentNumberWithDot:(int)tag;

- (double)calCurrentNumberWithTag:(int)tag;

+ (NSString *)signTextOnTag:(int)tag;
@end



