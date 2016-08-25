//
//  IYWTribeService.h
//  
//
//  Created by Jai Chen on 15/1/13.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import "YWTribe.h"
#import "YWTribeMember.h"
#import "YWServiceDef.h"
#import "IYWTribeServiceDef.h"
#import "YWTribeSystemConversation.h"
#import "YWMessageBodyTribeSystem.h"

@class YWPerson;

#pragma mark - 服务接口定义

/**
 * 提供群管理相关功能
 */
@protocol IYWTribeService <NSObject>

/**
 *  从服务器获取所有已加入群，所获得的群只包含群 ID 和群名称等基本信息,
 *  通过 completion block 的 tribes 参数返回包含 WXOTribe 的数组
 */
- (void)requestAllTribesFromServer:(void (^)(NSArray *tribes, NSError *error))completion;

/**
 *  从服务器获取指定群 ID 的群, 返回的群包括如群公告等详细信息
 */
- (void)requestTribeFromServer:(NSString *)tribeId
                   completion:(void (^)(YWTribe *tribe, NSError *error))completion;

- (void)requestCurrentUserInfoInTribe:(NSString *)tribeId completion:(void(^)(NSDictionary *info, NSError *error))completion;

/**
 *  从本地数据库中获取所有已加入个群，返回包含 YWTribe 的数组 
 *  可作为YWSearchEngine的数据源使用，用于实现搜索群功能
 */
- (NSArray *)fetchAllTribes;

/**
 *  从本地数据库中获取某各个群
 */
- (YWTribe *)fetchTribe:(NSString *)tribeId;


/**
 *  统一的创建群的接口
 *  @param aDescription 创建参数，请创建该对象，设置合适的属性后，传入这个函数使用
 *  @param completion 回调block
 */
- (void)createTribeWithDescription:(YWTribeDescriptionParam *)aDescription
                        completion:(void (^)(YWTribe *tribe, NSError *error))completion;

/**
 *  修改群名称或者群公告，将需要更改的新名称或者新公告作为参数传入，不需要修改的内容传入 nil
 */
- (void)modifyName:(NSString *)name
            notice:(NSString *)notice
          forTribe:(NSString *)tribeId
        completion:(void (^)(NSString *tribeId, NSError *error))completion;

- (void)enableAtAllForAllTribeMember:(BOOL)enable forTribe:(NSString *)tribeId completion:(void(^)(NSError *error))completion;

/**
 *  修改群的验证类型
 *
 *  @param checkMode  加入群的校验模式
 *  @param checkInfo  校验信息，目前仅当 checkMode 为 YWTribeCheckModePassword 时有效，checkInfo 会作为加入群的密码，密码只限使用英文和数字，长度不可超过 50
 *  @param tribeId    群ID
 *  @param completion 回调 block
 */
- (void)modifyCheckMode:(YWTribeCheckMode)checkMode
              checkInfo:(NSString *)checkInfo
                ofTribe:(NSString *)tribeId
             completion:(void (^)(NSString *tribeId, YWTribeCheckMode checkMode, NSError *error))completion;

/**
 *  请求加入群
 */
- (void)joinTribe:(NSString *)tribeId
         completion:(void (^)(NSString *tribeId, NSError *error))completion;

/**
 *  请求加入群
 *
 *  @param tribe      群对象
 *  @param checkInfo  验证信息, 与群的 checkMode 对应，
 *                    checkMode 为 YWTribeCheckModePassword 时，checkInfo 应传入密码，密码正确则直接加入群
 *                    checkMode 为 YWTribeCheckModeIdentity 时，checkInfo 可传入附加信息，用于展示在管理员收到的入群申请信息中
 *                    checkMode 为其它值时此参数无效
 *  @param completion 回调 block
 */
- (void)joinTribe:(YWTribe *)tribe
        checkInfo:(NSString *)checkInfo
       completion:(void (^)(NSString *tribeId, NSError *error))completion;
/**
 *  退出群
 */
- (void)exitFromTribe:(NSString *)tribeId
           completion:(void (^)(NSString *tribeId, NSError *error))completion;


/**
 *  解散群
 */
- (void)disbandTribe:(NSString *)tribeId
          completion:(void (^)(NSString *tribeId, NSError *error))completion;
#pragma mark - 群成员

/**
 *  从服务器获取群成员列表
 *
 *  @param completion 中 members 参数为包含 YWTribeMember 的数组
 */
- (void)requestTribeMembersFromServer:(NSString *)tribeId
                 completion:(void (^)(NSArray *members, NSString *tribeId, NSError *error))completion;


/**
 *  从本地数据库中获取中群的所有成员，返回包含 YWTribeMember 的数组
 */
- (NSArray *)fetchTribeMembers:(NSString *)tribeId;

/**
 *  从本地数据库中获取指定群中指定人对应的 YWTribeMember 对象
 */
- (YWTribeMember *)fetchTribeMember:(YWPerson *)person inTribe:(NSString *)tribeID;

/**
 *  邀请成员加入群
 *
 *  @param members    包含待加入 YWPerson 的数组
 *  @param completion 本次邀请的成员中，成功加入的成员数组，元素为 YWTribeMember 对象
 */
- (void)inviteMembers:(NSArray *)members toTribe:(NSString *)tribeId
           completion:(void (^)(NSArray *members, NSString *tribeId, NSError *error))completion;

/**
 *  将某成员从群中踢出
 *
 *  @param member     群成员 YWTribeMember 对象
 */
- (void)expelMember:(YWPerson *)member fromTribe:(NSString *)tribeId
         completion:(void (^)(YWPerson *member, NSString *tribeId, NSError *error))completion;


/**
 *  将某成员设置为管理员或普通成员角色
 *
 *  @param member     群成员 YWTribeMember 对象
 *  @param role       角色 YWTribeMemberRole
 */
- (void)setMember:(YWPerson *)member withRole:(YWTribeMemberRole)role fromTribe:(NSString *)tribeId
         completion:(void (^)(YWPerson *member,YWTribeMemberRole role,NSString *tribeId, NSError *error))completion;


/**
 *  修改群成员在群中的昵称
 */
- (void)modifyNickname:(NSString *)nickname
              ofMember:(YWTribeMember *)member
               inTribe:(NSString *)tribeId
            completion:(void (^)(YWTribeMember *member, NSString *tribeId, NSError *error))completion;

#pragma mark - 更新回调
/**
 *  设置群信息更新的回调
 *
 *  @param block    通过参数 userInfo 返回更新信息，userInfo 中可能包含的 Key 为: YWTribeServiceKeyTribeId (群Id)、YWTribeServiceKeyTribeName (群名称)、YWTribeServiceKeyTribeNotice (群公告)、YWTribeServiceKeyTribeAtAll（@all的开关）,当某信息被更新时，userInfo 将包含相应的键值对
 *  @param aKey 用来区分不同的监听者，一般可以使用监听对象的description
 *  @param aPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriorityDeveloper
 */
- (void)addTribeInfoDidUpdateBlock:(void (^)(NSDictionary *userInfo))block forKey:(NSString *)key ofPriority:(YWBlockPriority)priority;

/**
 *  移除群信息更新回调
 */
- (void)removeTribeInfoDidUpdateBlockForKey:(NSString *)key;

/**
 *  设置当前用户被从群中踢出的回调
 *  @param block    通过参数 userInfo 返回更新信息，userInfo 可能包含的 Key 为: tribeId(群 ID)、tribeName(群名称)
 *  @param aKey 用来区分不同的监听者，一般可以使用监听对象的description
 *  @param aPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriorityDeveloper
 */
- (void)addDidExpelFromTribeBlock:(void (^)(NSDictionary *userInfo))block forKey:(NSString *)key ofPriority:(YWBlockPriority)priority;

/**
 *  移除当前用户被从群中踢出的回调
 */
- (void)removeDidExpelFromTribeBlockForKey:(NSString *)key;

/**
 *  被邀请加入群的回调
 *  @param block    通过参数 userInfo 返回更新信息，userInfo 可能包含的 Key 为: YWTribeServiceKeyTribeId(群 ID)、YWTribeServiceKeyTribeName(群名称),YWTribeServiceKeyPerson(邀请者)
 *  @param aKey 用来区分不同的监听者，一般可以使用监听对象的description
 *  @param aPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriorityDeveloper
 */
- (void)addInvitationFromTribeBlock:(void (^)(NSDictionary *userInfo))block forKey:(NSString *)key ofPriority:(YWBlockPriority)priority;

/**
 *  移除被邀请加入群的回调
 */
- (void)removeInvitationFromTribeBlockForKey:(NSString *)key;

/**
 *  设置群主变更的回调，对于多聊群，用于通知新增管理员
 *
 *  @param block     通过参数 userInfo 返回更新信息，userInfo 可能的 Key 为: tribeId(群 ID)、tribeName(群名称)、oldOwner(变更前的群主)、newOwner(变更后的新群主)
 *  @param key       无实际意义的唯一标识符，通过该 key 可以移除指定的回调
 *  @param aPriority 被通知的优先级
 */
- (void)addTribeOwnerDidChangeBlock:(void (^)(NSDictionary *userInfo))block
                             forKey:(NSString *)key
                         ofPriority:(YWBlockPriority)aPriority;

/**
 *  移除群主变更的回调
 */
- (void)removeTribeOwnerDidChangeBlockForKey:(NSString *)key;

/**
 *  设置取消管理员的回调
 *
 *  @param block     通过参数 userInfo 返回更新信息，userInfo 可能的 Key 为: tribeId(群 ID)、tribeName(群名称)、removedAdmin(被取消的管理员)
 *  @param key       无实际意义的唯一标识符，通过该 key 可以移除指定的回调
 *  @param aPriority 被通知的优先级
 */
- (void)addTribeRemoveAdminBlock:(void (^)(NSDictionary *userInfo))block
                             forKey:(NSString *)key
                         ofPriority:(YWBlockPriority)aPriority;

/**
 *  移除取消管理员的回调
 */
- (void)removeTribeRemoveAdminBlockForKey:(NSString *)key;



/**
 *  成员加入群的回调
 *  @param block    通过参数 userInfo 返回更新信息，userInfo 可能包含的 Key 为: YWTribeServiceKeyTribeId(群 ID)、YWTribeServiceKeyTribeName(群名称),YWTribeServiceKeyPerson(加入群的成员)
 *  @param aKey 用来区分不同的监听者，一般可以使用监听对象的description
 *  @param aPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriorityDeveloper
 */
- (void)addMemberDidJoinBlock:(void (^)(NSDictionary *userInfo))block
                             forKey:(NSString *)key
                         ofPriority:(YWBlockPriority)aPriority;
- (void)removeMemberDidJoinBlockForKey:(NSString *)key;


/**
 *  成员退出群的回调
 *  @param block    通过参数 userInfo 返回更新信息，userInfo 可能包含的 Key 为: YWTribeServiceKeyTribeId(群 ID)、YWTribeServiceKeyPerson(退出的成员)
 *  @param aKey 用来区分不同的监听者，一般可以使用监听对象的description
 *  @param aPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriorityDeveloper
 */
- (void)addMemberDidExitBlock:(void (^)(NSDictionary *userInfo))block
                             forKey:(NSString *)key
                         ofPriority:(YWBlockPriority)aPriority;
- (void)removeMemberDidExitBlockForKey:(NSString *)key;


/**
 *  群被解散的回调
 *  @param block    通过参数 userInfo 返回更新信息，userInfo 包含的 Key 为: YWTribeServiceKeyTribeId(群 ID)、YWTribeServiceKeyTribeName(群名称)
 *  @param aKey 用来区分不同的监听者，一般可以使用监听对象的description
 *  @param aPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriorityDeveloper
 */
- (void)addTribeDidDisbandBlock:(void (^)(NSDictionary *userInfo))block
                             forKey:(NSString *)key
                         ofPriority:(YWBlockPriority)aPriority;
- (void)removeTribeDidDisbandBlockForKey:(NSString *)key;


/**
 *  群成员昵称变更的回调
 *
 *  @param block    通过参数 userInfo 返回更新信息，userInfo 包含的 Key 为: YWTribeServiceKeyTribeId(群 ID)、YWTribeServiceKeyTribeName(群名称)
 *  @param key      用来区分不同的监听者，一般可以使用监听对象的description
 *  @param priority aPriority 有多个监听者时，调用的优先次序。开发者一般设置：YWBlockPriorityDeveloper
 */
- (void)addNicknameOfMemberDidUpdateBlock:(void(^)(NSDictionary *userInfo))block
                                   forKey:(NSString *)key
                               ofPriority:(YWBlockPriority)priority;
- (void)removeNicknameOfMemberDidUpdateBlock:(NSString *)key;

#pragma mark - 群系统消息

/**
 *  获取群系统的会话，用于获取群邀请消息
 */
- (YWTribeSystemConversation *)fetchTribeSystemConversation;


/**
 *  处理群系统消息
 *
 *  @param messageBody 群系统消息体，近当其状态为 YWMessageBodyTribeSystemStatusWait2BProcess 才应对其进行处理
 *  @param status      待设置的状态
 */
- (void)processTribeSystemMessageBody:(YWMessageBodyTribeSystem *)messageBody
                             toStatus:(YWMessageBodyTribeSystemStatus)status
                           completion:(void (^)(NSError *error))completion;

/**
 *  同意邀请
 */
- (void)acceptInviteFromTribe:(NSString *)tribeId
                   completion:(void (^)(NSString *tribeId, NSError *error))completion  __attribute__((deprecated("请使用 processTribeSystemMessageBody:toStatus:completion: 函数")));
- (void)ignoreInviteFromTribe:(NSString *)tribeID  __attribute__((deprecated("请使用 processTribeSystemMessageBody:toStatus:completion: 函数")));





#pragma mark - deprecated

/**
 *  创建多聊群
 *
 *  @param name  群名称
 *  @param notice   群公告
 *  @param persons    包含 WXOPerson 的数组
 *  @param completion 创建群结束后的回调 block，成功则通过 block 的 tribe 参数返回所创建的群，失败则为 nil 且通过 error 提示错误
 */
- (void)createTribeWithName:(NSString *)name
                     notice:(NSString *)notice
                    members:(NSArray *)members
                 completion:(void (^)(YWTribe *tribe, NSError *error))completion __attribute__((deprecated("请使用 createTribeWithDescription:completion: 函数")));

#pragma mark -
- (YWFetchedResultsController *)fetchedResultsControllerForMembersOfTribe:(NSString *)tribeID
                                                             searchString:(NSString *)keyword
                                                        groupWithAlphabet:(BOOL)groupWithAlphabet
                                                          excludedPersons:(NSArray<YWPerson *> *)excludedPersons;

#pragma mark - Search
/**
 *  根据关键字搜索所有群消息，目前仅支持文本消息搜索
 *
 *  @param keyword  关键字
 */
- (YWFetchedResultsController *)searchTribeMessagesWithKeyword:(NSString *)keyword;

/**
 *  根据关键字创建搜索使用的frc,搜索匹配tirbeId,tribeName,notice
 *
 *  @param keyword 搜索关键字
 *
 *  @return 搜索的frc
 */
- (YWFetchedResultsController *)searchTribeWithKeyword:(NSString *)keyword;
@end

