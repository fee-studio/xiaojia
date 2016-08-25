//
//  YWIMKit.h
//  WXOpenIMUIKit
//
//  Created by huanglei on 15/4/10.
//  Copyright (c) 2015年 www.alibaba.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IYWUIService.h"

#import <WXOpenIMSDKFMWK/YWServiceDef.h>

@class YWIMCore;

@interface YWIMKit : NSObject
<IYWUIService, YWIMKitLifeProtocol>

/*
 *  访问YWIMKit持有的YWIMCore实例
 */
@property (nonatomic, strong, readonly) YWIMCore *IMCore;

@property (nonatomic, readonly) NSString *YWIMKitCompileDate;

@end
