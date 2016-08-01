//
// Created by efeng on 15/11/8.
// Copyright (c) 2015 buerguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YIBaseToolVc.h"


@interface YIBaseCollectionViewController : YIBaseToolVc <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *baseCollectionView;

@property(nonatomic, strong) UICollectionViewLayout *layout;


@property(nonatomic, assign) BOOL refreshEnable;

@end