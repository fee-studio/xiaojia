//
//  IYWExtensionForShortVideoService.h
//  YWExtensionForShortVideo
//
//  Created by sidian on 16/5/23.
//  Copyright © 2016年 SiDian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YWInputViewPlugin;
@protocol YWInputViewPluginProtocol;

typedef void(^YWInputViewPluginShortVideoBlock)(id<YWInputViewPluginProtocol> plugin, NSURL *fileUrl, UIImage *frontImage, NSUInteger width, NSUInteger height, NSUInteger duration);


@protocol IYWExtensionForShortVideoService <NSObject>

- (YWInputViewPlugin *)getShortVideoPluginWithPickerOverBlock:(YWInputViewPluginShortVideoBlock)didPickBlock;

@end
