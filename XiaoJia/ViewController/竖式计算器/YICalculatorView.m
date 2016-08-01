//
// Created by efeng on 16/3/11.
// Copyright (c) 2016 buerguo. All rights reserved.
//

#import "YICalculatorView.h"

@interface YICalculatorView () {
    UILabel *lblDisplay;
    UIView *contentView;

    UIButton *previousBtn;
    UILabel *lastLbl;
}

@end

@implementation YICalculatorView

@synthesize lblDisplay2;


- (instancetype)init {
    self = [super init];
    if (self) {
        UIView *operationView = [self zoneOfOperation];
        operationView.backgroundColor = kAppColorBlack;
        [self addSubview:operationView];
        [operationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(operationView.superview);
            make.right.equalTo(operationView.superview);
            make.bottom.equalTo(operationView.superview);
            make.height.equalTo(operationView.mas_width);
        }];

        UIView *displayView = [self zoneOfVertical];
        [self addSubview:displayView];
        [displayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(displayView.superview);
            make.right.equalTo(displayView.superview);
            make.top.equalTo(displayView.superview);
            make.bottom.equalTo(operationView.mas_top);
        }];

//        [operationView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(operationView.superview);
//            make.top.equalTo(operationView.superview);
//            make.bottom.equalTo(operationView.superview);
//            make.width.equalTo(operationView.mas_height);
//        }];
//
//        [displayView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(displayView.superview);
//            make.top.equalTo(displayView.superview);
//            make.bottom.equalTo(displayView.superview);
//            make.left.equalTo(operationView.mas_right).offset(1);
//        }];
    }

    return self;
}

// tell UIKit that you are using AutoLayout
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (UIView *)zoneOfOperation {
    UIView *view = [UIView new];

    // 黑色显示屏
    lblDisplay = [UILabel new];
    lblDisplay.tag = 4000;
    lblDisplay.backgroundColor = [UIColor darkGrayColor];
    lblDisplay.textColor = kAppColorWhite;
    lblDisplay.textAlignment = NSTextAlignmentRight;
    lblDisplay.font = [UIFont fontWithName:@"Menlo" size:30.f];
    [view addSubview:lblDisplay];
    [lblDisplay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lblDisplay.superview);
        make.right.equalTo(lblDisplay.superview);
        make.top.equalTo(lblDisplay.superview);
        make.height.equalTo(@0); // 不显示这个真实数据的显示屏
    }];

    // 黑色显示屏
    lblDisplay2 = [UILabel new];
    lblDisplay2.tag = 4000;
    lblDisplay2.backgroundColor = [UIColor blackColor];
    lblDisplay2.textColor = kAppColorWhite;
    lblDisplay2.textAlignment = NSTextAlignmentRight;
    lblDisplay2.adjustsFontSizeToFitWidth = YES;
    lblDisplay2.font = [UIFont fontWithName:@"Menlo" size:50.f];
    [view addSubview:lblDisplay2];
    [lblDisplay2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lblDisplay2.superview);
        make.right.equalTo(lblDisplay2.superview);
        make.top.equalTo(lblDisplay.mas_bottom);
        make.height.equalTo(@60);
    }];

//	UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(moveShowZone:)];
//	[lblDisplay2 addGestureRecognizer:longPress];
//	lblDisplay2.userInteractionEnabled = YES;

    // 删除退格键
    UIButton *deleteBtn = [self btnCalculatorWithSuperView:view tag:OPERATOR_DELETE title:@"退格"];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(deleteBtn.superview);
        make.top.equalTo(lblDisplay2.mas_bottom).offset(separator);
    }];


    // 清除键
    UIButton *clearBtn = [self btnCalculatorWithSuperView:view tag:OPERATOR_CLEAR title:@"清除"];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(deleteBtn.mas_right).offset(separator);
        make.top.equalTo(deleteBtn);
    }];

    // %键
    UIButton *percentBtn = [self btnCalculatorWithSuperView:view tag:OPERATOR_PERCENT title:@"%"];
    [percentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(clearBtn.mas_right).offset(separator);
        make.top.equalTo(deleteBtn);
    }];

    // /键
    UIButton *divisionBtn = [self btnCalculatorWithSuperView:view tag:OPERATOR_DIVISION title:@"÷"];
    [divisionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(percentBtn.mas_right).offset(separator);
        make.top.equalTo(deleteBtn);
        make.right.equalTo(divisionBtn.superview);

        make.width.equalTo(percentBtn);
        make.width.equalTo(clearBtn);
        make.width.equalTo(deleteBtn);
    }];


    // 7键
    UIButton *sevenBtn = [self btnCalculatorWithSuperView:view tag:DIGIT_SEVEN title:@"7"];
    [sevenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sevenBtn.superview);
        make.top.equalTo(deleteBtn.mas_bottom).offset(separator);
    }];

    // 8键
    UIButton *eightBtn = [self btnCalculatorWithSuperView:view tag:DIGIT_EIGHT title:@"8"];
    [eightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(clearBtn);
        make.top.equalTo(sevenBtn);
    }];

    // 9键
    UIButton *nineBtn = [self btnCalculatorWithSuperView:view tag:DIGIT_NINE title:@"9"];
    [nineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(percentBtn);
        make.top.equalTo(sevenBtn);
    }];

    // *键
    UIButton *multipleBtn = [self btnCalculatorWithSuperView:view tag:OPERATOR_MULTIPLE title:@"×"];
    [multipleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(divisionBtn);
        make.top.equalTo(sevenBtn);
        make.right.equalTo(multipleBtn.superview);

        make.width.equalTo(nineBtn);
        make.width.equalTo(eightBtn);
        make.width.equalTo(sevenBtn);
    }];


    // 4键
    UIButton *fourBtn = [self btnCalculatorWithSuperView:view tag:DIGIT_FOUR title:@"4"];
    [fourBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fourBtn.superview);
        make.top.equalTo(sevenBtn.mas_bottom).offset(separator);
    }];

    // 5键
    UIButton *fiveBtn = [self btnCalculatorWithSuperView:view tag:DIGIT_FIVE title:@"5"];
    [fiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(clearBtn);
        make.top.equalTo(fourBtn);
    }];

    // 6键
    UIButton *fixBtn = [self btnCalculatorWithSuperView:view tag:DIGIT_SIX title:@"6"];
    [fixBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(percentBtn);
        make.top.equalTo(fourBtn);
    }];

    // -键
    UIButton *minusBtn = [self btnCalculatorWithSuperView:view tag:OPERATOR_MINUS title:@"-"];
    [minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(divisionBtn);
        make.top.equalTo(fourBtn);
        make.right.equalTo(minusBtn.superview);
        make.width.equalTo(fixBtn);
        make.width.equalTo(fiveBtn);
        make.width.equalTo(fourBtn);
    }];


    // 1键
    UIButton *oneBtn = [self btnCalculatorWithSuperView:view tag:DIGIT_ONE title:@"1"];
    [oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneBtn.superview);
        make.top.equalTo(fourBtn.mas_bottom).offset(separator);
    }];

    // 2键
    UIButton *twoBtn = [self btnCalculatorWithSuperView:view tag:DIGIT_TWO title:@"2"];
    [twoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(clearBtn);
        make.top.equalTo(oneBtn);
    }];

    // 3键
    UIButton *threeBtn = [self btnCalculatorWithSuperView:view tag:DIGIT_THREE title:@"3"];
    [threeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(percentBtn);
        make.top.equalTo(oneBtn);
    }];

    // +键
    UIButton *addBtn = [self btnCalculatorWithSuperView:view tag:OPERATOR_ADD title:@"+"];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(divisionBtn);
        make.top.equalTo(oneBtn);
        make.right.equalTo(addBtn.superview);

        make.width.equalTo(threeBtn);
        make.width.equalTo(twoBtn);
        make.width.equalTo(oneBtn);
    }];

    // 0键
    UIButton *zeroBtn = [self btnCalculatorWithSuperView:view tag:DIGIT_ZERO title:@"0"];
    [zeroBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(zeroBtn.superview);
        make.top.equalTo(oneBtn.mas_bottom).offset(separator);
        make.bottom.equalTo(zeroBtn.superview);

        make.height.equalTo(oneBtn);
        make.height.equalTo(fourBtn);
        make.height.equalTo(sevenBtn);
        make.height.equalTo(deleteBtn);
    }];

    // .键
    UIButton *dotBtn = [self btnCalculatorWithSuperView:view tag:DIGIT_DOT title:@"."];
    [dotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(clearBtn);
        make.top.equalTo(zeroBtn);
        make.bottom.equalTo(dotBtn.superview);
        make.height.equalTo(twoBtn);
        make.height.equalTo(fiveBtn);
        make.height.equalTo(eightBtn);
        make.height.equalTo(clearBtn);
    }];

    // +/-键
    UIButton *negativeBtn = [self btnCalculatorWithSuperView:view tag:OPERATOR_NEGATIVE title:@"±"];
    [negativeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(percentBtn);
        make.top.equalTo(zeroBtn);
        make.bottom.equalTo(negativeBtn.superview);

        make.height.equalTo(threeBtn);
        make.height.equalTo(fixBtn);
        make.height.equalTo(nineBtn);
        make.height.equalTo(percentBtn);
    }];

    // =键
    UIButton *equalBtn = [self btnCalculatorWithSuperView:view tag:OPERATOR_EQUAL title:@"="];
    [equalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(divisionBtn);
        make.top.equalTo(zeroBtn);
        make.right.equalTo(equalBtn.superview);
        make.bottom.equalTo(equalBtn.superview);

        make.width.equalTo(negativeBtn);
        make.width.equalTo(dotBtn);
        make.width.equalTo(zeroBtn);

        make.height.equalTo(addBtn);
        make.height.equalTo(minusBtn);
        make.height.equalTo(multipleBtn);
        make.height.equalTo(divisionBtn);
    }];

    for (UIView *v in  view.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *) v;
            int tag = (int) button.tag;
            if ((tag >= OPERATOR_ADD && tag <= OPERATOR_EQUAL)
                    || (tag >= OPERATOR_DELETE && tag <= OPERATOR_PERCENT)) {
                [button setBackgroundImage:[UIImage imageWithColor:[UIColor cantaloupeColor]] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageWithColor:[UIColor chiliPowderColor]] forState:UIControlStateSelected];
                [button setTitleColor:kAppColorWhite forState:UIControlStateNormal];
            } else {
                [button setBackgroundImage:[UIImage imageWithColor:[UIColor beigeColor]] forState:UIControlStateNormal];
                [button setBackgroundImage:[UIImage imageWithColor:[UIColor creamColor]] forState:UIControlStateSelected];
                [button setTitleColor:kAppColorBlack forState:UIControlStateNormal];
            }
        }
    }

    return view;
}

//- (UIButton *)btnCalculatorTag:(NSUInteger)tag title:(NSString *)title layoutCallback:(void(^)(UIButton *button))callback {

- (UIButton *)btnCalculatorWithSuperView:(UIView *)superView
                                     tag:(NSUInteger)tag
                                   title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    button.titleLabel.font = [UIFont fontWithName:@"Menlo" size:30];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(operationAction:) forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:button];
    return button;
}

- (UIView *)zoneOfVertical {
    UIView *view = [UIView new];

    self.scrollView = [UIScrollView new];
    _scrollView.backgroundColor = kAppColorYellow;
    [view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView.superview);
    }];

    contentView = UIView.new;
    [self.scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];

    return view;
}

- (void)resetVerticalZone {
    if (contentView) {
        [contentView removeFromSuperview];
        contentView = nil;
        contentView = UIView.new;
        [self.scrollView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scrollView);
            make.width.equalTo(self.scrollView);
        }];
    }

    lastLbl = nil;
}

- (void)operationAction:(UIButton *)button {
    previousBtn.selected = NO;
    button.selected = YES;
    previousBtn = button;

    if ([_delegate respondsToSelector:@selector(clickButtonTag:)]) {
        [_delegate clickButtonTag:(int) button.tag];
    }
}

- (void)clearFormulaTvBtnAction:(UIButton *)button {

}

- (void)setDisplayLblText:(double)value {
    // 只打印值
    lblDisplay.text = [NSString stringWithFormat:@"%lf", value];
    // 格式化
    NSString *numberText = [self formatterNumber:self.calManager.currentNumber];
    lblDisplay2.text = numberText;


//	NSString *formatString;
//	NSString *valueText;
//	if (self.calManager.isDecimal) {
//		if (self.calManager.decimals) {
//			formatString = [NSString stringWithFormat:@"%%.%dlf", MIN(self.calManager.decimals, self.calManager.maxLengthDecimal)];
//			valueText = [NSString stringWithFormat:formatString,value];
//		} else {
//			formatString = @"%ld.";
//			valueText = [NSString stringWithFormat:formatString,(long)value];
//		}
//	} else {
//		formatString = @"%ld";
//		valueText = [NSString stringWithFormat:formatString,(long)value];
//	}
//	lblDisplay2.text = valueText;


//	double decimal = self.calManager.currentNumber - (long) self.calManager.currentNumber;
//	if (decimal) {
//		NSString *decimalString = [@(self.calManager.currentNumber) stringValue];
//		self.calManager.isDecimal = YES;
//		self.calManager.decimals = (int) [[[decimalString componentsSeparatedByString:@"."] lastObject] length];
//	} else {
//		self.calManager.isDecimal = NO;
//		self.calManager.decimals = 0;
//	}


//	NSNumber *number = [@(self.calManager.currentNumber) stringValue];
}

- (NSString *)formatterNumber:(double)number {
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setNumberStyle:NSNumberFormatterDecimalStyle];
    [nf setMaximumFractionDigits:self.calManager.maxLengthDecimal];
    [nf setMaximumIntegerDigits:self.calManager.maxLengthNumber];
    NSString *numberText = [nf stringFromNumber:@(number)];
    return numberText;
}

float rightOffset = -60.f;
float leftOffset = 20.f;
float heightLbl = 30.f;
float fontSizeLbl = 30.f;
float separator = 0.5f;

- (void)drawLblCurNumberText:(double)curNumber
                    operator:(int)operator
              writeInLastLbl:(BOOL)isLast
                    nextLine:(BOOL)next
                  isOperator:(BOOL)isOperator
                    isResult:(BOOL)isResult {
    // 异常输入就返回不画任何东西
    if (self.calManager.abnormalInput) {
        return;
    }

    // 按清除键的显示逻辑
    if (OPERATOR_CLEAR == self.calManager.writeOp) {
        [self resetVerticalZone];
        return;
    }

    // 显示的时候带有结果值
    if (isResult) {
        if (self.calManager.writeOp >= OPERATOR_DELETE && self.calManager.writeOp <= OPERATOR_NEGATIVE) { // 一元操作符
            UILabel *opLbl = [UILabel new];
            opLbl.text = [YICalculatorManager signTextOnTag:self.calManager.writeOp];
            opLbl.font = [UIFont fontWithName:@"Menlo" size:20.f];
            opLbl.textAlignment = NSTextAlignmentCenter;
            opLbl.backgroundColor = kAppColorYellow;
            opLbl.adjustsFontSizeToFitWidth = YES;
            [contentView addSubview:opLbl];
            [opLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastLbl ? lastLbl : @0);
                make.right.equalTo(opLbl.superview).with.offset(-10);
                make.height.equalTo(@(heightLbl));
                make.width.equalTo(@(heightLbl));
            }];
            lastLbl.text = [self formatterNumber:curNumber];
            return;
        } else {
            UILabel *linelbl = [UILabel new];
            linelbl.backgroundColor = kAppColorBlack;
            [contentView addSubview:linelbl];
            [linelbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastLbl ? lastLbl.mas_bottom : @0);
                make.left.equalTo(linelbl.superview);
                make.right.equalTo(linelbl.superview);
                make.height.equalTo(@(1));
            }];
            lastLbl = linelbl;

            UILabel *resultLbl = [UILabel new];
            resultLbl.text = [self formatterNumber:curNumber];
            resultLbl.font = [UIFont fontWithName:@"Menlo" size:fontSizeLbl];
            resultLbl.textAlignment = NSTextAlignmentRight;
            resultLbl.adjustsFontSizeToFitWidth = YES;
            [contentView addSubview:resultLbl];
            [resultLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastLbl ? lastLbl.mas_bottom : @0);
                make.right.equalTo(resultLbl.superview).offset(rightOffset);
                make.left.equalTo(resultLbl.superview).offset(60);
                make.height.equalTo(@(heightLbl));
            }];
            lastLbl = resultLbl;

            if (operator >= OPERATOR_ADD && operator <= OPERATOR_DIVISION) { // 二元操作符
                UILabel *opLbl = [UILabel new];
                opLbl.text = [YICalculatorManager signTextOnTag:operator];
                opLbl.backgroundColor = kAppColorYellow;
                opLbl.font = [UIFont fontWithName:@"Menlo" size:fontSizeLbl];
                opLbl.textAlignment = NSTextAlignmentCenter;
                [contentView addSubview:opLbl];
                [opLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(lastLbl ? lastLbl.mas_bottom : @0);
                    make.left.equalTo(opLbl.superview).with.offset(leftOffset);
                    make.width.equalTo(@(heightLbl));
                    make.height.equalTo(@(heightLbl));
                }];
                lastLbl = opLbl;
            }

            [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.scrollView);
                make.width.equalTo(self.scrollView);
                make.bottom.equalTo(lastLbl ? lastLbl : @0);
            }];

            [contentView layoutIfNeeded]; // 这里是关键：After the layoutIfNeeded call, the frame for your view should be right.
            [self setNeedsLayout];

            return;
        }
    }

    if (isOperator && operator == OPERATOR_EQUAL) {  // 不是显示结果，但是是（=）号时
        UILabel *linelbl = [UILabel new];
        linelbl.backgroundColor = [UIColor blackColor];
        [contentView addSubview:linelbl];
        [linelbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastLbl ? lastLbl.mas_bottom : @0);
            make.left.equalTo(linelbl.superview);
            make.right.equalTo(linelbl.superview);
            make.height.equalTo(@(1));
        }];
        lastLbl = linelbl;

        UILabel *resultLbl = [UILabel new];
        resultLbl.text = [self formatterNumber:curNumber];
        resultLbl.font = [UIFont fontWithName:@"Menlo" size:fontSizeLbl];
        [contentView addSubview:resultLbl];
        [resultLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastLbl ? lastLbl.mas_bottom : @0);
            make.right.equalTo(resultLbl.superview).offset(rightOffset);
            make.height.equalTo(@(heightLbl));
        }];
        lastLbl = resultLbl;
        [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scrollView);
            make.width.equalTo(self.scrollView);
            make.bottom.equalTo(lastLbl ? lastLbl : @0);
        }];

        [contentView layoutIfNeeded]; // 这里是关键：After the layoutIfNeeded call, the frame for your view should be right.
        [self setNeedsLayout];
        return;
    }

    // 普通的显示
    if (isLast && lastLbl) {
        lastLbl.text = [self formatterNumber:curNumber];
    } else {
        UILabel *lbl = [UILabel new];
        if (isOperator) {
            lbl.text = [YICalculatorManager signTextOnTag:operator];
            lbl.backgroundColor = kAppColorYellow;
            lbl.textAlignment = NSTextAlignmentCenter;
        } else {
            lbl.text = [self formatterNumber:curNumber];
            lbl.textAlignment = NSTextAlignmentRight;
            lbl.adjustsFontSizeToFitWidth = YES;
        }
        lbl.font = [UIFont fontWithName:@"Menlo" size:fontSizeLbl];

        [contentView addSubview:lbl];

        [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
            if (next) {
                if (isOperator) {
                    make.top.equalTo(lastLbl ? lastLbl.mas_bottom : lbl.superview);
                } else {
                    make.top.equalTo(lastLbl ? lastLbl.mas_bottom : lbl.superview).offset(20);
                }
            } else {
                make.top.equalTo(lastLbl ? lastLbl : lbl.superview);
            }
            if (isOperator) {
                make.left.equalTo(lbl.superview).offset(leftOffset);
                make.width.equalTo(@(heightLbl));
            } else {
                make.right.equalTo(lbl.superview).offset(rightOffset);
                make.left.equalTo(lbl.superview).offset(60);
            }

            make.height.equalTo(@(heightLbl));
        }];
        lastLbl = lbl;

        [contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scrollView);
            make.width.equalTo(self.scrollView);
            make.bottom.equalTo(lastLbl ? lastLbl : @0);
        }];
        [contentView layoutIfNeeded]; // 这里是关键：After the layoutIfNeeded call, the frame for your view should be right.
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    [self.scrollView setContentOffset:CGPointMake(0, MAX(0, contentView.height - self.scrollView.height)) animated:YES];
}


#pragma mark -

CGPoint _priorPoint;

- (void)moveShowZone:(UILongPressGestureRecognizer *)gesture {
    UIView *movedView = gesture.view;
    CGPoint point = [gesture locationInView:movedView.superview];
    [YILogUtil logPoint:point andName:@"point-name"];

    if (gesture.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.2 animations:^{
            movedView.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1);
        }];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {

        //move your views here.
        CGPoint center = movedView.center;
//		center.x += point.x - _priorPoint.x;
        center.y += point.y - _priorPoint.y;
        movedView.center = center;


    } else if (gesture.state == UIGestureRecognizerStateEnded) {

    }
    _priorPoint = point;
}


@end