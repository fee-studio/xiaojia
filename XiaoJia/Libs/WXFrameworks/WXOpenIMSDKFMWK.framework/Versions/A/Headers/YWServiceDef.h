//
//  YWServiceDef.h
//
//
//  Created by huanglei on 14/12/11.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

/**
 * 异步执行的统一回调
 * @param aError 结果错误类型，如果没有错误则为nil
 * @param aResult 存放结果数据，key由各业务协商定义
 */
typedef void(^YWCompletionBlock)(NSError *aError, NSDictionary *aResult);


/**
 *  异步发送消息完成的统一回调
 *
 *  @param aError  结果错误类型，如果没有错误则为nil
 *  @param messageID 完成消息发送的消息 ID
 */
typedef void(^YWMessageSendingCompletionBlock)(NSError *error, NSString *messageID);

/// error的userInfo中，使用这个key来传递错误描述
FOUNDATION_EXTERN NSString *const YWErrorUserInfoKeyDescription;

/**
 * 异步执行的进度回调
 * @param aProgress 进度值，0.f~1.0f
 * @param aUserInfo 额外传递的信息，key由各业务协商定义
 */
typedef void(^YWProgressBlock)(CGFloat aProgress, NSDictionary *aUserInfo);


/**
 * 异步执行的进度回调
 * @param aProgress 进度值，0.f~1.0f
 *  @param messageID 完成消息发送的消息 ID
 */
typedef void(^YWMessageSendingProgressBlock)(CGFloat progress, NSString *messageID);

/**
 *  Block优先级定义
 */
typedef NS_ENUM(NSUInteger, YWBlockPriority) {
    /// 开发者的回调
    YWBlockPriorityDeveloper = 1,
    /// 不同模块的回调
    YWBlockPriorityOtherModule,
    /// 本模块的回调
    YWBlockPriorityThisModule
};

@class YWIMCore;
/**
 *  IMKit必须遵循这个初始化协议
 */
@protocol YWIMKitLifeProtocol <NSObject>

- (id<YWIMKitLifeProtocol>)initWithIMCore:(YWIMCore *)aIMCore;

@end



/**
 *  数据集变更相关定义
 */

/// 对象变更方式
typedef enum : NSUInteger {
    /// 对象被插入
    YWObjectChangeTypeInsert = 1,
    /// 对象被删除
    YWObjectChangeTypeDelete = 2,
    /// 对象被移动
    YWObjectChangeTypeMove = 3,
    /// 对象被修改
    YWObjectChangeTypeUpdate = 4
} YWObjectChangeType;


/**
 *  数据集发生变更的回调，用于变更前或者变更完成时
 */
typedef void (^YWContentChangeBlock)(void);

/**
 *  数据集发生重置的回调，用于数据集全部重新载入时
 */
typedef void (^YWResetContentBlock)(void);

/**
 *  数据集变更的回调。单个对象的变更。
 *  @param object 被变更的对象
 *  @param indexPath 对象原先的位置
 *  @param newIndexPath 对象的新位置
 *  @param type 变更的方式，参见： YWObjectChangeType。
 */
typedef void (^YWObjectChangeBlock)(id object, NSIndexPath *indexPath, YWObjectChangeType type, NSIndexPath *newIndexPath);

/**
 *  数据集变更的回调。单个对象的变更。
 *  @param aSectionInfo 变更的Section
 *  @param aSectionIndex 变更的index
 *  @param aType 变更的类型，这里用到的值只有YWObjectChangeTypeInsert和YWObjectChangeTypeDelete
 */
typedef void(^YWSectionChangeBlock)(id<NSFetchedResultsSectionInfo> aSectionInfo, NSUInteger aSectionIndex, YWObjectChangeType aType);

@class YWFetchedResultsController;
@protocol YWFetchedResultsControllerDelegate <NSObject>
- (void)controllerWillChangeContent:(YWFetchedResultsController *)controller;
- (void)controller:(YWFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(YWObjectChangeType)type newIndexPath:(NSIndexPath *)newIndexPath;
- (void)controllerDidChangeContent:(YWFetchedResultsController *)controller;
- (void)controllerDidResetContent:(YWFetchedResultsController *)controller;

@optional
- (void)controller:(YWFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(YWObjectChangeType)type;
@end


/**
 *  类似于NSFetchedResultsController，用于检索和监听数据集
 */
@interface YWFetchedResultsController : NSObject

@property (nonatomic, weak) YWIMCore *imCore;
@property (nonatomic, readonly) NSArray<id<NSFetchedResultsSectionInfo> > *sections;
@property (nonatomic, readonly) NSArray *sectionIndexTitles;
@property (nonatomic, readonly) NSArray *fetchedObjects;
@property (nonatomic, readonly) NSUInteger countOfFetchedObjects;



- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

-(NSIndexPath *)indexPathForObject:(id)object;

// 同NSFetchedResultsController
- (NSInteger)sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)sectionIndex;

- (void)resetContent;

/**
 *  fetchedObjects重新fetch的时候，回调该block(fetchedObjects里面的对象有可能重新构造了)
 */
@property (copy, nonatomic) YWContentChangeBlock didResetContentBlock;

/**
 *  内容即将发生变更时的回调 block
 */
@property (copy, nonatomic, readonly) YWContentChangeBlock willChangeContentBlock;
- (void)setWillChangeContentBlock:(YWContentChangeBlock)willChangeContentBlock;

/**
 *  具体消息变更的回调 block
 */
@property (copy, nonatomic, readonly) YWContentChangeBlock didChangeContentBlock;
- (void)setDidChangeContentBlock:(YWContentChangeBlock)didChangeContentBlock;

/**
 *  内容已经完成变更的回调 block
 */
@property (copy, nonatomic, readonly) YWObjectChangeBlock objectDidChangeBlock;
- (void)setObjectDidChangeBlock:(YWObjectChangeBlock)objectDidChangeBlock;

/**
 *  Section完成变更的回调 block
 */
@property (copy, nonatomic, readonly) YWSectionChangeBlock sectionDidChangeBlock;
- (void)setSectionDidChangeBlock:(YWSectionChangeBlock)sectionDidChangeBlock;

/**
 *  移除所有监听回调
 */
- (void)removeAllBlocks;

@property (nonatomic, weak) id<YWFetchedResultsControllerDelegate> delegate;

@end


@interface YWServiceDef : NSObject

@end
