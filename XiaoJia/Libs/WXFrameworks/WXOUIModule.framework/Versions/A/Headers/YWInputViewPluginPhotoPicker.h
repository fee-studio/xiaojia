//
//  WXOInputViewPluginPhotoPicker.h
//  WXOpenIMUIKit
//
//  Created by Zhiqiang Bao on 15-2-3.
//  Copyright (c) 2015年 www.alibaba.com. All rights reserved.
//

#import "YWInputViewPlugin.h"

extern NSString *kPluginIndentityPhotoPicker;

/**
 *  选中图片的回调
 *  @param plugin 正在操作的插件
 *  @param image 选中的图片
 */
typedef void(^YWInputViewPluginImageBlock)(id<YWInputViewPluginProtocol> plugin, UIImage *image);
/**
 *  多选图片的回调
 *  @param plugin 正在操作的插件
 *  @param images 选中的UIImage数组
 *  @param sendOriginImage 用户是否选择了发送不压缩的原图
 */
typedef void(^YWInputViewPluginMultiImageSelectBlock)(id<YWInputViewPluginProtocol> plugin, NSArray *imageDatas, BOOL sendOriginImage);


@interface YWInputViewPluginPhotoPicker : YWInputViewPlugin

/**
 *  初始化照片选择插件，本接口将直接使用系统的 UIImagePickerController
 *  @param blk 选中某个照片的回调
 */
- (instancetype)initWithPickerOverBlock:(YWInputViewPluginImageBlock)blk;
/**
 *  初始化照片选择插件, 支持多选， 相册并不使用UIImagePickerController，但拍照仍然使用。
 *  @param blk 多选照片的回调
 */
- (instancetype)initWithMultiPickeroverBlock:(YWInputViewPluginMultiImageSelectBlock)blk;

@end
