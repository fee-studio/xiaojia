//
//  IYWGlobalExtensionService.h
//  
//
//  Created by huanglei on 15/3/10.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IYWExtension;

#define YWExtensionServiceFromProtocol(service) \
(id<service>)[[[YWAPI sharedInstance] getGlobalExtensionService] getExtensionByServiceName:NSStringFromProtocol(@protocol(service))]

#define YWIMCoreExtensionServiceFromProtocol(service, imCore) \
(id<service>)[[imCore getExtensionService] getExtensionByServiceName:NSStringFromProtocol(@protocol(service))]

@protocol IYWExtensionService <NSObject>

/**
 *  获取某一个全局扩展
 */
- (id<IYWExtension>)getExtensionByServiceName:(NSString *)aServiceName;

@end
