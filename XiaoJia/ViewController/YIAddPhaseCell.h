//
// Created by efeng on 16/9/4.
// Copyright (c) 2016 buerguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YIPhase.h";

@class YIMonthButton;

@protocol YIAddPhaseCellDelegate<NSObject>

//- (void)selectedDate:(NSDate *)date isAdd:(BOOL)add;
- (void)selectedDateButton:(YIMonthButton *)button;

@end

@interface YIAddPhaseCell : YIBaseTableViewCell

@property (nonatomic, weak) id<YIAddPhaseCellDelegate> delegate;

- (void)setupCellWithYear:(int)year andSelectedPhase:(RLMArray<YIPhase *><YIPhase> *)phaseList;

//- (void)setupCell:(int)year;
//- (void)setupCellStyle:(RLMArray<YIPhase *><YIPhase> *)phaseList;

@end