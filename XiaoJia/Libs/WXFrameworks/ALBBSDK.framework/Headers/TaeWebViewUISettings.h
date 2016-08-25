//
//  TaeWebViewUISettings.h
//  taesdk
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 14-8-9.
//  Copyright (c) 2014年 com.taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaeWebViewUISettings : NSObject
/** 此字段无效. 顶层navigatorBar的标题内容. */
@property (nonatomic, strong) NSString *title;
/** 顶层 navigatorBar的标题字体 */
@property(nonatomic, strong) UIFont *titleFont;
/** 顶层 navigatorBar的标题字体颜色 */
@property(nonatomic, strong) UIColor *titleColor;
/** 顶层 navigatorBar的标题字体Label的背景颜色 */
@property(nonatomic, strong) UIColor *titleBackgroundColor;
/** 返回按钮 */
@property (nonatomic, strong) UIButton *backButton;
/** 关闭按钮 */
@property (nonatomic, strong) UIButton *closeButton;
/** 顶层navigatorBar的回退按钮, button的图片尺寸参见baichuan.bundle里的back.png, 传入自定义的backButton,SDK会加载这个自定义的button */
@property (nonatomic, strong) UIImage *backButtonBackgroundImage;
/** 消失回调 */
@property (nonatomic, copy) void (^webviewControllerDidDisappearCallback)();

/**
 以下属性已经废弃，不建议使用。以下属性在调用参数isNeedPush=NO时生效，如果isNeedPush=YES,将使用调用者传入UINavigationController设置的样式.
 */
/** 顶层 navigatorBar的背景颜色 */
@property(nonatomic, strong) UIColor *barTintColor;
/** 顶层 navigatorBar的左右bar的颜色，仅ios7 */
@property(nonatomic, strong) UIColor *tintColor;
/** 顶层 navigatorBar 是否透明 */
@property(nonatomic, assign) BOOL translucent;
@end

