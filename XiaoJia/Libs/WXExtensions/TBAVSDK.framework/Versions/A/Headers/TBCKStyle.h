//
//  TBCKStyle.h
//  TBCameraKit
//
//  Created by 辰染 on 15/10/10.
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TBCKStyle : NSObject

+ (UIColor *)mainColor;
+ (UIColor *)mainColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)confirmColor;
+ (UIColor *)selectColor;
+ (UIFont *)mainFontOfSize:(CGFloat)size;
+ (UIFont *)boldMainFontOfSize:(CGFloat)size;


@end
