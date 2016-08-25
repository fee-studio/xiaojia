//
//  TBAVVideoView.h
//  TBCameraKit
//
//  Created by ZhuBicheng on 15/11/25.
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "TBAVVideoProtocol.h"

//@import AVFoundation;

@interface TBAVVideoView : UIView

@property (nonatomic, strong) NSURL *videoPath;

@property (nonatomic, assign) BOOL isMute;

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) NSString *videoGravity;

@property (nonatomic, weak) id<TBAVVideoProtocol> delegate;

- (void)play;

- (void)pause;

@end
