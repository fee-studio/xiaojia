//
//  AppDelegate.h
//  BaoBaoJi
//
//  Created by efeng on 15/9/5.
//  Copyright (c) 2015年 buerguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface YIAppDelegate : UIResponder <UIApplicationDelegate>

@property(strong, nonatomic) UIWindow *window;

@property(readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property(readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property(readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

//- (void)loadLoginViewController;
//- (void)loadMainViewController;
//- (void)loadAddBabyViewController;
//- (void)loadMainViewController2;

- (void)previewDocument:(NSURL *)url;

// 加载3D Touch快捷方式
- (void)loadShortcutItems;
@end

