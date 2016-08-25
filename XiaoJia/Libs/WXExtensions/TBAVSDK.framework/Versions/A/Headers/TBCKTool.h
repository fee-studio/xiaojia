//
//  TBCKTool.h
//  TBCameraKit
//
//  Created by 辰染 on 15/10/10.
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBCKTool : NSObject

+ (NSURL *)tempFileURLWithExtension:(NSString *)extension;

+ (NSString *)tempFilePathWithExtension:(NSString *)extension;

+ (NSString *)tempDirPath;

@end
