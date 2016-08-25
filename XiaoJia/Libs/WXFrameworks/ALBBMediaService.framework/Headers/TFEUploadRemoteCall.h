//
//  TFEUploadServerNotify.h
//
//  Created by huamulou on 15-1-20.
//  Copyright (c) 2015年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFEUploadRemoteCall : NSObject

@property(nonatomic)NSArray *urls;
@property(nonatomic)NSString *host;
@property(nonatomic)NSString *body;
@property(nonatomic)NSString *bodyType;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)remoteCallByUrls:(NSArray *)urls host:(NSString *)host body:(NSString *)body bodyType:(NSString *)bodyType;


@end
