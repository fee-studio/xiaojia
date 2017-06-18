//
//  YIConfigUtil+UI.h
//  Dobby
//
//  Created by efeng on 15/6/23.
//  Copyright (c) 2015年 weiboyi. All rights reserved.
//
//  整个应用界面上皮肤显示效果的常量定义

#import "YIConfigUtil.h"

// 1,应用中固定的名字


// 2,应用中UI的配色
#define kAppColorMain         ([UIColor colorWithHexString:@"38c4c5"])

#define kAppColorWhite        ([UIColor colorWithHexString:@"ffffff"])
#define kAppColorGray         ([UIColor colorWithHexString:@"999999"])
#define kAppColorLightGray    ([UIColor colorWithHexString:@"eeeeee"])
#define kAppColorBlack        ([UIColor darkGrayColor])

#define kAppColorRed			([UIColor watermelonColor])
#define kAppColorOrange			([UIColor cantaloupeColor])
#define kAppColorYellow			([UIColor buttermilkColor])
#define kAppColorGreen			([UIColor pastelGreenColor])
#define kAppColorCyan			([UIColor turquoiseColor])
#define kAppColorBlue			([UIColor skyBlueColor])
#define kAppColorPurple			([UIColor coolPurpleColor])

#define kAppColorBg				([UIColor  groupTableViewBackgroundColor])

#define kAppColorTextDeep		([UIColor darkGrayColor])
#define kAppColorTextMid		([UIColor  colorWithHexString:@"999999"])
#define kAppColorTextLight		([UIColor  colorWithHexString:@"cccccc"])

// 3,应用中常用的字体大小
#define kAppHugeFont        ([UIFont systemFontOfSize:20])
#define kAppBigFont         ([UIFont systemFontOfSize:17])
#define kAppMidFont         ([UIFont systemFontOfSize:15])
#define kAppSmlFont         ([UIFont systemFontOfSize:13])
#define kAppMiniFont        ([UIFont systemFontOfSize:11])

// 4,应用中常用的坐标
#define kFreshOrderCellHeight 370.f
#define kAllOrderCellHeight 163.f

// 5,应用中的一些提示语
#define kMessageServerDown     @"服务器正在维护中！请稍候再试 ..."
#define kMessageServerOK       @"连接服务器成功~"
#define kMessageNetworkAnomaly @"请检查您的网络连接是否正常。"
#define kMessageNetworkOther   @"网络其他问题 ..."
//#define kMessageNoOrders       @"暂没有任务，请休息一会吧~"
#define kMessageNoCacheData    @"无缓存数据"

// 操作浮动栏坐标
#define kFloatViewHeight 55.f
#define kFvBtnHeight 40.f
#define kFvBtnWidth 130.f
#define kFvSmlBtnWidth 100.f
#define kFvBtnSpace 10.f
#define kFloatViewHeight4Manual 100.f


#define kAppPlaceHolderImage ([UIImage imageNamed:@"placeholder"])


@interface YIConfigUtil (UI)

+ (NSString *)priceStringWithSign:(NSString *)priceValue;

@end
