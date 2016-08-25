//
//  IYWTribeServiceDef.h
//  WXOpenIMSDK
//
//  Created by huanglei on 15/9/15.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YWTribe.h"

@interface IYWTribeServiceDef : NSObject

/**
 *  群聊管理接口较多且接口参数复杂，这里汇总定义了不同接口中的UserInfoKey定义
 *  具体含义请参看 各个接口 自身的定义
 */
FOUNDATION_EXTERN NSString *const YWTribeServiceKeyTribeId;

FOUNDATION_EXTERN NSString *const YWTribeServiceKeyTribeNotice;

FOUNDATION_EXTERN NSString *const YWTribeServiceKeyTribeName;

FOUNDATION_EXTERN NSString *const YWTribeServiceKeyTribeAtAll;

FOUNDATION_EXTERN NSString *const YWTribeServiceKeyTipInfo;

/// 对应的Value为YWPerson对象
FOUNDATION_EXTERN NSString *const YWTribeServiceKeyPerson;

/// 对应的Value为YWPerson对象
FOUNDATION_EXTERN NSString *const YWTribeServiceKeyPerson2;

/// 系统的消息的处理状态, Value 为 YWMessageBodyTribeSystemStatus 类型转化成的 NSNumber
FOUNDATION_EXTERN NSString *const YWTribeServiceKeyStatus;

FOUNDATION_EXTERN NSString *const YWTribeServiceKeyTribeType;

FOUNDATION_EXTERN NSString *const YWTribeServiceKeyTribeCheckMode;

FOUNDATION_EXTERN NSString *const YWTribeServiceKeyTribeMemberNickname;


@end


/**
 *  这个结构体用于创建群聊等接口
 */
@interface YWTribeDescriptionParam : NSObject

/// 详见类型注释
@property (nonatomic, assign) YWTribeType tribeType;

@property (nonatomic, copy) NSString *tribeName;

@property (nonatomic, copy) NSString *tribeNotice;

/// 必须是包含YWPerson对象的数组
@property (nonatomic, strong) NSArray *tribeMembers;

/**
 *  校验模式，在普通类型的群有效，详见该类型注释
 */
@property (nonatomic, assign) YWTribeCheckMode tribeCheckMode;

/**
 *  校验信息，目前仅当 checkMode 为 YWTribeCheckModePassword 时有效，checkInfo 会作为加入群的密码，密码只限使用英文和数字，长度不可超过 50
 */
@property (nonatomic, assign) NSString *tribeCheckInfo;

@end

#pragma  mark - Error

typedef NS_ENUM(NSInteger, YWTribeErrorCode) {
    YWTribeErrorCodeInvalidParams                   = -2,   // 无效的参数
    YWTribeErrorCodeTribeNotExists                  = 1,    // 该群不存在
    YWTribeErrorCodeUserNotExists                   = 2,    // 该用户不存在
    YWTribeErrorCodeNoPrivilege                     = 3,    // 没有权限
    YWTribeErrorCodeTooManyMembers                  = 4,    // 群成员数量已达到上限
    YWTribeErrorCodeTooManyTribes                   = 5,    // 加入群的数量已达到上限
    YWTribeErrorCodeMemberDumplicated               = 6,    // 群内已有该成员
    YWTribeErrorCodeMemberBlocked                   = 7,    // 该成员已加入黑名单
    YWTribeErrorCodeVerifyFailed                    = 8,    // 验证失败
    YWTribeErrorCodeMemberNotExists                 = 9,    // 该群成员不存在
    YWTribeErrorCodeNeedVerify                      = 11,   // 需要验证。该错误码并不代表异常，如加入群时返回该错误码，表示需要管理员审核才能加入群，但流程是成功的
    YWTribeErrorCodeTooManyManagers                 = 12,   // 群管理员数量已达到上限
    YWTribeErrorCodeInvalidTribeID                  = 13,   // 无效的群 ID
    YWTribeErrorCodeTribeDumplicated                = 14,   // 该群已存在
    YWTribeErrorCodeExceedsFrequency                = 17,   // 请求频率超出限制
    YWTribeErrorCodeUnknownError                    = 255   // 未知错误
};

