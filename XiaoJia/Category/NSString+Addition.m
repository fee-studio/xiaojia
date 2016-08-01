//
//  NSString+HW.m
//  StringDemo
//
//  Created by 何 振东 on 12-10-11.
//  Copyright (c) 2012年 wsk. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Addition)

- (int)wordsCount {
    int i, n = [self length], l = 0, a = 0, b = 0;
    unichar c;
    for (i = 0; i < n; i++) {
        c = [self characterAtIndex:i];
        if (isblank(c)) {
            b++;
        } else if (isascii(c)) {
            a++;
        } else {
            l++;
        }
    }
    if (a == 0 && l == 0) return 0;
    return l + (int) ceilf((float) (a + b) / 2.0);
}

- (NSString *)URLEncodedString2 {

    CFStringRef encodedString = CFURLCreateStringByAddingPercentEscapes(
            kCFAllocatorDefault,
            (CFStringRef) self,
            NULL,
            CFSTR(":/?#[]@!$&'()*+,;="),
            kCFStringEncodingUTF8);
    return (NSString *) CFBridgingRelease(encodedString);
}

- (NSString *)URLEncodedString {
    NSString *result = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
            (CFStringRef) self,
            NULL,
            CFSTR("!*'();:@&=+$,/?%#[]"),
            kCFStringEncodingUTF8));
    return result;
}

- (NSString *)URLDecodedString {
    NSString *result = (NSString *) CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
            (CFStringRef) self,
            CFSTR(""),
            kCFStringEncodingUTF8));
    return result;
}

- (NSString *)encodeStringWithUTF8 {
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    const char *c = [self cStringUsingEncoding:encoding];
    NSString *str = [NSString stringWithCString:c encoding:NSUTF8StringEncoding];

    return str;
}

- (NSUInteger)byteLengthWithEncoding:(NSStringEncoding)encoding {
    if (!self) {
        return 0;
    }

    const char *byte = [self cStringUsingEncoding:encoding];
    return strlen(byte);
}

- (BOOL)isValidURL2 {
    BOOL isValidURL = NO;
    NSURL *candidateURL = [NSURL URLWithString:[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (candidateURL && candidateURL.scheme && candidateURL.host)
        isValidURL = YES;
    return isValidURL;
}

/**
 *  经过单元测试，不是所有的网址都能通过测试
 *
 *  @return
 */
- (BOOL)isValidURL {
    NSString *urlRegEx =
            @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlPredic = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlPredic evaluateWithObject:self];
}

- (BOOL)isValidURL3 {

    if ([[self lowercaseString] hasPrefix:@"http://"] || [[self lowercaseString] hasPrefix:@"https://"]) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  把 装有String的Array转化成@"xxx,yyy,zzz"这种形式的样子.
 *
 *  @param stringArray 装有String的Array
 *
 *  @return @"xxx,yyy,zzz"样式的字符串
 */
+ (NSString *)stringCSVFromArray:(NSArray *)stringArray {

    NSMutableString *tmpString = [NSMutableString string];
    @try {
        for (int i = 0; i < stringArray.count; i++) {

            id stringObject = stringArray[i];
            if ([stringObject isKindOfClass:[NSNumber class]]) {
                stringObject = [stringObject stringValue];
            }

            [tmpString appendString:stringObject];
            if (i != stringArray.count - 1) {
                [tmpString appendString:@","];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"NSString(Addition) +stringCSVFromArray: - Exception: %@", exception);
    }
    @finally {

    }

    return tmpString;
}

- (BOOL)isReality; {

    if (self == nil) {
        return NO;
    }

    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        return NO;
    }

    return YES;
}

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font {
    CGSize expectedLabelSize = CGSizeZero;

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName : font, NSParagraphStyleAttributeName : paragraphStyle.copy};

        expectedLabelSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }
    else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        expectedLabelSize = [self sizeWithFont:font
                             constrainedToSize:size
                                 lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
    }

    return CGSizeMake(ceil(expectedLabelSize.width), ceil(expectedLabelSize.height));
}

+ (NSString *)jsonStringFromArray:(NSArray *)array {

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (int) strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
    ];
}

- (BOOL)isEmpty {
    return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""];
}

- (BOOL)isOK {
    if (self && ![[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}

@end
