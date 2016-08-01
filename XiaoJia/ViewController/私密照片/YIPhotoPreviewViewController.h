//
//  YIPhotoPreviewViewController.h
//  LoveWallpaper
//
//  Created by efeng on 14-8-19.
//  Copyright (c) 2014年 buerguo. All rights reserved.
//

#import "YIBaseCollectionViewController.h"

@protocol YIPhotoPreviewViewControllerDelegate <NSObject>

- (void)myScrollToItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface YIPhotoPreviewViewController : YIBaseCollectionViewController

@property(nonatomic, weak) id <YIPhotoPreviewViewControllerDelegate> delegate;

@property(nonatomic, copy) NSString *photoParentPath;
@property(nonatomic, strong) NSMutableArray *photoArray;
@property(nonatomic, strong) NSIndexPath *curIndexPath;
@property(nonatomic, assign) CGSize oriSize;

- (void)refreshPhotoListViewControllerCellPosition;


@end
