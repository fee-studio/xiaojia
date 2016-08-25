//
//  YWMessageBodyTemplate.h
//
//
//  Created by 慕桥(黄玉坤) on 1/22/15.
//  Copyright (c) 2015 taobao. All rights reserved.
//

#import "YWMessageBody.h"

typedef enum : NSUInteger {
    //新模板
    YWTemplateTypeURL          = 20001,     //交易类通知
    YWTemplateTypeHTML         = 20002,     //交易类通知
    YWTemplateTypeTEXT         = 20003,     //交易类通知
    YWTemplateTypeTrade        = 20004,     //交易类通知
    YWTemplateTypeFlow         = 20005,     //旺起通用模板
    YWTemplateTypeAudio        = 20006,     //语音
    YWTemplateTypeMusic        = 20007,     //音乐
    YWTemplateTypeVideo        = 20008,     //视频
    YWTemplateTypeLocation     = 20009,     //地理位置
    YWTemplateTypeImageTextH   = 20010,     //横排单图文
    YWTemplateTypeImageTextV   = 20011,     //竖排单图文
    YWTemplateTypeImageTextMulti  = 20012,  //竖排多图文
    YWTemplateTypeMultiText    = 20013,     //竖排多文本
    YWTemplateTypeFlexGrid    = 20014,     //栅格
} YWTemplateType;

// 统一模版消息字段定义 TMK 为 Template Message Key 缩写
#define TMKTemplate             @"template"
#define TMKTemplateData         @"data"
#define TMKTemplateId           @"id"
#define TMKTemplateUserData     @"userData"

// 统一模版消息渲染描述字段
#define TMKTemplateRELayout         @"layout"
#define TMKTemplateRELayoutSide     @"side"
#define TMKTemplateRELayoutCenter   @"center"

#define TMKTemplateREFrom       @"from"

@interface YWMessageBodyTemplate : YWMessageBody

// 标题
@property (nonatomic, strong, readonly) NSString *title;

// 摘要
@property (nonatomic, strong, readonly) NSString *summary;

// 降级文案
@property (nonatomic, strong, readonly) NSString *degradeText;

// 提醒升级
@property (nonatomic, assign, readonly) BOOL needUpgrade;

// 模板ID
@property (nonatomic, assign, readonly) YWTemplateType templateId;

// 模板数据
@property (nonatomic, strong, readonly) NSDictionary *templateData;

// 业务自定义数据
@property (nonatomic, strong, readonly) NSDictionary *userData;

@end
