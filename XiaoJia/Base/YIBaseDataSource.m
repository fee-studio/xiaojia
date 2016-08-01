////
//// Created by efeng on 15/7/24.
//// Copyright (c) 2015 weiboyi. All rights reserved.
////
//
//#import "YIBaseDataSource.h"
//
//
//@implementation YIBaseDataSource {
//
//}
//
//+ (YIBaseDataSource *)instance {
//    static YIBaseDataSource *_instance = nil;
//
//    @synchronized (self) {
//        if (_instance == nil) {
//            _instance = [[self alloc] init];
//        }
//    }
//
//    return _instance;
//}
//
//- (void)handleResponseObject:(id)responseObject andDataTask:(NSURLSessionDataTask *)task; {
//
//    self.urlSessionDataTask = task;
//
//    if ([responseObject isKindOfClass:[NSDictionary class]]) {
//        NSDictionary *response = (NSDictionary *) responseObject;
//        self.aid = [response[@"aid"] integerValue];
//        self.errorCode = [response[@"errorCode"] integerValue];
//        self.flight = response[@"flight"];
//        self.errorMsg = response[@"errorMsg"];
//        self.list = response[@"list"];
//        self.pageIdx = [response[@"pageIdx"] integerValue];
//        self.pageNum = [response[@"pageIdx"] integerValue];
//        self.info = response[@"info"];
//        self.serverTime = [response[@"serverTime"] integerValue];
//    }
//	
////    mGlobalData.flight = self.flight;
//    mGlobalData.serverTime = self.serverTime;
//    // 时差
//    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
//    mGlobalData.localTimeOffset = mGlobalData.serverTime - (NSInteger) nowTime;
//
//    NSLog(@"服务器时间 比 手机时间 快 %ld 秒", (long)mGlobalData.localTimeOffset);
//
//    if (self.aid == 0) {
//        self.error = [NSError dobbyErrorWithCode:ErrorCodeServerDown andMsg:kMessageServerDown];
//        [self.error toHandle];
//    }
//
//    // 正常错误
//    if (self.errorCode) {
//        NSString *errorMsg = self.errorMsg ? self.errorMsg : @"未知错误";
//        self.error = [NSError dobbyErrorWithCode:self.errorCode andMsg:errorMsg];
//        [self.error toHandle];
//    }
//}
//
//
//@end