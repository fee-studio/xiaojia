//
//  NSString+HW.h
//  StringDemo
//
//  Created by 何 振东 on 12-10-11.
//  Copyright (c) 2012年 wsk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)

/**
 *  计算字符串的字数。
 *  @param  string:输入字符串。
 *  return  返回输入字符串的字数。
 */
- (int)wordsCount;

- (NSString *)URLEncodedString2;

- (NSString *)URLDecodedString;

- (NSString *)URLEncodedString;

- (NSString *)encodeStringWithUTF8;

- (NSUInteger)byteLengthWithEncoding:(NSStringEncoding)encoding;

- (BOOL)isValidURL2;

- (BOOL)isValidURL;

- (BOOL)isValidURL3;

+ (NSString *)stringCSVFromArray:(NSArray *)stringArray;

- (BOOL)isReality;

/**
 *  原理是根据字体与字符串长度来计算长度与宽度
 *  http://www.cocoachina.com/industry/20140604/8668.html
 *
 *  size 最大值
 */
- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font;

/**
 *  create a json string from NSArray
 *
 *  @param array 来源array
 *
 *  @return 一个json string
 */
+ (NSString *)jsonStringFromArray:(NSArray *)array;

- (NSString *)md5;

- (BOOL)isEmpty;

- (BOOL)isOK;
@end
