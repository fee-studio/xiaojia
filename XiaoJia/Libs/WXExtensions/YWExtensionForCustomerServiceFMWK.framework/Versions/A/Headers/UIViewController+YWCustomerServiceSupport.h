//
//  UIViewController+YWCustomerServiceSupport.h
//  YWExtensionForCustomerService
//
//  Created by sidian on 15/9/30.
//  Copyright © 2015年 SiDian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class YWIMKit;

@interface UIViewController()

/// ViewController的显示名，需要在初始化时设置，若不设置，则这个页面不会计入轨迹
@property (nonatomic, copy) NSString *ywcsTrackTitle;
/// 开发者自定义的url，可以显示在客服界面，如果需要尽早设置，最好在初始化时设置
@property (nonatomic, copy) NSString *ywcsUrl;

@end

