//
//  YIIncome.h
//  XiaoJia
//
//  Created by efeng on 16/9/1.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import <Realm/Realm.h>
#import "YIFrequency.h"
#import "YIIncomeTag.h"

@interface YIIncome : RLMObject

@property YIIncomeTag *incomeTag;
@property YIFrequency *frequency;
@property float money;

@property NSString *remarks;


@end

// This protocol enables typed collections. i.e.:
// RLMArray<YIIncome>
RLM_ARRAY_TYPE(YIIncome)
