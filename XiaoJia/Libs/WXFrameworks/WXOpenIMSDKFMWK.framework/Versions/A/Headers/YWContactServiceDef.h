//
//  YWContactServiceDef.h
//  WXOpenIMSDK
//
//  Created by huanglei on 15/7/20.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class YWPerson, YWTribe, YWGroup;

FOUNDATION_EXTERN NSString * const kYWProfileCacheChange;
FOUNDATION_EXTERN NSString * const kYWProfileCacheChangePerson;
FOUNDATION_EXTERN NSString * const kYWProfileCacheChangeTribe;

typedef enum {
    YWAddContactRequestResultSuccess,       //请求成功，对方不需要校验，直接添加成功
    YWAddContactRequestResultWaitAccept,    //请求成功，等待对方需要通过
    YWAddContactRequestResultError          //请求失败
} YWAddContactRequestResult;

#pragma mark - Profile相关定义

@interface YWProfileItem : NSObject <NSCopying>

@property (nonatomic, strong)           YWPerson    *person;         //profile对应的YWPerson对象，如果是群的profile，置为nil
@property (nonatomic, strong)           YWTribe     *tribe;          //profile对应的YWTribe对象，或者profile所属的person对应的tribe（群成员），如果是单纯person的profile，置为nil
@property (nonatomic, copy)             NSString    *displayName;    //最终显示名
@property (nonatomic, strong)           UIImage     *avatar;         //头像的UIImage对象
@property (nonatomic, copy)             NSString    *avatarUrl;      //头像url，只有当avatar为nil时才被使用。

@property (nonatomic, strong, readonly) NSDate      *updateDate;     //更新时间
@property (nonatomic, strong, readonly) NSDate      *updateDateFromServer;//上次从server端同步数据的时间

#pragma mark - Contact
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;

#pragma mark - Extra
@property (nonatomic, strong) NSDictionary *extra;                   // 扩展字段，目前由于存储反馈联系方式
@end

/**
 *  获取到部分profile，比如先获取到了昵称，或者先获取到了头像。可以先调用这个block，告知IMSDK。
 *
 *  @param item YWProfileItem对象
 */
typedef void (^YWProfileProgressBlock) (YWProfileItem *item);
/**
 *  完成获取Profile后，通过这个回调，通知IMSDK
 *
 *  @param aIsSuccess 是否获取成功，只有返回成功才会缓存
 *  @param item       YWProfileItem对象
 */
typedef void (^YWProfileCompletionBlock) (BOOL aIsSuccess, YWProfileItem *item);

//批量接口
typedef void (^YWProfilesCompletionBlock) (BOOL aIsSuccess, NSArray *profileItems);

/**
 *  搜索完成的block
 *
 *  @param profileArray 搜索结果，元素为搜索对应的类型，搜索单聊对象则为YWPerson，搜索群为YWtribe，搜索群成员为YWTribemember
 *  @param error 如果搜索成功，则为nil
 */
typedef void (^YWProfileSearchCompletionBlock) (NSError *error, NSArray *profileArray);

/// 分组操作，增删改，成功则error为nil
typedef void (^YWGroupOperationResultBlock) (NSError *error, YWGroup *group);
/// 批量接口
typedef void (^YWGroupsOperationResultBlock) (NSError *error, NSArray *groupArray);

/// 添加好友请求回调
typedef void (^YWAddContactRequestResultBlock) (NSError *error, YWAddContactRequestResult result);
/// 好友操作回调
typedef void (^YWContactOperationResultBlock) (NSError *error, YWPerson *person);
/// 批量接口
typedef void (^YWContactsOperationResultBlock) (NSError *error, NSArray *personArray);


#pragma mark - 联系人列表相关定义

/**
 *  联系人列表划分方式
 */
typedef enum {
    /// 按字母划分
    YWContactListModeAlphabetic,
    /// 按分组划分
    YWContactListModeGroup,
} YWContactListMode;

/// 以下接口淘宝域账户使用，云旺开发者不需要关注
/// @brief 添加好友回调操作，当error == nil或者error.errorCode为0时表示成功。
typedef void (^YWAddContactResultBlock) (NSError *error, YWPerson *person);
/// @brief 删除好友回调操作，当error == nil或者error.errorCode为0时表示成功。
typedef void (^YWRemoveContactResultBlock) (NSError *error, NSArray *personArray);

typedef enum {
    YWAddContactErrorOK               = 0x0,  // 操作成功
    YWAddContactErrorAdded            = 0x1,  // 已经添加对方为好友
    YWAddContactErrorNoId             = 0x2,  // 该联系人不存在
    YWAddContactErrorFull             = 0x3,  // 添加好友人数已达上限
    YWAddContactErrorFullToday        = 0x4,  // 今日添加好友人数已达上限
    YWAddContactErrorNeedAuth         = 0x5,  // 对方要求验证
    YWAddContactErrorNoRight          = 0x6,  // 没有权限操作
    YWAddContactErrorNoActiveId       = 0x7,  // 对方尚未激活
    YWAddContactErrorWaitAuth         = 0x8,  // 等待对方通过验证
    YWAddContactErrorDenyAll          = 0x9,  // 对方拒绝任何人添加为好友
    YWAddContactErrorHighFrenq        = 0xa,  // 添加好友频率过高
    YWAddContactErrorEServiceTeamMate = 0xc,  // 同为E客服子账号
    YWAddContactErrorWrongAnswer      = 0x20, // 问题回答错误
    YWAddContactErrorFiltMessage      = 0x21, // 验证信息被过滤
    YWAddContactErrorNeedAnswer       = 0x22, // 对方要求回答验证问题 问题见error.userInfo
    YWAddContactErrorNeedCheckcode    = 0x23, // 服务器要求验证码 sessionId见error.userInfo
    YWAddContactErrorInBlacklist      = 0xfd, // 在黑名单中，不能直接添加好友
    YWAddContactErrorOtherError       = 0xff, // 其他未知错误
}YWAddContactErrorCode;

typedef enum {
    YWContactAddResponseErrorUnknown       = -2,        // 未知错误
    YWContactACKResponseErrorException     = -1,        // 确认添加好友操作异常
    YWContactACKResponseErrorSuccess       = 0,         // 确认添加好友操作成功
    YWContactACKResponseErrorAdded         = 1,         // 该好友添加请求已经在其他平台上添加过了
    YWContactACKResponseErrorRefused       = 255,       // 该好友添加请求已经在其他平台上拒绝过了
}YWContactAddResponseErrorCode;

typedef enum {
    YWContactAddResponseAccept          = 1,	// 对方接受验证请求好友
    YWContactAddResponseAcceptSynch,            // 同步其他平台已接受
    
    YWContactAddResponseAddOK,                  // 对方已加你为好友(请求由你发出)
    YWContactAddResponseAddOKSynch,             // 同步其他平台已添加
    
    YWContactAddResponseAddByServer,            // 服务端添加为好友
    
    YWContactAddResponseRefuse,                 // 对方拒绝验证请求好友
    YWContactAddResponseRefuseSynch,            // 同步其他平台已拒绝
} YWContactAddResponseType;

typedef enum {
    YWContactAddRequestVerify          = 1,     // 对方请求验证加好友
} YWContactAddRequestType;

typedef enum {
    YWContactListTypeOnlyDomain                 = 0,    // 本域的好友列表，不包含自身子账号
    YWContactListTypeAllDomain                  = 1,    // 全域的好友列表，不包含自身子账号
    YWContactListTypeOnlyDomainAndSubAccount    = 2,    // 本域的好友列表，包含自身子账号
    YWContactListTypeAllDomainAndSubAccount     = 3,    // 全域的好友列表，包含自身子账号
}YWContactListType;

/**
 *  获取到部分profile，比如先获取到了昵称，或者先获取到了头像。可以先调用这个block，告知IMSDK。
 *  deprecated
 *  @param aPerson Person对象
 *  @param aDisplayName 显示名称
 *  @param aAvatarImage 头像
 */
typedef void(^YWFetchProfileProgressBlock)(YWPerson *aPerson, NSString *aDisplayName, UIImage *aAvatarImage);

/**
 *  完成获取Profile后，通过这个回调，通知IMSDK
 *  deprecated
 *  @param aIsSuccess 是否成功
 *  @param aPerson Person对象
 *  @param aDisplayName 显示名称
 *  @param aAvatarImage 头像
 */
typedef void(^YWFetchProfileCompletionBlock)(BOOL aIsSuccess, YWPerson *aPerson, NSString *aDisplayName, UIImage *aAvatarImage);


/**
 *  以下字段用于获取profile字典中的具体信息
 */
FOUNDATION_EXTERN NSString *const kYWProfilePerson;
FOUNDATION_EXTERN NSString *const kYWProfileUserId;
FOUNDATION_EXTERN NSString *const kYWProfileNickname;
FOUNDATION_EXTERN NSString *const kYWProfileIconurl;
FOUNDATION_EXTERN NSString *const kYWProfileAddress;
FOUNDATION_EXTERN NSString *const kYWProfileEmail;
FOUNDATION_EXTERN NSString *const kYWProfilePhone;
FOUNDATION_EXTERN NSString *const kYWProfileExtra;
FOUNDATION_EXTERN NSString *const kYWProfileTaobaoId;
FOUNDATION_EXTERN NSString *const kYWProfileDeviceType;
FOUNDATION_EXTERN NSString *const kYWProfileStatus;
FOUNDATION_EXTERN NSString *const kYWProfileName;
FOUNDATION_EXTERN NSString *const kYWProfileNick;
FOUNDATION_EXTERN NSString *const kYWProfileGender;
FOUNDATION_EXTERN NSString *const kYWProfileAge;
FOUNDATION_EXTERN NSString *const kYWProfileCareer;
FOUNDATION_EXTERN NSString *const kYWProfileQQ;
FOUNDATION_EXTERN NSString *const kYWProfileWeChat;
FOUNDATION_EXTERN NSString *const kYWProfileWeibo;
FOUNDATION_EXTERN NSString *const kYWProfileRemark;
FOUNDATION_EXTERN NSString *const kYWProfileVip;

