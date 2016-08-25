//
//  WXOPhotoBrowserViewController.h
//  TAEDemo
//
//  Created by Jai Chen on 14/12/26.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IYWUIServiceDef.h"

@class YWIMKit;
@protocol IYWMessage;

/**
 *  这个类只支持单个图片的简单展示
 *  推荐使用 YWImageBrowserHelper 类预览大图，支持图片联播和缩放。
 */

@interface YWPhotoBrowserViewController : UIViewController
<YWViewControllerEventProtocol>

/**
 *  构建一个图片消息预览controller
 *  @param aMessage 需要预览的图片消息
 *  @return 如果消息体并非图片消息体，则返回nil
 */
+ (instancetype)makeControllerWithMessage:(id<IYWMessage>)aMessage __attribute__ ((deprecated));
+ (instancetype)makeControllerWithMessage:(id<IYWMessage>)aMessage andImkit:(YWIMKit *)aImkit;


#pragma mark - 更多按钮的选项

/*
 *  如果需要修改更多按钮选项，请在makeController后，第一时间处理；
 *  在按钮已经弹出后，再操作可能导致crash
 */

/// 移除所有的更多按钮
- (void)removeAllMoreItems;

/// 添加一个更多按钮
- (void)addMoreItemWithName:(NSString *)aName actionBlock:(void(^)(void))aActionBlock;



#pragma mark - 获取数据

/**
 *  异步保存大图到相册
 */
- (void)asyncSaveBigImageWithDownloadProgressBlock:(void(^)(CGFloat aProgress))aProgressBlock completionBlock:(void(^)(NSError *aError))aCompletionBlock;

@property (nonatomic, strong, readonly) id<IYWMessage> message;

@end
