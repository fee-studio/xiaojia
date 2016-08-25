//
//  VSFilterImageView.h
//  VideoStudio
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import "VSImageView.h"
#import "VSFilter.h"

@interface VSFilterImageView : VSImageView

/**
 The filter to apply when rendering. If nil is set, no filter will be applied
 */
@property (strong, nonatomic) VSFilter *__nullable filter;

@end
