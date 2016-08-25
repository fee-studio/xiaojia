//
//  YWEmoticonGroupLoader.h
//  WXOpenIMUIKit
//
//  Created by 慕桥(黄玉坤) on 15/6/8.
//  Copyright (c) 2015年 www.alibaba.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWEmoticonGroupLoader : NSObject

/// @brief 合并自动路径EMO文件表情，不允许表情同名分组
/// @param filePath 后缀为.emo的表情包文件路径
/// @return 返回EMO文件内表情分组
+ (NSArray *)emoticonGroupsWithEMOFilePath:(NSString *)filePath;

@end
