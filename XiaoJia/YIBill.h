//
//  YIBill.h
//  XiaoJia
//
//  Created by efeng on 16/9/1.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import <Realm/Realm.h>

@interface YIBill : RLMObject

@property (nonatomic, assign) BOOL isIncome;


@end

// This protocol enables typed collections. i.e.:
// RLMArray<YIBill>
RLM_ARRAY_TYPE(YIBill)
