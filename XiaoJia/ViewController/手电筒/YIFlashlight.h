//
//  YIFlashlight.h
//  YIBox
//
//  Created by efeng on 2/13/16.
//  Copyright © 2016 buerguo. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, FlashlightType) {
    FlashlightTypeFlash = 0,   // 闪光灯
    FlashlightTypeScreen = 1,  // 屏幕光
};


@interface YIFlashlight : NSObject

@property(nonatomic) FlashlightType type; // 手电筒的类型
@property(nonatomic) CGFloat brightness; // 当前的屏幕亮度

+ (instancetype)sharedInstance;

@end
