//
//  YIFamily.h
//  XiaoJia
//
//  Created by efeng on 16/9/1.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import <Realm/Realm.h>
#import "YIPhase.h"

@interface YIFamily : RLMObject

@property NSString *name;
@property NSString *remarks; // 备注

@property RLMArray<YIPhase *><YIPhase> *phaseList; // 阶段

//@property RLMArray<YIBill *><YIBill> *bills;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<YIFamily>
RLM_ARRAY_TYPE(YIFamily)
