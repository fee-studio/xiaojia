//
//  TBCKFilterImageView.h
//  TBAVSDK
//
//  Created by 兵长 on 16/2/25.
//  Copyright © 2016年 Taobao. All rights reserved.
//

#import "VSVideoCore/VSVideoCore.h"
#import "TBCKFilter.h"

/*
 用于给播放器添加滤镜层
 */
@interface TBCKFilterImageView : VSEAGLImageView

//处理滤镜对象
@property (nonatomic, strong) TBCKFilter *videoFilter;

//初始化滤镜层
- (id)initWithFrame:(CGRect)frame;

@end
