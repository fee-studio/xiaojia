//
//  YIPasswordManager.m
//  YIBox
//
//  Created by efeng on 16/3/5.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "YIPasswordManager.h"


@interface YIPasswordManager () <BKPasscodeViewControllerDelegate> {
    BKPasscodeViewController *viewController;
}

//@property (nonatomic, weak) BKPasscodeViewController *viewController;
@property(nonatomic, strong) DidFinishedBlock didFinishedBlock;

@end

@implementation YIPasswordManager


+ (YIPasswordManager *)sharedInstance {

    static YIPasswordManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[[self class] alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

#pragma mark - 

- (void)createPasscodeViewControllerWithType:(BKPasscodeViewControllerType)type
                      andCreateCompleteBlock:(CreateCompleteBlock)completeBlock
                         andDidFinishedBlock:(DidFinishedBlock)finishBlock {
    self.didFinishedBlock = finishBlock;

    viewController = [[BKPasscodeViewController alloc] initWithNibName:nil bundle:nil];
    viewController.delegate = self;
    viewController.type = type;

    // Passcode style (numeric or ASCII)
    viewController.passcodeStyle = BKPasscodeInputViewNumericPasscodeStyle;

    // Setup Touch ID manager
    BKTouchIDManager *touchIDManager = [[BKTouchIDManager alloc] initWithKeychainServiceName:@"BKPasscodeSampleService"];
    touchIDManager.promptText = @"把手指放在Home键上即可！";
    viewController.touchIDManager = touchIDManager;

    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                 target:self
                                 action:@selector(passcodeViewCloseButtonPressed:)];

    completeBlock(viewController);
}

- (void)passcodeViewCloseButtonPressed:(UIBarButtonItem *)item {
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - BKPasscodeViewControllerDelegate

- (void)passcodeViewController:(BKPasscodeViewController *)aViewController authenticatePasscode:(NSString *)aPasscode resultHandler:(void (^)(BOOL))aResultHandler {
    if ([aPasscode isEqualToString:mGlobalData.privateSetting.simplePassword]) {
        //		self.lockUntilDate = nil;
        //		self.failedAttempts = 0;

        aResultHandler(YES);
    } else {
        aResultHandler(NO);
    }
}

// 失败多次后的提示
- (void)passcodeViewControllerDidFailAttempt:(BKPasscodeViewController *)aViewController {
    //	self.failedAttempts++;
    //
    //	if (self.failedAttempts > 5) {
    //
    //		NSTimeInterval timeInterval = 60;
    //
    //		if (self.failedAttempts > 6) {
    //
    //			NSUInteger multiplier = self.failedAttempts - 6;
    //
    //			timeInterval = (5 * 60) * multiplier;
    //
    //			if (timeInterval > 3600 * 24) {
    //				timeInterval = 3600 * 24;
    //			}
    //		}
    //
    //		self.lockUntilDate = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
    //	}
}

//- (NSUInteger)passcodeViewControllerNumberOfFailedAttempts:(BKPasscodeViewController *)aViewController
//{
//	return self.failedAttempts;
//}
//
//- (NSDate *)passcodeViewControllerLockUntilDate:(BKPasscodeViewController *)aViewController
//{
//	return self.lockUntilDate;
//}

- (void)passcodeViewController:(BKPasscodeViewController *)aViewController didFinishWithPasscode:(NSString *)aPasscode {
    switch (aViewController.type) {
        case BKPasscodeViewControllerNewPasscodeType:
        case BKPasscodeViewControllerChangePasscodeType:
            //			self.passcode = aPasscode;
            //			self.failedAttempts = 0;
            //			self.lockUntilDate = nil;
            mGlobalData.privateSetting.simplePassword = aPasscode;
            [mGlobalData.privateSetting saveData];

            break;
        case BKPasscodeViewControllerCheckPasscodeType:
            // 验证密码

            break;
        default:
            break;
    }

    [aViewController dismissViewControllerAnimated:YES completion:^{
        viewController = nil;
        self.didFinishedBlock();
    }];
}


@end
