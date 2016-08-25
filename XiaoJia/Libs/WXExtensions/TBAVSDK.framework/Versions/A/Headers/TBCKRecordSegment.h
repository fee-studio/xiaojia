//
//  TBCKRecordSegment.h
//  TBAVSDK
//
//  Created by 兵长 on 16/2/18.
//  Copyright © 2016年 Taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 视频录制的片段
 */
@interface TBCKRecordSegment : NSObject

//录制的视频片段url
@property (nonatomic, strong) NSURL *url;

//视频的第一张图片
@property (nonatomic, readonly) UIImage *firstImage;

@end
