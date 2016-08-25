//
//  BoxMsgImage.h
//  WQClient
//
//  Created by qinghua.liqh on 14-3-7.
//  Copyright (c) 2014年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoxMsgImageNode : NSObject
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *action;

+ (id)parseImageFromDict:(NSDictionary *)dict;
@end
