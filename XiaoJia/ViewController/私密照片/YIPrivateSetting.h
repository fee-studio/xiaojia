//
//  YIPrivateSetting.h
//  YIBox
//
//  Created by efeng on 16/2/27.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YIBaseModel.h"

/*
 PPS是private photo setting的缩写
 */

typedef enum : NSUInteger {
    PPSEnterHideStateClosed,
    PPSEnterHideStateOpen
} PPSEnterHideState;

typedef enum : NSUInteger {
    PPSSimplePasswordStateClosed,
    PPSSimplePasswordStateOpen

} PPSSimplePasswordState;

typedef enum : NSUInteger {
    PPSFingerprintStateClosed,
    PPSFingerprintStateOpen
} PPSFingerprintState;

@interface YIPrivateSetting : YIBaseModel

@property(nonatomic, assign) PPSEnterHideState enterHideState;
@property(nonatomic, assign) PPSSimplePasswordState simplePasswordState;
@property(nonatomic, assign) PPSFingerprintState fingerprintState;

@property(nonatomic, copy) NSString *simplePassword;

@property(nonatomic, assign) int promptOnVersion; // 1, 点我三次 2, 再点我三次 3, 版本：xxx

@end
