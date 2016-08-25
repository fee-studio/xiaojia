//
//  YWMessageBodySystemNotify.h
//
//
//  Created by 慕桥(黄玉坤) on 1/28/15.
//  Copyright (c) 2015 taobao. All rights reserved.
//

#import "YWMessageBody.h"


@interface YWMessageBodySystemNotify : YWMessageBody

// 系统通知内容
@property (nonatomic, strong, readonly) NSString *content;

// 其他附加数据
@property (nonatomic, strong, readonly) NSDictionary *userData;


- (instancetype)initWithContent:(NSString *)content;

@end
