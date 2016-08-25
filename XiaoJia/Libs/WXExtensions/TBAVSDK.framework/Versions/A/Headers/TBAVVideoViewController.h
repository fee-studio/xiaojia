//
//  TBAVVideoViewController.h
//  TBCameraKit
//
//  Created by ZhuBicheng on 15/11/25.
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBAVVideoViewController : UIViewController

- (instancetype)initWithVideoPath:(NSURL *)url;

- (instancetype)initWithVideoPathString:(NSString *)pathString;

@end
