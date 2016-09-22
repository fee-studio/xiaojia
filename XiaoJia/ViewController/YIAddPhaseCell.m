//
// Created by efeng on 16/9/4.
// Copyright (c) 2016 buerguo. All rights reserved.
//

#import "YIAddPhaseCell.h"
#import "YIMonthButton.h"

@interface YIAddPhaseCell () {

}

@end

@implementation YIAddPhaseCell {

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *lastView;
        for (int j = 0; j < 12; ++j) {
            YIMonthButton *button = [YIMonthButton instance];
            button.tag = j + 1000;
            [button addTarget:self action:@selector(monthBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                if (j / 6 == 0) {
                    make.left.equalTo(lastView ? lastView.mas_right : button.superview);
                    make.top.equalTo(button.superview).offset(1);
                    if (lastView) {
                        make.width.equalTo(lastView);
                    }
                    make.height.equalTo(button.mas_width);
                    if (j == 6 - 1 && lastView) {
                        make.right.equalTo(button.superview);
                    }
                } else {
                    if (j - 6 == 0) {
                        make.left.equalTo(button.superview);
                        make.top.equalTo(lastView.mas_bottom);
                    } else {
                        make.left.equalTo(lastView.mas_right);
                        make.top.equalTo(lastView.mas_top);
                    }

                    if (lastView) {
                        make.width.equalTo(lastView);
                    }

                    make.height.equalTo(button.mas_width);
                    if (j == 12 - 1 && lastView) {
                        make.right.equalTo(button.superview);
                    }
                    make.bottom.equalTo(button.superview).offset(-1);
                }
            }];

            lastView = button;
        }
    }


    return self;
}


// 看下面是如何把一件事做复杂的? 好多所谓的用功的coder不都是这样的吗?
- (void)setupCellWithYear:(int)year andSelectedPhase:(RLMArray<YIPhase *> <YIPhase> *)phaseList; {
    for (int j = 0; j < 12; ++j) {
        YIMonthButton *button = [self viewWithTag:j + 1000];
        button.phaseList = phaseList;
        [button setTitle:[@(j + 1) stringValue]];
        [button setYear:year month:[button.title intValue]];
    }
    NSLog(@"year = %d", year);

}

- (void)setupCellStyle:(RLMArray<YIPhase *> <YIPhase> *)phaseList; {
    for (YIPhase *phase in phaseList) {

        NSDateComponents *startDateComponents = [[NSCalendar currentCalendar]
                components:NSCalendarUnitDay
                        | NSCalendarUnitMonth
                        | NSCalendarUnitYear
                  fromDate:phase.startDate];
        NSInteger startYear = [startDateComponents year];
        NSInteger startMonth = [startDateComponents month];
        NSInteger startDay = [startDateComponents day];

        NSDateComponents *endDateComponents = [[NSCalendar currentCalendar]
                components:NSCalendarUnitDay
                        | NSCalendarUnitMonth
                        | NSCalendarUnitYear
                  fromDate:phase.endDate];
        NSInteger endYear = [endDateComponents year];
        NSInteger endMonth = [endDateComponents month];
        NSInteger endDay = [endDateComponents day];
		
		
		

    }
}

- (void)monthBtnAction:(YIMonthButton *)button {
//    button.selected = !button.selected;

    if ([_delegate respondsToSelector:@selector(selectedDateButton:)]) {
        [_delegate selectedDateButton:button];
    }

    [button printDate];
}


@end
