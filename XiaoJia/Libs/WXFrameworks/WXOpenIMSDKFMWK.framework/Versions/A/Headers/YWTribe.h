//
//  YWTribe.h
//
//
//  Created by Jai Chen on 15/1/13.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YWPerson;

/**
 *   加入群的校验模式
 */
typedef NS_ENUM(NSUInteger, YWTribeCheckMode) {
    /**
     *  不校验
     */
    YWTribeCheckModeNone = 0,
    /**
     *  以密码校验，输入正确密码则直接加入群
     */
    YWTribeCheckModePassword    = 1,
    /**
     *  身份校验，待群主或管理员审核通过才能加入群
     */
    YWTribeCheckModeIdentity    = 2,
    /**
     *  拒绝主动加入
     */
    YWTribeCheckModeDeny        = 3,
};

/**
 群类型
 */
typedef NS_ENUM(NSInteger, YWTribeType)
{
    YWTribeTypeNormal       = 0,   // 普通群（a.邀请人加入时需对方确认，b.支持加入群的校验模式）
    YWTribeTypeMultipleChat = 1,   // 多聊群
};

/**
 *  群对象
 */
@interface YWTribe : NSObject <NSCoding>

/**
 *  群的唯一标识符
 */
@property (readonly, copy, nonatomic) NSString *tribeId;

/**
 *  群名称
 */
@property (copy, nonatomic) NSString *tribeName;

/**
 *  群公告
 */
@property (copy, nonatomic) NSString *notice;

/**
 *  群类型
 */
@property (readonly, assign, nonatomic) YWTribeType tribeType;

/**
 *  加入群的校验模式
 */
@property (assign, nonatomic) YWTribeCheckMode checkMode;

/**
 *  是否允许群成员发送@all消息
 */
@property (assign, nonatomic) BOOL enableAtAll;

/**
 *  群主,这里使用本地数据，如果为空需要使用IYWTribeService中的requestTribeFromServer:completion:方法获取
 */
@property (readonly, strong, nonatomic) YWPerson *tribeMaster;

- (BOOL)isEqualToTribe:(YWTribe *)tribe;

@end
