//
//  IYWContactService.h
//  WXOpenIMSDK
//
//  Created by huanglei on 15/7/20.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YWServiceDef.h"
#import "YWContactServiceDef.h"

@class YWPerson, YWGroup;
@class YWConversation;
@class YWProfileManager;

/**
 *  联系人是指建立关系的人
 *  联系人服务提供了联系人列表、联系人管理等功能
*/
@protocol IYWContactService <NSObject>

/**
 *  在线状态
 */

/// 是否启用在线状态功能,默认为NO，即所有用户均显示为在线
@property (nonatomic, assign) BOOL enableContactOnlineStatus;

/// 固定在线的帐号
@property (nonatomic, strong) NSArray *arrayForceOnlinePersons;

/// 联系人在线状态变化的回调
/// 当这个block返回NO时，意味着不需要再响应，从此以后将不会再调用这个block
typedef BOOL (^YWOnlineStatusChangeBlock)(YWPerson *person, BOOL onlineStatus);
typedef void (^YWOnlineStatusDidUpdateBlock)(BOOL isSuccess);

/// 获取缓存中的在线状态，不会发起网络请求,返回的字典中键类型为YWPerson，值为NSNumber，取其boolValue即可
- (NSDictionary *)getOnlineStatusForPersons:(NSArray *)persons;
/// 获取缓存中的在线状态，如果有缓存过期，则会发起网络请求，请求返回后回调block，且只回调一次
//  @param persons 需要获取在线状态的person数组
//  @param expire  过期时间，距离上次更新时间超过此参数的缓存将被认为是过期，从而触发网络请求
//  @param block   回调
- (void)updateOnlineStatusForPersons:(NSArray *)persons withExpire:(NSTimeInterval)expire andOnlineStatusUpdateBlock:(YWOnlineStatusDidUpdateBlock)block;

/// 添加对某个person在线状态改变的监听
- (void)addPersonOnlineStatusChanged:(NSArray *)persons withBlock:(YWOnlineStatusChangeBlock)block forKey:(NSString *)aKey ofPriority:(YWBlockPriority)aPriority;
/// 移除对某个person在线状态改变的监听
- (void)removePersonOnlineStatusChanged:(YWPerson *)person forKey:(NSString *)aKey;
/// 移除某个key对应的所有block
- (void)removePersonOnlineStatusChangedBlockForKey:(NSString *)aKey;


/**
 *  黑名单
 */

/// 黑名单操作的回调，当error == nil或者error.errorCode为0时表示成功。
typedef void (^YWBlackListResultBlock) (NSError *error, YWPerson *person);
typedef void (^YWFetchBlackListCompletionBlock) (NSError *error, NSArray *blackList);
/// 是否可以向黑名单中的person发送消息，默认为NO，注意，你不能收到被加入黑名单的person的回复。
@property (nonatomic, assign) BOOL canSendMessageToPersonInBlackList;
/// 添加某个person到黑名单
- (void)addPersonToBlackList:(YWPerson *)person withResultBlock:(YWBlackListResultBlock)resultBlock;
/// 将某个person从黑名单中移除
- (void)removePersonFromBlackList:(YWPerson *)person withResultBlock:(YWBlackListResultBlock)resultBlock;
/// 获取一定数量黑名单
- (void)fetchBlackListWithCompletionBlock:(YWFetchBlackListCompletionBlock)completionBlock;
/// 判断某个person是否在黑名单中
- (BOOL)isPersonInBlackList:(YWPerson *)person;


/**
 *  Profile，这一部分包括profile信息的封装、缓存、持久化和网络请求
 */

/**
 *  缓存失效时长，单位是秒。
 */
@property (nonatomic, assign) NSTimeInterval profileCacheExpireTime;

//设置profile，如果开发者已经在云旺服务端导入profile，则可以直接使用下面的接口获取profile，否则，开发者需要先设置才能获取到profile
- (BOOL)updateProfile:(YWProfileItem *)item;
- (BOOL)updateProfiles:(NSArray *)items withSave:(BOOL)save;

/**
 *  异步修改服务端profile
 *
 *  @param item   包含需要修改的Profile信息
 *  @param completionBlock 完成回调
 */
- (void)asyncUpdateProfileToServer:(YWProfileItem *)item andCompletionBlock:(YWProfileCompletionBlock)completionBlock;

/*  使用以下接口时需要注意，目前存储在服务端的个人profile并未和群关联，所以从服务端获取群成员的profile时，tribe参数无效；但开发者可以通过updateProfile接口来设置群成员的本地信息。*/

//同步获取本地profile
- (YWProfileItem *)getProfileForPerson:(YWPerson *)person withTribe:(YWTribe *)tribe;
/**
 *  异步获取本地profile
 *
 *  @param person person
 *  @param tribe  需要查询profile的person所在的群，如果只需要查询这个person的profile，请置为nil。
 */
- (void)getProfileForPerson:(YWPerson *)person
                  withTribe:(YWTribe *)tribe
        withCompletionBlock:(YWProfileCompletionBlock)completionBlock;

/**
 *  异步从服务端获取profile
 *
 *  @param tribe,          目前暂未使用
 *  @param progressBlock   部分结果的回调
 *  @param completionBlock 完成回调
 */
- (void)asyncGetProfileFromServerForPerson:(YWPerson *)person
                                 withTribe:(YWTribe *)tribe
                              withProgress:(YWProfileProgressBlock)progressBlock
                        andCompletionBlock:(YWProfileCompletionBlock)completionBlock;
/**
 *  异步从服务端获取profile, 批量接口 
 *  @param persons, 元素类型为YWPerson，单次请求数量不大于100
 */
- (void)asyncGetProfileFromServerForPersons:(NSArray *)persons
                                  withTribe:(YWTribe *)tribe
                        withCompletionBlock:(YWProfilesCompletionBlock)completionBlock;

/**
 *  异步从服务端获取开发者导入的原始数据, 批量接口,这个接口获取的数据不会持久化
 *  @param persons, 元素类型为YWPerson，单次请求数量不大于100
 *  @return aProfileDictionariesArray是一个数组，包含了所请求的person的profile字典，字典中key的定义请查看 YWContactServiceDef.h中 kYWProfileUserId 等定义
 */
- (void)asyncGetAllProfileFromServerForPersons:(NSArray *)persons
                           withCompletionBlock:(void (^)(NSError *aError, NSArray *aProfileDictionariesArray))completionBlock;

/**
 *  先获取本地profile，如果本地不存在或者超时，则向服务端请求
 *
 *  @param interval        profile有效期
 */
- (void)getProfileForPerson:(YWPerson *)person withTribe:(YWTribe *)tribe expireInterval:(NSTimeInterval)interval withProgress:(YWProfileProgressBlock)progressBlock andCompletionBlock:(YWProfileCompletionBlock)completionBlock;

/**
 *  先获取本地profile，如果本地不存在或者超时，则向服务端请求, 批量接口
 *  @param persons, 元素类型为YWPerson，单次请求数量不大于100
 */
- (void)getProfileForPersons:(NSArray *)persons withTribe:(YWTribe *)tribe expireInterval:(NSTimeInterval)interval withProgress:(YWProfileProgressBlock)progressBlock andCompletionBlock:(YWProfilesCompletionBlock)completionBlock;

// 删除profile
- (BOOL)removeProfileForPerson:(YWPerson *)person withTribe:(YWTribe *)tribe withSave:(BOOL)save;
- (BOOL)removeProfileForPerson:(YWPerson *)person withSave:(BOOL)save;
- (BOOL)removeProfileForPersons:(NSArray *)personArray withSave:(BOOL)save;

- (void)removeProfileForTribe:(YWTribe *)tribe withSave:(BOOL)save;
- (void)removeProfileForTribeId:(NSString *)tribeId withSave:(BOOL)save;
- (BOOL)removeAllProfiles;

// 直接获取profile的类，不会加载avatar的image
@property (nonatomic, strong, readonly) YWProfileManager *profileManager;

/**
 *  好友功能
 */

/**
 *  联系人列表，目前只支持淘宝域。第三方OpenIM并没有此服务，OpenIM开发者自己维护好友关系。
 */
/// 是否禁用sdk登陆成功后自动获取联系人列表功能，默认为NO
@property (nonatomic, assign) BOOL disableAutoRequestAllContacts;

/// 获取不同排序和分组模式的FRC对象
- (YWFetchedResultsController *)fetchedResultsControllerWithListMode:(YWContactListMode)aMode imCore:(YWIMCore *)imCore;

/// 使用关键字搜索用户，使用用户名
// 如果希望搜索好友，needIsFriend置为YES，否则可以置为NO
- (YWFetchedResultsController *)fetchedResultsControllerWithSearchKeyword:(NSString *)aKeyword needIsFriend:(BOOL)needIsFriend imCore:(YWIMCore *)imCore;

/// 获取本地所有的联系人
- (NSArray *)fetchAllContacts;
- (void)requestAllContactsFromServerWithResultBlock:(YWContactsOperationResultBlock)resultBlock;

/// @brief 请求添加好友
/// @param introduction,被添加放看到的介绍内容
/// @param completionBlock
- (void)addContact:(YWPerson *)person withIntroduction:(NSString *)introduction withResultBlock:(YWAddContactRequestResultBlock)resultBlock;

/// @brief 修改联系人备注
- (void)modifyContact:(YWPerson *)person WithNewNick:(NSString *)nickName andResultBlock:(YWContactOperationResultBlock)resultBlock;

/// @brief 请求删除好友关系
/// @param person YWPerson 待删除好友
/// @param resultBlock YWRemoveContactResultBlock 请求回调
- (void)removeContact:(YWPerson *)persons withResultBlock:(YWRemoveContactResultBlock)resultBlock;
/// @brief 批量请求删除好友关系
/// @param person YWPerson 待删除好友
/// @param resultBlock YWRemoveContactResultBlock 请求回调
- (void)removeContacts:(NSArray *)persons withResultBlock:(YWRemoveContactResultBlock)resultBlock;

/// @brief 处理别人发送的添加联系人请求
/// @param accept BOOL YES:接收好友请求 NO:拒绝好友请求
/// @param person YWPerson 请求发起方
/// @param message NSString 拒绝附带信息
/// @param resultBlock YWAddContactResultBlock 请求回调 error code 见YWContactAddResponseErrorCode
- (void)responseToAddContact:(BOOL)accept fromPerson:(YWPerson *)person
                 withMessage:(NSString*)message
              andResultBlock:(YWAddContactResultBlock)resultBlock;

- (BOOL)ifPersonIsFriend:(YWPerson *)person;

/**
 *  获取对淘宝域好友做的备注名
 */
- (NSString *)contactNickOfPerson:(YWPerson *)aPerson;

#pragma mark - 更新回调

/// @brief 添加好友通知的回调
/// @param block person:请求加为好友对象 accept 对方是否接受添加好友(可能存在系统添加行为)
/// @param key NSString 用来区分不同的监听者，一般可以使用监听对象的description
/// @param priority YWBlockPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriorityDeveloper
- (void)addAddContactResponseBlockV2:(void (^)(YWPerson *person, YWContactAddResponseType type, BOOL isOffline, NSString *message))block
                              forKey:(NSString *)key ofPriority:(YWBlockPriority)priority;


/// @brief 移除好友通知的回调
/// @param key 用来区分不同的监听者，一般可以使用监听对象的description
- (void)removeAddContactResponseBlockWithKey:(NSString *)key;

/// @brief 添加验证添加好友请求的监听，当别人请求添加你为好友时sdk会调用这个block通知开发者
/// @param block person:请求加为好友对象 accept 对方是否接受添加好友(可能存在系统添加行为)
/// @param key NSString 用来区分不同的监听者，一般可以使用监听对象的description
/// @param priority YWBlockPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriorityDeveloper
- (void)addAddContactRequestBlockV2:(void (^)(YWPerson *person, YWContactAddRequestType type, BOOL isOffline, NSString *message))block
                             forKey:(NSString *)key ofPriority:(YWBlockPriority)priority;

/// @brief 移除验证添加好友请求的监听
/// @param key 用来区分不同的监听者，一般可以使用监听对象的description
- (void)removeAddContactRequestBlockWithKey:(NSString *)key;

/// @brief 添加对方解除好友关系的监听
/// @param key 用来区分不同的监听者，一般可以使用监听对象的description
- (void)addFriendBeRemovedBlock:(void (^)(YWPerson *person, BOOL isOffline))block
                         forKey:(NSString *)key ofPriority:(YWBlockPriority)priority;

/// @brief 移除对方解除好友关系的监听
- (void)removeFriendBeRemovedBlockWithKey:(NSString *)key;

/// @brief 获取联系人系统消息列表（请求加好友列表）
/// @return YWContactSystemConversation 联系人系统消息列表
- (YWConversation *)fetchContactSystemConversation;


/**
 * 以下接口，目前仅限淘宝域账号
 */

/// @brief 请求添加好友：该接口有返回多种结果，请根据返回的error code做处理。
/// @param resultBlock YWAddContactResultBlock 请求回调 error code见YWAddContactErrorCode定义
- (void)addContact:(YWPerson *)person withResultBlock:(YWAddContactResultBlock)resultBlock;

/// @brief 请求验证添加好友：处理YWAddContactErrorNeedAuth，并调用该接口验证添加好友
/// @param message NSString 验证信息
/// @param resultBlock YWAddContactResultBlock 请求回调 error code见YWAddContactErrorCode定义
- (void)addContact:(YWPerson *)person withMessage:(NSString *)message
    andResultBlock:(YWAddContactResultBlock)resultBlock;

/// @brief 请求回答问题添加好友：处理YWAddContactErrorNeedAnswer，并调用该接口回答问题添加好友
/// @param answer NSString 问题答案
/// @param resultBlock YWAddContactResultBlock 请求回调 error code见YWAddContactErrorCode定义
- (void)addContact:(YWPerson *)person withAnswer:(NSString *)answer
    andResultBlock:(YWAddContactResultBlock)resultBlock;

/// 获取带分组的联系人
- (void)requestAllContactsWithGroupFromServerForType:(YWContactListType)type WithCompletionBlock:(YWCompletionBlock)completionBlock;


#pragma mark - 分组操作

/// 获取本地分组列表
- (NSArray<YWGroup *> *)getAllLocalGroups;
/// 获取某个分组
- (YWGroup *)fetchGroupWithGroupId:(NSNumber *)aGroupId;
/// 获取某个person的分组
- (YWGroup *)fetchGroupWithPerson:(YWPerson *)aPerson;
/// 从服务端请求分组列表
- (void)requestGroupsFromServerWithCompletionBlock:(YWGroupsOperationResultBlock)completionBlock;
/// 添加分组
- (void)addGroupWithName:(NSString *)groupName withCompletionBlock:(YWGroupOperationResultBlock)completionBlock;
/// 删除分组
- (void)deleteGroup:(YWGroup *)group withCompletionBlock:(YWGroupOperationResultBlock)completionBlock;
/// 修改分组信息
- (void)changeGroup:(YWGroup *)group withNewName:(NSString *)groupName CompletionBlock:(YWGroupOperationResultBlock)completionBlock;
/// @brief  移动联系人分组
/// @param  group,联系人新的分组
- (void)moveContact:(YWPerson *)person toGroup:(YWGroup *)group withResultBlock:(YWContactOperationResultBlock)resultBlock;




#pragma mark - deprecated


/**
 *  服务端Profile
 *  @note 如果你导入账号时，同时导入了用户Profile，则可以通过此接口获取你导入的用户profile
 */
- (void)asyncGetProfileForPerson:(YWPerson *)person
                        progress:(YWFetchProfileProgressBlock)progressBlock
                 completionBlock:(YWFetchProfileCompletionBlock)completionBlock __attribute__((deprecated("请使用asyncgetProfileFromServerForPerson: inTribe: withProgress: andCompletionBlock:")));

/// @brief 添加好友通知的回调
/// @param block person:请求加为好友对象 accept 对方是否接受添加好友(可能存在系统添加行为)
/// @param key NSString 用来区分不同的监听者，一般可以使用监听对象的description
/// @param priority YWBlockPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriorityDeveloper
- (void)addAddContactResponseBlock:(void (^)(YWPerson *person, YWContactAddResponseType type, BOOL isOffline))block
                            forKey:(NSString *)key ofPriority:(YWBlockPriority)priority __attribute__((deprecated("请使用addAddContactResponseBlockV2: forKey: ofPriority:")));

/// @brief 添加验证添加好友请求的监听
/// @param block person:请求加为好友对象 accept 对方是否接受添加好友(可能存在系统添加行为)
/// @param key NSString 用来区分不同的监听者，一般可以使用监听对象的description
/// @param priority YWBlockPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriorityDeveloper
- (void)addAddContactRequestBlock:(void (^)(YWPerson *person, YWContactAddRequestType type, BOOL isOffline))block
                           forKey:(NSString *)key ofPriority:(YWBlockPriority)priority __attribute__((deprecated("请使用addAddContactRequestBlockV2: forKey: ofPriority:")));


@end
