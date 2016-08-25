//
//  EmoticonFactory.h
//  Messenger
//
//  Created by zhiguan.ll on 11-12-7.
//  Copyright (c) 2011年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GifImage;

@interface YWEmoticon : NSObject

@property (nonatomic, strong) NSString * emoticon;
@property (nonatomic, strong) NSString * fileName;
@property (nonatomic, strong) NSString * comments;

@end


typedef enum YWEmoticon_type
{
    /// 静态表情
    YWEmoticonTypeStaticImage = 0,

    /// Gif表情
    YWEmoticonTypeGifAnimateImage,
    
    /// 目前暂不支持以下类型
    /// 系统表情
    YWEmoticonTypeSymblEmoticon,
    /// 自定义表情
    YWEmoticonTyperUserCustom,
    
    YWEmoticonTypeCount
}YWEmoticonType;

@interface YWEmoticonFactory : NSObject
+ (YWEmoticonFactory *)sharedInstance;
- (NSArray*)shareEmoticonsInfoWithType:(YWEmoticonType)type;
- (NSArray*)shareEmoticonsSymbolsWithType:(YWEmoticonType)type;
- (NSMutableDictionary *)shareEmoticonImagesWithType:(YWEmoticonType)type;
+ (YWEmoticon *)getEmoticonInfoByEmoticon:(NSString *)emoticon WithType:(YWEmoticonType)type;
+ (UIImage *)getEmoticonImage:(NSString *)emoticonFileName WithType:(YWEmoticonType)type; // emoticonFileName不带扩展名
+ (GifImage*)getAnimateEmoticonImage:(NSString *)emoticonFileName; // emoticonFileName不带扩展名，只支持EmoticonTypeGifAnimateImage类型

+ (void) matchEmoticons:(NSString *)content result:(NSMutableDictionary *)resDic;

//重置表情(切换环境时调用)
- (void) resetEmoticons;

/**
 *  匹配表情符号的正则表达式
 */
@property (nonatomic, retain) NSRegularExpression *sharedEmoticonSymbolsRegex;

@end
