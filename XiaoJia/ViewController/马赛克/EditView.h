//
//  EditView.h
//  imageEdit
//
//  Created by 黄成 on 16/4/27.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditView : UIView

@property(nonatomic, assign) int drawType;  // 0: 涂抹 1: 擦除
@property(nonatomic, assign) int paintDegree;

- (instancetype)initWithImage:(UIImage *)image;

+ (instancetype)viewWithImage:(UIImage *)image;

- (UIImage *)savedImage;

@end
