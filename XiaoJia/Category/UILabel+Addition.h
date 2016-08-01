//
//  UILabel+Addition.h
//  Dobby
//
//  Created by efeng on 14-7-30.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Addition)

/**
*  重新计算UILabel的大小
*
*  @return 改变后的frame
*/
- (CGRect)resizeToStretch;

- (CGSize)calSizeOnText;

- (UILabel *)autoWidthOnText;

- (UILabel *)autoHeightOnText;

- (void)alignTop;

- (void)alignBottom;

- (UIImage *)grabImage;

@end
