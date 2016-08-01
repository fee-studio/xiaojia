//
//  EditImageManager.h
//  imageEdit
//
//  Created by 黄成 on 16/4/27.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EditImageManager : NSObject

+ (UIImage *)filterForGaussianBlur:(UIImage *)image;

@end
