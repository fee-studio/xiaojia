//
//  YWContactListControllerOfGroupMode.h
//  WXOpenIMUIKit
//
//  Created by huanglei on 15/7/21.
//  Copyright (c) 2015年 www.alibaba.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "YWContactListUIDef.h"

@class YWIMKit;
@class YWFetchedResultsController;

/// 联系人列表页面更新在线状态的频率
FOUNDATION_EXTERN NSTimeInterval const kYWContactListOnlineStatusUpdateInterval;

/**
 *  基础的联系人列表界面
 */
@interface YWBaseContactListController : UIViewController
<UITableViewDataSource, UITableViewDelegate>

/**
 *  初始化函数
 *  @param aFRC 数据源，从IYWContactService中获取
 */
- (instancetype)initWithIMKit:(YWIMKit *)aIMKit FRC:(YWFetchedResultsController *)aFRC;

/**
 *  设置新的FRC，修改数据源，会重新刷新TableView
 */
- (void)changeFRC:(YWFetchedResultsController *)aFRC;

/**
 *  选中某一个联系人的回调函数
 */
@property (nonatomic, copy, readonly) YWUIDidSelectItemsBlock didSelectItemsBlock;
- (void)setDidSelectItemsBlock:(YWUIDidSelectItemsBlock)didSelectItemsBlock;


#pragma mark - for subclass

@property (nonatomic, weak, readonly) YWIMKit *kitRef;
@property (nonatomic, strong, readonly) YWFetchedResultsController *frc;

/// 安全的获取sectionInfo，如果越界，返回nil
- (id<NSFetchedResultsSectionInfo>)safelySectionAtIndex:(NSUInteger)aIndex;

@property (nonatomic, readonly) IBOutlet UITableView *tableView;

/**
 *  子类如果增加或者删除了某些行，那必须重写下面这个函数
 */
- (NSArray *)visiableObjects;

/**
 *  子类如果增加或者删除了某些行，需要重写这个函数，在其中设置FRC的block
 */
- (void)addFRCBlocks;


/**
 *  注意：如果子类重写了父类的TableView dataSource或者delegate函数，需要考虑NSIndexPath修改对父类的影响
 *  注意：如果子类调用父类的TableView dataSource或者delegate函数，一定要先判断父类是否响应该函数
 */

@end
