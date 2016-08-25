//
//  TBEmbededVideoView.h
//  TBCameraKit
//
//  Created by ZhuBicheng on 15/12/9.
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import "TBAVVideoView.h"

@interface TBEmbededVideoView : TBAVVideoView

@property (nonatomic, weak) id<TBAVVideoProtocol> delegate;

- (instancetype)initWithFrame:(CGRect)frame videoURLString:(NSString *)urlString;

- (instancetype)initWithFrame:(CGRect)frame videoURL:(NSURL *)url;

- (void)play;

- (void)pause;

- (void)setMute:(BOOL)mute;

@end
