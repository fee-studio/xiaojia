//
//  YITestRLM.h
//  XiaoJia
//
//  Created by efeng on 16/8/29.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import <Realm/Realm.h>

@interface YITestRLM : RLMObject

// todo design database

@end

// This protocol enables typed collections. i.e.:
// RLMArray<YITestRLM>
RLM_ARRAY_TYPE(YITestRLM)
