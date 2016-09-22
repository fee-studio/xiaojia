//
// Created by efeng on 16/9/4.
// Copyright (c) 2016 buerguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YIPhase.h"

//enum
typedef NS_ENUM(NSUInteger, MonthButtonType) {
    MonthButtonTypeNormal,
    MonthButtonTypeStart,
    MonthButtonTypeEnd,
};

@interface YIMonthButton : UIButton

@property (nonatomic) NSDate *month;
@property (nonatomic) NSString *title;
@property (nonatomic, assign) MonthButtonType type;
@property (nonatomic, strong) RLMArray<YIPhase *><YIPhase> *phaseList;

+ (YIMonthButton *)instance;


- (void)setYear:(int)year month:(int)month;
- (void)printDate;

@end