////
////  YIBaseRequest.h
////  Emma
////
////  Created by efeng on 15/7/24.
////  Copyright (c) 2015年 weiboyi. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//
//
//typedef NS_ENUM(NSUInteger, RequestType) {
//    RequestTypeHTTP,
//    RequestTypeHTTPS,
//    RequestTypeAuth
//};
//
//typedef NS_ENUM(NSUInteger, RequestMethod) {
//    RequestMethodGET,
//    RequestMethodPOST,
//};
//
//@interface YIBaseRequest : NSObject
//
//@property(nonatomic, strong, readonly) NSString *baseUrl;
//
//@property(nonatomic, strong) NSDictionary *parameters; // 对单一请求的赋值
//
//@property(nonatomic, strong, readonly) NSMutableDictionary *allParameters; // 对网络请求时,所有的参数
//
//- (instancetype)initWithParameters:(NSDictionary *)parameters;
//
//+ (instancetype)requestWithParameters:(NSDictionary *)parameters;
//
//
//// 公共的方法.每个子类都要实现
//- (NSString *)urlString;
//
//- (RequestMethod)requestMethod;
//
//- (RequestType)requestType;
//
//- (NSString *)requestUrlString;
//
//
//@end
