//
//  VSWeakSelectorTarget.h
//  VideoStudio
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSWeakSelectorTarget : NSObject

@property (readonly, nonatomic, weak) id target;
@property (readonly, nonatomic) SEL targetSelector;
@property (readonly, nonatomic) SEL handleSelector;

- (instancetype)initWithTarget:(id)target targetSelector:(SEL)targetSelector;

- (BOOL)sendMessageToTarget:(id)param;

@end
