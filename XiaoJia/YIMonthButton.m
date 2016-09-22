//
// Created by efeng on 16/9/4.
// Copyright (c) 2016 buerguo. All rights reserved.
//

#import "YIMonthButton.h"
#import "Categories.h"


@implementation YIMonthButton {

}


- (instancetype)init {
    self = [super init];
    if (self) {
    }

    return self;
}


+ (YIMonthButton *)instance {
    YIMonthButton *_instance = [YIMonthButton buttonWithType:UIButtonTypeCustom];
    [_instance setBackgroundImage:[UIImage imageFromUIColor:kAppColorLightGray] forState:UIControlStateNormal];
    [_instance setBackgroundImage:[UIImage imageFromUIColor:kAppColorOrange] forState:UIControlStateSelected];
    [_instance setBackgroundImage:[UIImage imageFromUIColor:kAppColorRed] forState:UIControlStateDisabled];

    return _instance;
}

//- (NSDate *)month {
//    return nil;
//}

//- (NSString *)title {
//    return nil;
//}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setYear:(int)year month:(int)month; {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:month];
    [components setYear:year];
    NSDate *_date = [calendar dateFromComponents:components];

    _month = _date;

    self.selected = NO;
    self.enabled = YES;
    for (int i = 0; i < _phaseList.count; i++) {
        YIPhase *phase = _phaseList[i];
		if (phase.startDate && phase.endDate) {
			if ([phase.startDate compare:phase.endDate] == NSOrderedSame) {
				
			} else if (([phase.startDate compare:_month] == NSOrderedAscending || ([phase.startDate compare:_month] == NSOrderedSame))
				&& ([_month compare:phase.endDate] == NSOrderedAscending || ([_month compare:phase.endDate] == NSOrderedSame))) {
				// 临时的数据是可以更改的, 非临时的数据不让改啦
				self.enabled = phase.isTemp;
				if (self.enabled) {
					self.selected = YES;
				}				
			}
		}
    }

//    for (YIPhase *phase in _phaseList) {
//        if (([phase.startDate compare:_month] == NSOrderedAscending || ([phase.startDate compare:_month] == NSOrderedSame))
//                && ([_month compare:phase.endDate] == NSOrderedAscending || ([_month compare:phase.endDate] == NSOrderedSame))) {
//            self.selected = YES;
//        }
//    }
}

- (void)printDate {
    NSDateComponents *componentsOut = [[NSCalendar currentCalendar]
            components:NSCalendarUnitDay
                    | NSCalendarUnitMonth
                    | NSCalendarUnitYear
              fromDate:_month];
    NSInteger day1 = [componentsOut day];
    NSInteger month1 = [componentsOut month];
    NSInteger year1 = [componentsOut year];

    NSLog(@"year = %d, month = %d, day = %d", year1, month1, day1);
}


- (void)layoutSubviews {
    [super layoutSubviews];

    self.layer.cornerRadius = self.width / 2.f;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer.borderWidth = self.width / 2.f / 2.5f;
    self.layer.masksToBounds = YES;

}


@end
