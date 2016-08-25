//
//  WXOConversationListViewController.h
//  TAEDemo
//
//  Created by Jai Chen on 14/12/24.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IYWUIServiceDef.h"
#import "YWConversationCell.h"

@class YWConversation;
@class YWIMCore;
@class YWIMKit;


@interface YWConversationListViewController : UITableViewController
<YWViewControllerEventProtocol>

/**
 *  创建一个会话列表Controller
 *  @param aIMKit kit对象
 */
+ (instancetype)makeControllerWithIMKit:(YWIMKit *)aIMKit;


/**
 *  IMKit对象的弱引用
 */
@property (nonatomic, weak, readonly) YWIMKit *kitRef;

/**
 *  选中某个会话后的回调
 *  @param aConversation 被选中的会话
 */
typedef void(^YWConversationsListDidSelectItemBlock)(YWConversation *aConversation);

/**
 *  选中某个会话后的回调
 */
@property (nonatomic, copy, readonly) YWConversationsListDidSelectItemBlock didSelectItemBlock;

/**
 *  设置选中某个会话后的回调
 */
- (void)setDidSelectItemBlock:(YWConversationsListDidSelectItemBlock)didSelectItemBlock;

/**
 *  删除某个会话后的回调
 *  @param aConversation 被选中的会话
 */
typedef void(^YWConversationsListDidDeleteItemBlock)(YWConversation *aConversation);

/**
 *  删除某个会话后的回调
 */
@property (nonatomic, copy, readonly) YWConversationsListDidDeleteItemBlock didDeleteItemBlock;

/**
 *  设置删除某个会话后的回调
 */
- (void)setDidDeleteItemBlock:(YWConversationsListDidSelectItemBlock)didDeleteItemBlock;

/**
 *  设置某个会话的最近消息内容后的回调
 *  @param aConversation 需要设置最近消息内容的会话
 *  @return 无需自定义最近消息内容返回nil
 */
typedef NSString *(^YWConversationsLatestMessageContent)(YWConversation *aConversation);

/**
 *  设置某个会话的最近消息内容后的回调
 */
@property (nonatomic, copy, readonly) YWConversationsLatestMessageContent latestMessageContentBlock;

/**
 *  设置某个会话的最近消息内容后的回调
 */
- (void)setLatestMessageContentBlock:(YWConversationsLatestMessageContent)latestMessageContentBlock;

@end

@interface YWConversationListViewController ()

/**
 *  在没有数据时显示该view，占据Controller的View整个页面
 */
@property (nonatomic, strong) UIView *viewForNoData;

/*
 *  会话左滑菜单设置block
 *  @ret,   需要显示的菜单数组
 *  @param, aConversation, 会话
 *  @param, editActions, 默认的菜单数组，成员为YWMoreActionItem类型
 */
typedef NSArray *(^YWConversationEditActionsBlock)(YWConversation *aConversation, NSArray *editActions);

/**
 *  可以通过这个block设置会话列表中每个会话的左滑菜单，这个是同步调用的，需要尽快返回，否则会卡住UI
 */
@property (nonatomic, copy) YWConversationEditActionsBlock conversationEditActionBlock;

/**
 *  提供自定义行高的 Block，其中 tableView 和 indexPath 可能为搜索列表的对象
 */
@property (nonatomic, copy) CGFloat (^heightForRowBlock) (UITableView *tableView, NSIndexPath *indexPath, YWConversation *conversation);

/**
 *  会话列表 Cell 的默认高度
 */
FOUNDATION_EXTERN const CGFloat YWConversationListCellDefaultHeight;

/**
 *  提供自定义 Cell 的 Block，如果返回为 nil 则使用默认 Cell
 *  当使用自定义的 Cell 时，内部将不会处理 Cell，需要使用 configureCellBlock 自行配制 Cell
 */
@property (nonatomic, copy) UITableViewCell* (^cellForRowBlock)(UITableView *tableView, NSIndexPath *indexPath, YWConversation *conversation);

/**
 *  配置 Cell 的 Block，当默认的 Cell 或自定义的 Cell 需要配置时，该 block 将被调用
 */
@property (nonatomic, copy) void (^configureCellBlock) (UITableViewCell *cell, UITableView *tableView, NSIndexPath *indexPath, YWConversation *conversation);

/**
 *  设置cell头像点击回调
 */
typedef void (^YWConversationListAvatarPressedBlock)(YWConversation *aConversation, YWConversationListViewController *aController);

@property (nonatomic, copy) YWConversationListAvatarPressedBlock avatarPressedBlock;
- (void)setAvatarPressedBlock:(YWConversationListAvatarPressedBlock)avatarPressedBlock;

@end

@interface YWConversationListViewController (YWSearchSupport)

/**
 *  与会话列表关联的 UISearchBar
 */
@property(nonatomic, readonly, strong) UISearchBar *searchBar;

@end
