//
//  YIPhotoCollectionViewLayout.m
//  LoveWallpaper
//
//  Created by efeng on 14-8-19.
//  Copyright (c) 2014年 buerguo. All rights reserved.
//

#import "YIPhotoCollectionViewLayout.h"

@implementation YIPhotoCollectionViewLayout


- (id)init {
    self = [super init];
    if (self) {
        int count = 4;
        float w = (mScreenWidth - (count - 1)) / count;
        float w1 = floorf(w * 1) / 1;
        self.itemSize = CGSizeMake(w1, w1);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumLineSpacing = (mScreenWidth - w1 * count) / (count - 1);
        self.minimumInteritemSpacing = (mScreenWidth - w1 * count) / (count - 1);
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds {
    return YES;
}


@end
