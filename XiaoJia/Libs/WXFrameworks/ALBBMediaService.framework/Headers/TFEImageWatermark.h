//
//  TFEImageWatermark.h
//
//  Created by huamulou on 15-1-13.
//  Copyright (c) 2015年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TFEImageWatermarkFont){
    TFEImageWatermarkFontWqyZenhei = 0,
    TFEImageWatermarkFontWqyMicrohei,
    TFEImageWatermarkFontFangzhengshusong,
    TFEImageWatermarkFontFangzhengkaiti,
    TFEImageWatermarkFontFangzhengheiti,
    TFEImageWatermarkFontFangzhengfangsong,
    TFEImageWatermarkFontDroidsansfallback
};

#ifndef TFEImageWatermarkFontArray
#define TFEImageWatermarkFontArray @"wqy-zenhei", @"wqy-microhei", @"fangzhengshusong", @"fangzhengkaiti", @"fangzhengheiti", @"fangzhengfangsong", @"droidsansfallback", nil
#endif
@interface TFEImageWatermark : NSObject
/**
 *  水印图片的uri
 */
@property(nonatomic, strong, readonly)NSString *uri;
/**
 *  文字
 */
@property(nonatomic, strong, readonly)NSString *text;
/**
 *  文字大小
 */
@property(nonatomic, readonly)int fontSize;
/**
 *  模式
 */
@property(nonatomic, readonly)int mode;
/**
 *  字体
 */
@property(nonatomic, readonly)TFEImageWatermarkFont fontType;
/**
 *  web格式的颜色，'#'加上6个16位数字组成
 */
@property(nonatomic, strong, readonly)NSString *fontColor;
/**
 *  透明度， 0-100
 */
@property(nonatomic)int transparency;

/**
 *  水印位置。取值范围1-9
 *  1 左上  2 中上  3 右上
 *  4 左中  5 中部  6 右中
 *  7 左下  8 中下  9 右下
 */
@property(nonatomic)int position;

/**
 *  水平边距 1-4096
 */
@property(nonatomic)int x;

/**
 *  垂直边距 1-4096
 */
@property(nonatomic)int y;





/**
 *  生成文字类型的水印
 *
 *  @param text      水印文字
 *  @param fontSize  水印文字字体大小
 *  @param fontType  水印文字字体
 *  @param fontColor 水印文字颜色
 *
 *  @return instancetype
 */
-(instancetype)initWithText:(NSString *)text fontSize:(int)fontSize fontType:(TFEImageWatermarkFont)fontType fontColor:(NSString *)fontColor;


/**
 *  生成图片类型水印
 *
 *  @param uri 水印uri
 *
 *  @return instancetype
 */
-(instancetype)initWithUri:(NSString *)uri;

@end
