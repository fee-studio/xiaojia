//
//  TFELoadSession.h
//
//  Created by huamulou on 15-1-18.
//  Copyright (c) 2015年 alibaba. All rights reserved.
//



#import "ALBBMediaServiceProtocol.h"

@interface TFELoadSession : NSObject

extern NSString * const kTFECustomMetaPrefix;

@property(nonatomic, strong, readonly)NSString *url;
/**
 *  <#Description#>
 */
@property(nonatomic, strong, readonly)id userInfo;

@property(nonatomic, strong, readonly)NSData * responseData;
@property(nonatomic, strong, readonly)NSHTTPURLResponse * response;
@property(nonatomic, strong, readonly)NSDictionary * customMetas;
@property(nonatomic, strong, readonly)NSString * contentType;
@property(nonatomic, readonly)int httpStatus;
@property(nonatomic, readonly)TFETaskStatus status;

-(NSString *)responseString;
//不要使用init
- (instancetype)init NS_UNAVAILABLE;
-(NSString *)responseStringWithencoding:(NSStringEncoding)encoding;
@end
