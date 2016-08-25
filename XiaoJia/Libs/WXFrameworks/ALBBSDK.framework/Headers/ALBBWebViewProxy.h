//
//  ALBBWebViewProxy.h
//  ALBBAuth
//
//  Created by zhoulai on 15/11/30.
//  Copyright © 2015年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ALBBWebViewProxy <NSObject>

/** 加载请求 */
@required - (void)loadRequest:(NSURLRequest *)request;

/** 重新加载上次请求 */
@required - (void)reload;

/** 回到上次请求的页面，和UIWebView goBack逻辑保持一致 */
@required - (void)goBack;

/**
 执行JS方法，返回执行结果
 注意:UIWebView 提供stringByEvaluatingJavaScriptFromString: 方法是同步执行；
 而iOS 8.0 以上WVWKWebView 提供evaluateJavaScript:completionHandler:是异步执行
 请自行适配此方法
 @param javaScriptString  JSScript
 @param completionHandler
 */
@required - (void)evaluateJavaScript:(NSString *)javaScriptString
                   completionHandler:(void (^)(NSString *result, NSError *error))completionHandler;
@end
