//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//


// Import all the things
#import "JSQMessages.h"

#import "YIMessagesModelData.h"
#import "NSUserDefaults+DemoSettings.h"


@class YIMessagesViewController;

@protocol JSQDemoViewControllerDelegate <NSObject>

- (void)didDismissJSQDemoViewController:(YIMessagesViewController *)vc;

@end


@interface YIMessagesViewController : JSQMessagesViewController <UIActionSheetDelegate, UMFeedbackDataDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(weak, nonatomic) id <JSQDemoViewControllerDelegate> delegateModal;

@property(strong, nonatomic) YIMessagesModelData *demoData;

- (void)receiveMessagePressed:(NSString *)message delayTime:(float)delayTime;

- (void)closePressed:(UIBarButtonItem *)sender;

@end
