//
//  YWIndicator.h
//  WXOpenIMUIKit
//
//  Created by sidian on 15/8/21.
//  Copyright (c) 2015年 www.alibaba.com. All rights reserved.
//

#import <Foundation/Foundation.h>

// 用户点击toast时的回调
typedef void (^toastClickBlock) (NSString *title, NSString *content, NSDictionary *userInfo);

// 注意：该类方法均涉及UI操作，请在主线程调用
@interface YWIndicator : NSObject

/**
 * 显示或者隐藏loading菊花图
 * @param isShow, 显示还是隐藏
 * @param timeToDisplay, 最长显示时间
 * @param identifier, loading对应的id，同一次显示和隐藏需要相同
 */
+ (void)setLoadingViewShow:(BOOL)isShow withTimeToDisplay:(NSTimeInterval)timeToDisplay andIdentifier:(NSString *)identifier;

/**
 * 隐藏所有identifier对应的loading菊花图
 */
- (void)hideLoadingViews;

/**
 * 顶部穿透显示
 * @param title, 标题
 * @param content, 内容
 * @param userInfo, 开发者传入的自定义内容，用户点击时通过回调传给开发者
 * @param timeToDisplay, 显示时间
 * @param clickBlock, 用户点击的回调
 */
+ (void)showTopToastTitle:(NSString *)title content:(NSString *)content userInfo:(NSDictionary *)userInfo withTimeToDisplay:(NSTimeInterval)timeToDisplay andClickBlock:(toastClickBlock)clickBlock;

@end
