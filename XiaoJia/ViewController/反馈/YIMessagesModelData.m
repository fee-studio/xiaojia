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

#import "YIMessagesModelData.h"


/**
 *  This is for demo/testing purposes only.
 *  This object sets up some fake model data.
 *  Do not actually do anything like this.
 */

@implementation YIMessagesModelData

- (instancetype)init {
    self = [super init];
    if (self) {
        self.messages = [NSMutableArray new];

        [self loadMessages];

        /**
         *  Create avatar images once.
         *
         *  Be sure to create your avatars one time and reuse them for good performance.
         *
         *  If you are not using avatars, ignore this.
         */
        UIImage *avatar = kAppPlaceHolderImage; // [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:mGlobalData.userModel.accountModel.avatar]]];
        JSQMessagesAvatarImage *jsqImage = nil;
        if (avatar) {
            jsqImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:avatar
                                                                  diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        } else {
            jsqImage = [JSQMessagesAvatarImageFactory avatarImageWithUserInitials:kJSQDemoAvatarDisplayNameSquires
                                                                  backgroundColor:[UIColor colorWithWhite:0.85f alpha:1.0f]
                                                                        textColor:[UIColor colorWithWhite:0.60f alpha:1.0f]
                                                                             font:[UIFont systemFontOfSize:14.0f]
                                                                         diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
        }

        // VIP: Load app icon from xcassets
        NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
        NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
//        imageView.image = [UIImage imageNamed:icon];
        JSQMessagesAvatarImage *jobsImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:icon]
                                                                                       diameter:kJSQMessagesCollectionViewAvatarSizeDefault];


        self.avatars = @{kJSQDemoAvatarIdSquires : jsqImage,
                kJSQDemoAvatarIdJobs : jobsImage};


        self.users = @{kJSQDemoAvatarIdJobs : kJSQDemoAvatarDisplayNameJobs,
                kJSQDemoAvatarIdSquires : kJSQDemoAvatarDisplayNameSquires};


        /**
         *  Create message bubble images objects.
         *
         *  Be sure to create your bubble images one time and reuse them for good performance.
         *
         */
        JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];

        self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
        self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleGreenColor]];
    }

    return self;
}

- (void)loadMessages {
    NSMutableArray *messages = [[UMFeedback sharedInstance] topicAndReplies];
    NSLog(@"messages = %@", messages);
    for (NSDictionary *msg in messages) {
        NSString *content = msg[@"content"];
        NSDate *createAt = [NSDate dateWithTimeIntervalSince1970:([msg[@"created_at"] longLongValue] / 1000.)];
        BOOL isFailed = [msg[@"is_failed"] boolValue];
        NSString *replyId = msg[@"reply_id"];
        NSString *type = msg[@"type"];
        NSString *picId = msg[@"pic_id"];

        JSQMessage *jsqMsg = nil;

        UIImage *image = [[UMFeedback sharedInstance] imageByID:picId];
        if (picId.isOK) {
            if ([type isEqualToString:@"user_reply"]) {
                JSQPhotoMediaItem *photoItem = [[JSQPhotoMediaItem alloc] initWithImage:image];
                jsqMsg = [JSQMessage messageWithSenderId:kJSQDemoAvatarIdSquires
                                             displayName:kJSQDemoAvatarDisplayNameSquires
                                                   media:photoItem];
            } else {
                JSQPhotoMediaItem *photoItem = [[JSQPhotoMediaItem alloc] initWithImage:image];
                jsqMsg = [JSQMessage messageWithSenderId:kJSQDemoAvatarIdSquires
                                             displayName:kJSQDemoAvatarDisplayNameJobs
                                                   media:photoItem];
            }
        } else {
            if ([type isEqualToString:@"user_reply"]) {
                jsqMsg = [[JSQMessage alloc] initWithSenderId:kJSQDemoAvatarIdSquires
                                            senderDisplayName:kJSQDemoAvatarDisplayNameSquires
                                                         date:createAt
                                                         text:content];
            } else {
                jsqMsg = [[JSQMessage alloc] initWithSenderId:kJSQDemoAvatarIdJobs
                                            senderDisplayName:kJSQDemoAvatarDisplayNameJobs
                                                         date:createAt
                                                         text:content];
            }
        }

        [self.messages addObject:jsqMsg];
    }
}

- (void)addPhotoMediaMessage:(UIImage *)image {
    JSQPhotoMediaItem *photoItem = [[JSQPhotoMediaItem alloc] initWithImage:image];
    JSQMessage *photoMessage = [JSQMessage messageWithSenderId:kJSQDemoAvatarIdSquires
                                                   displayName:kJSQDemoAvatarDisplayNameSquires
                                                         media:photoItem];
    [self.messages addObject:photoMessage];
}

- (void)addLocationMediaMessageCompletion:(JSQLocationMediaItemCompletionBlock)completion {
    CLLocation *ferryBuildingInSF = [[CLLocation alloc] initWithLatitude:37.795313 longitude:-122.393757];

    JSQLocationMediaItem *locationItem = [[JSQLocationMediaItem alloc] init];
    [locationItem setLocation:ferryBuildingInSF withCompletionHandler:completion];

    JSQMessage *locationMessage = [JSQMessage messageWithSenderId:kJSQDemoAvatarIdSquires
                                                      displayName:kJSQDemoAvatarDisplayNameSquires
                                                            media:locationItem];
    [self.messages addObject:locationMessage];
}

- (void)addVideoMediaMessage {
    // don't have a real video, just pretending
    NSURL *videoURL = [NSURL URLWithString:@"file://"];

    JSQVideoMediaItem *videoItem = [[JSQVideoMediaItem alloc] initWithFileURL:videoURL isReadyToPlay:YES];
    JSQMessage *videoMessage = [JSQMessage messageWithSenderId:kJSQDemoAvatarIdSquires
                                                   displayName:kJSQDemoAvatarDisplayNameSquires
                                                         media:videoItem];
    [self.messages addObject:videoMessage];
}

@end
