//
//  YWMessageBodyLocation.h
//  
//
//  Created by Jai Chen on 15/1/8.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import "YWMessageBody.h"
#import <MapKit/MapKit.h>

/**
 * 文本消息体
 */
@interface YWMessageBodyLocation : YWMessageBody

/**
 *  地理位置
 */
@property (readonly, assign, nonatomic) CLLocationCoordinate2D location;
/**
 *  位置名称
 */
@property (readonly, copy, nonatomic) NSString *locationName;

/// 初始化
- (instancetype)initWithMessageLocation:(CLLocationCoordinate2D)location locationName:(NSString *)locationName;
@end
