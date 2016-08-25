//
//  VSVideoCore.h
//  VSVideoCore
//
//  Created by weixing.jwx on 16/2/3.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for VSVideoCore.
FOUNDATION_EXPORT double VSVideoCoreVersionNumber;

//! Project version string for VSVideoCore.
FOUNDATION_EXPORT const unsigned char VSVideoCoreVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <VSVideoCore/PublicHeader.h>

#import "VSVideoConfiguration.h"
#import "VSAudioConfiguration.h"
#import "VSMediaTypeConfiguration.h"


//滤镜
#import "VSFilter.h"
#import "VSFilter+VideoComposition.h"
#import "VSFilterAnimation.h"
#import "VSFilterImageView.h"
#import "VSImageView.h"
#import "VSSwipeableFilterView.h"
#import "VSEAGLImageView.h"
#import "VSFilter+UIImage.h"

#import "VSPlayer.h"
#import "VSVideoPlayerView.h"

#import "VSRecorder.h"
#import "VSRecorderDelegate.h"
#import "VSRecordSession.h"
#import "VSRecordSessionSegment.h"
#import "VSRecordSessionManager.h"


#import "NSURL+VSSaveToCameraRoll.h"
#import "UIImage+VSSaveToCameraRoll.h"
#import "VSAssetExportSession.h"
#import "VSContext.h"
#import "VSIOPixelBuffers.h"
#import "VSRecorderTools.h"
#import "VSSampleBufferHolder.h"
#import "VSPixelBufferHolder.h"
#import "VSSaveToCameraRollOperation.h"
#import "VSWeakSelectorTarget.h"

#import "VSRecorderFocusTargetView.h"

//mtl_datetime flag:20160310 1537
