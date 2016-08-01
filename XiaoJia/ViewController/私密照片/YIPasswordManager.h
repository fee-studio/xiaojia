//
//  YIPasswordManager.h
//  YIBox
//
//  Created by efeng on 16/3/5.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BKPasscodeViewController.h"


typedef void (^CreateCompleteBlock)(UIViewController *vc);

typedef void (^DidFinishedBlock)(void);
// typedef void (^DidFinishedBlock)(); // 写法同上



@interface YIPasswordManager : NSObject

@property(nonatomic, strong) UIViewController *superVc;


+ (YIPasswordManager *)sharedInstance;

- (void)createPasscodeViewControllerWithType:(BKPasscodeViewControllerType)type
                      andCreateCompleteBlock:(CreateCompleteBlock)completeBlock
                         andDidFinishedBlock:(DidFinishedBlock)finishBlock;

@end
