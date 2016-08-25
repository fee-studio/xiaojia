//
//  IYWSettingServiceDef.h
//  WXOpenIMSDK
//
//  Created by sidian on 15/11/10.
//  Copyright © 2015年 taobao. All rights reserved.
//

#ifndef IYWSettingServiceDef_h
#define IYWSettingServiceDef_h

#import "YWPerson.h"
#import "YWTribe.h"

/// 用于设置一段时间免打扰
@interface YWNoPushTimeSettingItem : NSObject

@property (nonatomic, assign, readonly) BOOL enableNoPush; // 是否启用，在启用时下面两个参数才起作用
@property (nonatomic, copy, readonly) NSString *start;     // 起始时间，长度为4，形如@"2000"
@property (nonatomic, copy, readonly) NSString *end;       // 结束时间，长度为4，形如@"0800",与start组成[start, end)左闭右开区间，当start > end时跨越0点，start == end时无效

- (id)initWithEnableNoPush:(BOOL)aEnableNoPush start:(NSString *)aStart andEnd:(NSString *)aEnd;
@end

typedef NS_ENUM(NSInteger, YWMessageFlag) {
    YWMessageFlagNotReceive,            // 屏蔽消息
    YWMessageFlagReceiveButNoAlert,     // 前台在线时接收消息，后台不push
    YWMessageFlagReceive,               // 正常接收消息，后台有push
};

typedef NS_ENUM(NSInteger, YWAtMessageFlag) {
    YWAtMessageFlagNotReceive,            // 屏蔽消息
    YWAtMessageFlagReceive,               // 正常接收消息，后台有push
};

const static NSString *YWP2PMessageSetting = @"YWP2PMessageSetting";

@interface YWP2PMessageSettingItem : NSObject

@property (nonatomic, strong) YWPerson *person;
@property (nonatomic, assign) NSNumber *messagePushEnable; //后台时是否push person的消息

@end

const static NSString *YWTribeMessageSetting = @"YWTribeMessageSetting";

@interface YWTribeMessageSettingItem : NSObject

@property (nonatomic, strong) YWTribe       *tribe;
@property (nonatomic, assign) NSNumber      *messageFlag; //普通消息接收设置，取值范围参考 YWMessageFlag 枚举
@property (nonatomic, assign) NSNumber      *atMessageEnableReceive; //是否接收at消息,接收时取1，不接收时取0
@property (nonatomic, assign) NSTimeInterval modifiedTime;

@end

#endif /* IYWSettingServiceDef_h */
