//
//  TaeFileImageTransferOptions.h
//
//  Created by huamulou on 15-1-13.
//  Copyright (c) 2015年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TFEImageAdvanceCut;
@class TFEImageWatermark;
typedef NS_ENUM(NSInteger, TFEImageFormat) {
    TFEImageFormatJPG = 0,
    TFEImageFormatPNG,
    TFEImageFormatBMP,
    TFEImageFormatWEBP,
    TFEImageFormatJPEG
};
#ifndef TFEImageFormatArray
#define TFEImageFormatArray @"jpg", @"png", @"bmp", @"webp", @"jpeg", nil
#endif

@interface TFEImageTransferOptions : NSObject

/**
 * deprecated
 * 直接使用init方法
 */
- (instancetype)initWithNamespace:(NSString *)space dir:(NSString *)dir name:(NSString *)fileName __deprecated;
/**
 * deprecated
 * 直接使用init方法
 */
- (instancetype)initWithUrl:(NSString *)url __deprecated;

@property(nonatomic, readonly, strong) NSString *url;
/**
*  是否短边优先， 默认长边优先
*/
@property(nonatomic) BOOL shortEdge;


/**
*  宽度， height和width必须在4096内
*/
@property(nonatomic) int width;

/**
*  高度
*/
@property(nonatomic) int height;

/**
*  是否是绝对质量
*/
@property(nonatomic) BOOL absoluteQuality;
/**
*  质量
*/
@property(nonatomic) int quality;
/**
*  旋转
*/
@property(nonatomic) int rotate;

/**
*  尺寸调整倍数，默认值：1
*/
@property(nonatomic) int multiple;


/**
*  是否固定宽高, 默认否
*/
@property(nonatomic) BOOL immobilize;

/**
* 是否裁剪，默认值是：０（否）
* 对缩放后超出范围的图片内容进行剪裁，这
* 种情况一般发生在按照短边优先的等比缩放
* 中。
* 缩放会以图片中线为中心，进行上下/左右的
* 裁剪，得到相应的尺寸，如原图 200 * 400，
* 使用参数"100w_100h_1e_1c"，首先按照短边
* 优先缩放一张 100 * 200 的图片，之后按照中
* 线裁剪高度，得到一张 100 * 100 的图片。
*/
@property(nonatomic) BOOL cut;

/**
* 有些相机拍的照片会出现旋转，本参数就是
* 根据原图 EXIF 信息自动适应方向。
* NO 表示按原图默认处理
* YES 表示按原图 EXIF 信息自动旋转图片。
* 默认值 ：
* 按原图默认）
*/
@property(nonatomic) BOOL orient;

/**
*  高级裁剪选项
*/
@property(nonatomic, strong) TFEImageAdvanceCut *advanceCut;


/**
*  亮度, [-100, 100]
*/
@property(nonatomic) int brightness;
/**
*  对比度, [-100, 100]
*/
@property(nonatomic) int contrast;

/**
* 如果指定生成图像的大小比原图大,会让原 图变大,
* 用户可以指定参数为 YES,可以设置 如果生成的图片大于原图将返回原图。
*/
@property(nonatomic) BOOL limit;

@property(nonatomic) TFEImageFormat format;

@property(nonatomic, strong) TFEImageWatermark *watermark;


@end
