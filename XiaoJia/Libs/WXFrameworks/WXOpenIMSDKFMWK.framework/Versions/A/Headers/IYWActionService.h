//
//  IYWConnectorService.h
//  WXOpenIMSDK
//
//  Created by huanglei on 4/29/15.
//  Copyright (c) 2015 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YWIMCore;

/**
 *  概念：
 *  Action机制：云旺中定义的一种模块间的通信机制。
 *  Action：由多个Event组成，一般表示的是相同的动作。云旺会依次执行这组Event，直到其中一个Event是能够被执行的。
 *  Event：事件，例如："openim://p2pconversation/sendText"。一般地，您不能使用openim://开头的保留Event。
 *  Handler:当Event被发出时，云旺会找到对应的Handler来作出响应。Handler声明了他所要处理的Event，Event的处理回调以及其他一些属性。
 */



/**
 *  Handler处理事件完成后，需要调用这个block，告知云旺处理结果
 *  @param aError 如果出错，则在aError传递错误信息，你需要在aError的userInfo中使用 YWErrorUserInfoKeyDescription 来传递错误描述。
 *  @param aResult 如果处理成功，使用aResult返回处理结果数据
 */
typedef void(^YWActionHandlerResultBlock)(NSError *aError, NSDictionary *aResult);

/**
 *  处理Event的回调block定义
 *  @param aParams 传递Event对应的参数
 *  @param aResultBlock 当Handler处理事件完成后，调用aResultBlock，告知处理结果
 */
typedef void(^YWActionHandlerBlock)(NSString *aEvent, NSDictionary *aParams, YWActionHandlerResultBlock aResultBlock);

/// Action错误域
FOUNDATION_EXTERN NSString *const YWActionErrorDomain;

/**
 *  您需要实现IYWActionHandler协议，来实现一个Handler
 */
@protocol IYWActionHandler <NSObject>

@required

/**
 *  声明了Handler所处理的Event，为多个字符串组成的数组
 */
- (NSArray *)actionEvent;

/**
 *  声明了处理Event的回调函数
 */
- (YWActionHandlerBlock)actionHandlerBlock;

@optional

/**
 *  声明是否需要主线程回调
 *  默认为YES
 */
- (BOOL)actionHandlerOnMainThread;


@end

@protocol IYWActionService <NSObject>

/**
 *  注册handler
 *  @return 如果Handler的Event为空或者block为空，则返回NO
 */
- (BOOL)registerHandler:(id<IYWActionHandler>)aHandler;

/**
 *  发送单个event
 *  您可以手动调用此函数，发出事件，获得事件的处理结果
 */
- (void)sendEvent:(NSString *)aEvent
           params:(NSDictionary *)aParams
handlerResultBlock:(YWActionHandlerResultBlock)aHandlerResultBlock;


/**
 *  执行一个Action字符串
 *  一个Action字符串可能是单个Event，也可能是包含多个Event的JSON数组
 *  例如：   wangwang://h5/open?url=www.taobao.com   这是一个action字符串
 *  例如：   ["http://www.taobao.com", "https://www.taobao.com", "wangwang://h5/open?url=www.taobao.com"]    这也是一个action字符串
 *  传入当前的YWImcore对象作为context，如果为nil，将会使用SDK的默认行为
 */
- (void)callActionWithActionString:(NSString *)aActionString
                  additionalParams:(NSDictionary *)aAdditionalParams
                handlerResultBlock:(YWActionHandlerResultBlock)aHandlerResultBlock;

- (void)callActionWithActionString:(NSString *)aActionString baseContext:(YWIMCore *)aImcore
                  additionalParams:(NSDictionary *)aAdditionalParams
                handlerResultBlock:(YWActionHandlerResultBlock)aHandlerResultBlock;

@end


