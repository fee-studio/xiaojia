//
//  TFELoadOptions.h
//
//  Created by huamulou on 15-1-18.
//  Copyright (c) 2015年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFELoadOptions : NSObject



@property(nonatomic)NSURLRequestCachePolicy cachePolicy;

@property(nonatomic)NSTimeInterval connectionTimeout;

@property(nonatomic)int timeout;


@property(nonatomic, strong)NSString *httpMethod;

@property(nonatomic, strong)NSDictionary *requestHeaders;

@property(nonatomic, strong)NSData *requestData;

@property(nonatomic, strong)id userInfo;
//不要使用init
- (instancetype)init NS_UNAVAILABLE;


-(instancetype)initWithCachePolicy:(NSURLRequestCachePolicy) policy;

-(instancetype)initWithCachePolicy:(NSURLRequestCachePolicy) policy connectionTimeout:(int)connectionTimeout timeout:(int)timeout;
@end
