//
// Created by efeng on 16/7/18.
// Copyright (c) 2016 buerguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EditView;

@interface YIMosaicsView : UIView {
    EditView *editView;
}


@property(nonatomic) EditView *editView;

- (instancetype)initWithMosaicsImage:(UIImage *)aMosaicsImage;

+ (instancetype)viewWithMosaicsImage:(UIImage *)aMosaicsImage;

- (UIImage *)savedImage;
@end