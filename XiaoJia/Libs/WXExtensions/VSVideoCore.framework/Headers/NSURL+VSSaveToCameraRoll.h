//
//  NSURL+VSSaveToCameraRoll.h
//  VideoStudio
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (VSSaveToCameraRoll)

- (void)saveToCameraRollWithCompletion:(void (^__nullable)(NSString * _Nullable path, NSError * _Nullable error))completion;

@end
