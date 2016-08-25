//
//  BoxMsgLabel.h
//  WQClient
//
//  Created by qinghua.liqh on 14-3-7.
//  Copyright (c) 2014年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoxMsgLabelNode : NSObject
@property (strong, nonatomic) NSString *label;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) NSString *action;
@property (assign, nonatomic) BOOL isWithStrikeThrough;
@property (assign, nonatomic) BOOL isWithUndelLine;

+ (id)parseLabelFromDict:(NSDictionary *)dict;
@end

@interface BoxMsgLabelPair : NSObject
@property (strong, nonatomic) BoxMsgLabelNode *keyLabel;
@property (strong, nonatomic) BoxMsgLabelNode *valueLabel;
@end