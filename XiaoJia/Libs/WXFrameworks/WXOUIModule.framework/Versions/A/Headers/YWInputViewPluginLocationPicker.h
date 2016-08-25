//
//  WXOInputViewPluginLocationPicker.h
//  WXOpenIMUIKit
//
//  Created by Zhiqiang Bao on 15-2-3.
//  Copyright (c) 2015年 www.alibaba.com. All rights reserved.
//

#import "YWInputViewPlugin.h"
#import <MapKit/MapKit.h>

/**
 *  选中地理位置的回调
 *  @param plugin 正在操作的插件
 *  @param location 地理位置
 *  @param name 位置名称
 */
typedef void(^YWInputViewPluginLocationBlock)(id<YWInputViewPluginProtocol> plugin,
                                               CLLocationCoordinate2D location,
                                               NSString *name);

extern NSString *kPluginIndentityLocationPicker;

@interface YWInputViewPluginLocationPicker : YWInputViewPlugin

/**
 *  初始化地理位置插件
 *  @param blk 选中某个位置的回调
 */
- (instancetype)initWithPickerOverBlock:(YWInputViewPluginLocationBlock)blk;

@end
