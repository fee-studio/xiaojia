
//
//  IYWUtilService4MandarinLatin.h
//  WXOpenIMSDK
//
//  Created by Jai Chen on 16/1/15.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IYWUtilService4MandarinLatin <NSObject>

/**
 *  将字符串转换为支持拼音搜索的字符串
 *
 *  @param string 待转换的字符串
 *
 *  @return  如输入为"角色"时的输出：
 *    "jiaose\tjs\n"
 *    "juese\tjs\n"
 *    "jiaoshai\tjs\n"
 *    "jueshai\tjs\n"
 */
- (NSString *)transformStringForLatinSearchingFromString:(NSString *)string;

@end
