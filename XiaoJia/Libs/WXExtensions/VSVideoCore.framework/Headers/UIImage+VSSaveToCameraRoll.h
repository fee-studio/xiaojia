//
//  UIImage+VSSaveToCameraRoll.h
//  VideoStudio
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (VSSaveToCameraRoll)

- (void)saveToCameraRollWithCompletion:(void (^__nullable)(NSError * _Nullable error))completion;

@end
