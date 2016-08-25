//
//  TBAVVideoProtocol.h
//  TBCameraKit
//
//  Created by ZhuBicheng on 15/12/9.
//  Copyright © 2015年 Taobao. All rights reserved.
//

#ifndef TBAVVideoProtocol_h
#define TBAVVideoProtocol_h
@class TBAVVideoView;

@protocol TBAVVideoProtocol <NSObject>

- (void)videoViewDidStartPlayVideo:(TBAVVideoView *)videoView;

@optional

- (void)videoViewDidEndPlayVideo:(TBAVVideoView *)videoView;

@end

#endif /* TBAVVideoProtocol_h */
