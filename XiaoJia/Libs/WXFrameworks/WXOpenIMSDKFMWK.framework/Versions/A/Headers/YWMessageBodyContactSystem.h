//
//  YWMessageBodyContactSystem.h
//  WXOpenIMSDK
//
//  Created by 慕桥(黄玉坤) on 15/11/17.
//  Copyright © 2015年 taobao. All rights reserved.
//

#import "YWMessageBody.h"

@class YWPerson;

typedef NS_ENUM(NSUInteger, YWAddContactRequestStatus) {
    YWAddContactRequestStatusNull,           // 添加好友消息没有处理过
    YWAddContactRequestStatusIgnored,        // 进行忽略操作
    YWAddContactRequestStatusAccepted,       // 同意被添加为好友
    YWAddContactRequestStatusRefused,        // 我拒绝添加好友
    YWAddContactRequestStatusBeenAccepted,   // 对方已添加我为好友，我未必已添加对方好友，云旺用户不需要关心这个
};

@interface YWMessageBodyContactSystem : YWMessageBody
@property (nonatomic, strong, readonly) NSString *content;
@property (nonatomic, strong, readonly) YWPerson *contact;
@property (nonatomic, assign, readwrite) YWAddContactRequestStatus requestStatus;

@end
