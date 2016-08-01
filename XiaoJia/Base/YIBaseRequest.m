////
////  YIBaseRequest.m
////  Emma
////
////  Created by efeng on 15/7/24.
////  Copyright (c) 2015年 weiboyi. All rights reserved.
////
//
//#import "YIBaseRequest.h"
//
//
//// 内网测试服务器地址
//NSString *const BASE_URL_ADHOC = @"http://192.168.100.10:8088/emma/api";
//
//// 外网运行服务器地址
//NSString *const BASE_URL_PUBLIC = @"http://emma.rid.cc/emma/api";
//
//// 外网部署类型常量
//NSString *const DEPLOYMENT_PUBLIC = @"public";
//
//@interface YIBaseRequest () {
//
//}
//
//@end
//
//
//@implementation YIBaseRequest
//
//+ (instancetype)requestWithParameters:(NSDictionary *)parameters {
//    return [[self alloc] initWithParameters:parameters];
//}
//
//- (instancetype)initWithParameters:(NSDictionary *)parameters {
//    self = [self init];
//    if (self) {
//        self.parameters = parameters;
//        [self integrateUncommonParameters:_parameters];
//    }
//
//    return self;
//}
//
//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        _allParameters = [NSMutableDictionary dictionaryWithCapacity:10];
//        [self loadCommonParameters];
//    }
//
//    return self;
//}
//
//- (void)loadCommonParameters {
//    _allParameters[@"aid"] = APP_ID;
//
//    _allParameters[@"version"] = [YICommonUtil appVersion];
//    _allParameters[@"channel"] = [YIConfigUtil channelName];
//    _allParameters[@"osname"] = [UIDevice systemName];
//    _allParameters[@"osver"] = [UIDevice systemVersion];
//    _allParameters[@"model"] = [UIDevice deviceModel];
//    _allParameters[@"udid"] = [UIDevice vendorId];
////    _allParameters[@"devtoken"] = mGlobalData.deviceToken ?: @"";
//    _allParameters[@"time"] = [YICommonUtil unixTimestamp];
////    _allParameters[@"network_type"] = mGlobalData.netType ?: @"";
////    _allParameters[@"provider"] = mGlobalData.carrier ?: @""; // 运营商
////    
////    _allParameters[@"country"] = mGlobalData.country?: @"";
////    _allParameters[@"province"] = mGlobalData.province?: @"";
////    _allParameters[@"city"] = mGlobalData.city?: @"";
////    _allParameters[@"district"] = mGlobalData.district?: @"";
////    _allParameters[@"street"] = mGlobalData.street?: @"";
//	
////    _allParameters[@"longitude"] = mGlobalData.longitude?: @"";
////    _allParameters[@"latitude"] = mGlobalData.latitude?: @"";
//
//    _allParameters[@"resolutionWidth"] = [NSString stringWithFormat:@"%f", [UIScreen DPISize].width];
//    _allParameters[@"resolutionHeight"] = [NSString stringWithFormat:@"%f", [UIScreen DPISize].height];
////    _allParameters[@"flight"] = mGlobalData.flight ?: @"0";
//
//    _allParameters[@"remote_notification_switch"] = [YICommonUtil isRegisteredRemoteNotification] ? @"1" : @"0";
//}
//
//- (void)integrateUncommonParameters:(NSDictionary *)uncommonParameters {
//    [_allParameters addEntriesFromDictionary:uncommonParameters];
//}
//
//#pragma mark -
//
//- (NSString *)urlString {
//    return @"";
//}
//
//- (RequestMethod)requestMethod {
//    return RequestMethodGET;
//}
//
//- (RequestType)requestType {
//    return RequestTypeHTTP;
//}
//
//#pragma mark -
//
//- (NSString *)requestUrlString {
//    return [NSString stringWithFormat:@"%@%@", [self baseUrl], [self urlString]];
//}
//
//#pragma mark -
//
//- (NSString *)baseUrl {
//    return BASE_URL_ADHOC;
//}
//
//
//@end
