//
//  YIPreviewLayout.m
//  LoveWallpaper
//
//  Created by efeng on 14-8-19.
//  Copyright (c) 2014年 buerguo. All rights reserved.
//

#import "YIPreviewLayout.h"

@implementation YIPreviewLayout


- (id)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(mScreenWidth, mScreenHeight);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsZero; //UIEdgeInsetsMake(0, 0, 0, 0);
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds {
    return YES;
}


/*
- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
    layoutAttributes.frame = CGRectMake(0.0, 0.0, self.collectionViewContentSize.width, self.collectionViewContentSize.height);
    layoutAttributes.zIndex = -1;
    return layoutAttributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [[NSMutableArray alloc] initWithCapacity:4];
    
    [allAttributes addObject:[self layoutAttributesForDecorationViewOfKind:@"FloorPlan" atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]]];
    
    for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [allAttributes addObject:layoutAttributes];
    }
    return allAttributes;
}
*/


//-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    NSArray* array = [super layoutAttributesForElementsInRect:rect];
//    CGRect visibleRect;
//    visibleRect.origin = self.collectionView.contentOffset;
//    visibleRect.size = self.collectionView.bounds.size;
//    
//    for (UICollectionViewLayoutAttributes* attributes in array) {
//        if (CGRectIntersectsRect(attributes.frame, rect)) {
//            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
//            CGFloat normalizedDistance = distance / mScreenWidth;
//            if (ABS(distance) < mScreenWidth) {
//                CGFloat zoom = 1 + 0*(1 - ABS(normalizedDistance));
//                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
//                attributes.zIndex = 1;
//            }
//        }
//    }
//    return array;
//}
//
//
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
//{
//    CGFloat offsetAdjustment = MAXFLOAT;
//    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
//    
//    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
//    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
//    
//    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
//        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
//        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
//            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
//        }
//    }
//    
//    CGPoint targetPoint = CGPointMake(proposedContentOffset.x+offsetAdjustment, proposedContentOffset.y);
//    NSLog(@"targetPoint = %@", NSStringFromCGPoint(targetPoint));
//    
//    return targetPoint;
//}

@end
