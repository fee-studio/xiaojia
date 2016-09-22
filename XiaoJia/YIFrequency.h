//
//  YIFrequency.h
//  XiaoJia
//
//  Created by efeng on 16/9/1.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import <Realm/Realm.h>

@interface YIFrequency : RLMObject

@property int id;
@property NSString *name;
@property NSString *remarks;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<YIFrequency>
RLM_ARRAY_TYPE(YIFrequency)
