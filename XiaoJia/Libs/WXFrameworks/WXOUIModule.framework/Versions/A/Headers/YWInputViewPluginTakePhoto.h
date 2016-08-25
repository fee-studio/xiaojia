//
//  WXOInputViewPluginTakePhoto.h
//  WXOpenIMUIKit
//
//  Created by Zhiqiang Bao on 15-2-3.
//  Copyright (c) 2015年 www.alibaba.com. All rights reserved.
//

#import "YWInputViewPlugin.h"

extern NSString *kPluginIndentityTakePhoto;

/**
 *  选中图片的回调
 *  @param plugin 正在操作的插件
 *  @param image 选中的图片
 */
typedef void(^YWInputViewPluginImageBlock)(id<YWInputViewPluginProtocol> plugin, UIImage *image);


@interface YWInputViewPluginTakePhoto : YWInputViewPlugin

/**
 *  初始化拍照插件
 *  @param blk 拍照完成的回调
 */
- (instancetype)initWithPickerOverBlock:(YWInputViewPluginImageBlock)blk;

@end
