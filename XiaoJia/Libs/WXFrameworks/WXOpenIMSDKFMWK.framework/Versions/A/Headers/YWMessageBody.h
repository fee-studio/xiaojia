//
//  YWMessageBody.h
//  
//
//  Created by huanglei on 14/12/11.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IYWMessage;

/**
 * 消息体的基类
 */

@interface YWMessageBody : NSObject

/**
 *  消息主体
 */
@property (nonatomic, weak, readonly) id<IYWMessage> messageRef;

@end
