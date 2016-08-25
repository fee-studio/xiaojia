//
//  TaeTopClient.h
//  ALBBSDK
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 14-9-27.
//  Copyright (c) 2014年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^topRequestCallback)(NSString *result);

@interface TaeTopClient : NSObject
/**
 TOP API调用原始文档: http://open.taobao.com/doc/detail.htm?id=101617
 @param postData    可以传入的参数包括:method, format, v, fields
 @param url         请求的地http地址
 @param onComplete  回调
 */
+ (void)doRequest:(NSDictionary *)postData
              url:(NSString *)url
       onComplete:(topRequestCallback)onComplete;
@end
