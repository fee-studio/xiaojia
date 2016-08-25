//
//  BoxMsgButton.h
//  WQClient
//
//  Created by qinghua.liqh on 14-3-7.
//  Copyright (c) 2014年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoxMsgButtonNode : NSObject
@property (strong, nonatomic) NSString *label;
@property (assign, nonatomic) int type;
@property (strong, nonatomic) NSString *action;

+ (id)parseButtonFromDict:(NSDictionary *)dict;
@end
