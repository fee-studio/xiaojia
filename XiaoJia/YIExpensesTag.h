//
//  YIExpensesTag.h
//  XiaoJia
//
//  Created by efeng on 16/9/1.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import <Realm/Realm.h>

@interface YIExpensesTag : RLMObject

@property NSInteger id;
@property NSString *name;
@property NSString *remarks;
@property NSString *iconName;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<YIExpensesTag>
RLM_ARRAY_TYPE(YIExpensesTag)
