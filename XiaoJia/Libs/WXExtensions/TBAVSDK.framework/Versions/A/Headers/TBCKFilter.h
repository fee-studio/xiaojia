//
//  TBCKFilter.h
//  TBAVSDK
//
//  Created by 兵长 on 16/2/25.
//  Copyright © 2016年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, TBCKFilterType) {
    TBCKFilterTypeOriginal = 0,//原图
    TBCKFilterTypeRefined, //炫丽
    TBCKFilterTypeElegant, //雅致
    TBCKFilterTypeBeautiful, //优美
    TBCKFilterTypeSunrise, //日出
    TBCKFilterTypeLOMO, //LOMO
    TBCKFilterTypeMemory,//怀旧
    TBCKFilterTypePhotograph//胶片
};


/*
 滤镜对象
 */
@interface TBCKFilter : NSObject
//滤镜的名称，默认是初始化时的的CIFilter名
@property (nonatomic, strong) NSString *name;
//用于保存一些附加信息
@property (nonatomic, strong) NSDictionary *plusInfo;

+ (TBCKFilter *)emptyFilter;
//根据传入的TBCKFilterType，创建一个滤镜对象
+ (TBCKFilter *)filterWithFilterType:(TBCKFilterType)type;
//根据传入的TBCKFilterType，创建一个滤镜对象
+ (TBCKFilter *)filterWithFilterType:(TBCKFilterType)type plusInfo:(NSDictionary *)plusInfo;
@end
