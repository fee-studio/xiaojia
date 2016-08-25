//
//  TBCKPlayer.h
//  TBAVSDK
//
//  Created by 兵长 on 16/2/19.
//  Copyright © 2016年 Taobao. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "VSVideoCore/VSVideoCore.h"
#import "TBCKFilterImageView.h"


@class TBCKPlayer;

@protocol TBCKPlayerDelegate <VSPlayerDelegate>

@end

/*
继承至AVPlayer，支持滤镜效果的播放器。
 */
@interface TBCKPlayer : VSPlayer
//播放时需要增加的滤镜处理层
@property (nonatomic, strong) TBCKFilterImageView *filterView;

@end
