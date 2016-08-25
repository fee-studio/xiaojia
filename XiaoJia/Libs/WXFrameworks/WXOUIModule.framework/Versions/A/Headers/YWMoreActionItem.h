//
//  YWMoreActionItem.h
//  WXOpenIMUIKit
//
//  Created by huanglei on 15/9/7.
//  Copyright (c) 2015年 www.alibaba.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Item被点击后的回调，UserInfo中的Key由各个业务场景自己定义
 */
typedef void(^YWMoreActionBlock)(NSDictionary *aUserInfo);

@interface YWMoreActionItem : NSObject

/**
 *  初始化
 */
- (instancetype)initWithActionName:(NSString *)aName actionBlock:(YWMoreActionBlock)aBlock;

/**
 *  Item的显示名称
 */
@property (nonatomic, copy, readonly) NSString *actionName;

/**
 *  Item被点击后的回调
 */
@property (nonatomic, copy, readonly) YWMoreActionBlock actionBlock;

/**
 *  是否合法：actionName和actionBlock非空
 */
- (BOOL)isValid;

@end




/**
 *  在会话列表左滑时需要显示成带颜色的菜单块，其他场景无需设置
 */

@interface YWMoreActionItem()

/**
 *  背景色，默认红色
 */
@property (nonatomic, copy) UIColor *backgroundColor;

@end
