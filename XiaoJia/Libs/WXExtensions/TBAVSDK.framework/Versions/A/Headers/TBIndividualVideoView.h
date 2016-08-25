//
//  TBIndividualVideoView.h
//  TBCameraKit
//
//  Created by ZhuBicheng on 15/12/9.
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import "TBAVVideoView.h"

@interface TBIndividualVideoView : TBAVVideoView

@property (nonatomic, weak) id<TBAVVideoProtocol> delegate;

- (instancetype)initWithFrame:(CGRect)frame videoURLString:(NSString *)urlString;

- (instancetype)initWithFrame:(CGRect)frame videoURL:(NSURL *)url;

- (void)play;

- (void)pause;

- (void)replay;

@end
