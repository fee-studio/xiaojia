//
//  IYWHybridService.h
//  WXOpenIMSDK
//
//  Created by shili on 15/5/6.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIWebView;

FOUNDATION_EXTERN NSString *const YWHybridErrorDomain;

@protocol IYWHybridService <NSObject>

/**
 *  带有hybrid能力的浏览器（js与native代码相互调用）
 *
 *  @return UIWebVeiw的子类实例，带有hybrid能力
 */
- (UIWebView *)webViewWithHybridCapability;

@end
