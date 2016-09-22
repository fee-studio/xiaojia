//
//  YIPhase.h
//  XiaoJia
//
//  Created by efeng on 16/9/1.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import <Realm/Realm.h>
#import "YIIncome.h"
#import "YIExpenses.h"

@interface YIPhase : RLMObject

@property NSString *name;
@property NSString *remarks; // 备注

@property NSDate *startDate;
@property NSDate *endDate;

@property BOOL isTemp;  // 是否为临时的数据：正在添加时候的数据

@property RLMArray<YIIncome *><YIIncome> *incomeList;
@property RLMArray<YIExpenses *><YIExpenses> *expensesList;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<YIPhase>
RLM_ARRAY_TYPE(YIPhase)
