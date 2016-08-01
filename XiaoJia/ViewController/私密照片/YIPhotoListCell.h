//
//  MJCollectionViewCell.h
//  RCCPeakableImageSample
//
//  Created by Mayur on 4/1/14.
//  Copyright (c) 2014 RCCBox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

#define IMAGE_HEIGHT 200
#define IMAGE_OFFSET_SPEED 25

@interface YIPhotoListCell : UICollectionViewCell

@property(nonatomic, strong, readwrite) UIImage *image;
@property(nonatomic, assign, readwrite) CGPoint imageOffset;
@property(nonatomic, strong, readwrite) UIView *selectedView;
@property(nonatomic, strong, readwrite) UIView *unselectedView;


//- (void)setupCell:(YIPictureModel *)picture;

//- (void)setupCell:(id)picture;
- (void)setupCell:(PHAsset *)asset;

- (void)setupCell:(NSString *)fileName relativePath:(NSString *)path;

@end
