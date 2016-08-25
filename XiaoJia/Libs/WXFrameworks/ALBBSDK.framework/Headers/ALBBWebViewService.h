//
//  ALBBWebViewService.h
//  ALBBAuth
//
//  Created by zhoulai on 15/11/30.
//  Copyright © 2015年 Alipay. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ALBBWebViewProxy.h"

@protocol ALBBWebViewService <NSObject>

/**
 准备百川服务, 在WebView的UserAgent里**追加**百川标识.
 **iOS全局共享UserAgent. 请在UIWebView初始化之前之前调用.**
 */
- (void)prepareService;

/**
 移除百川服务, 删除之前在UserAgent**追加**的百川标识.
 **iOS全局共享UserAgent. 请在UIWebView加载页面完成后调用.**
 */
- (void)releaseService;

#pragma mark - 直接绑定淘宝授权服务方式
/**
 绑定百川淘宝账号免登服务
 使用方式:
  1.如果开发者需要给webview设置delegate，请在设置delegate后再调用，
  这样会优先执行开发者设置的拦截处理逻辑，然后执行百川的拦截处理
  2.确保在webView loadRequest之前调用
 @param webview
 @param sourceViewController  当前显示的UIViewController
 */
- (void)bindLoginService:(UIWebView *)webview sourceViewController:(UIViewController *)sourceViewController;

#pragma mark -  拦截URL检查处理方式
/**
 拦截处理当前webview需要加载的URL,并返回是否允许本次URL请求加载
 @param webviewProxy            开发者实现的WebView代理
 @param url                     当前需要加载的URL
 @param sourceViewController    当前显示的UIViewController
 @return YES=允许加载本次请求 NO=不允许加载，SDK会做其他处理
 */
- (BOOL)isAllowLoadURLRequest:(NSURLRequest *)request
                 webviewProxy:(id<ALBBWebViewProxy>)proxy
         sourceViewController:(UIViewController *)controller;

- (BOOL)isAllowLoadURLRequest:(NSURLRequest *)request
                      webview:(UIWebView *)webview
         sourceViewController:(UIViewController *)controller;

#pragma mark - 传入上下文参数
/**
 增加淘宝电商链路上下文参数，能最终传递到淘宝后台
 比如传入 isv_code:@"yourIsvCode" ，最终订单结果能追踪到该参数
 @param key   键
 @param value 值
 */
- (void)addGlobalParam:(NSString *)key value:(NSString *)value;

@end
