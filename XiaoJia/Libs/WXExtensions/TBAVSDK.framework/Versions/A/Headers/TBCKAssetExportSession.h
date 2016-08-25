//
//  TBCKAssetExportSession.h
//  TBAVSDK
//
//  Created by 兵长 on 16/2/25.
//  Copyright © 2016年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "TBCKFilter.h"
#import "TBCKFilterImageView.h"

/*
 视频导出类
 */
@interface TBCKAssetExportSession : NSObject

//输入源.输入的尺寸和bitrate，均与输入源一致
@property (nonatomic, strong) AVAsset * inputAsset;

//输出路径
@property (nonatomic, strong) NSURL * outputUrl;

//输出的文件格式
@property (nonatomic, strong) NSString * outputFileType;

//输出的滤镜效果
@property (nonatomic, strong) TBCKFilterImageView *imageView;

//输出时增加的水印效果。注意overlayView.frame的单位为视频分辨率，而不是UI逻辑尺寸
@property (nonatomic, strong) UIView *overlayView;

//处理过程中的错误信息
@property (nonatomic, readonly) NSError * error;

//输出的视频时间范围
@property (nonatomic, assign) CMTimeRange timeRange;

//执行导出
- (void)exportAsynchronouslyWithCompletionHandler:(void(^)())handler;

@end
