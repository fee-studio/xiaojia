//
//  IYWExtensionServiceDef.h
//
//
//  Created by huanglei on 15/3/10.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  1、扩展名，例如ExtensionX
 *  1、Service：必须以I开头，Service结尾，中间为扩展名，例如：IExtensionXService
 *  2、Loader：必须以Loader结尾，前面为扩展名，例如：ExtensionXLoader
 */

/**
 *  每一个扩展必须遵循这个协议
 */

@protocol IYWExtension <NSObject>

/**
 *  该扩展是否被启用
 */
- (BOOL)enable;

@end

/**
 *  每一个扩展必须有一个加载器类，遵循这个协议
 */
@protocol IYWExtensionLoader <NSObject>

/**
 *  每一个加载器类必须实现这个方法，并返回扩展的具体对象。
 *  @param aContext 如果是全局扩展，被加载时此参数为nil；如果是Context内部扩展，被加载时此参数为WXOBaseContext对象
 */
+ (id<IYWExtension>)loadExtensionWithContext:(id)aContext;

@end



@interface IYWExtensionServiceDef : NSObject

@end