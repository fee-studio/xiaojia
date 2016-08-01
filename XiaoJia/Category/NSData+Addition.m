//
//  NSData+Addition.m
//  Line0
//
//  Created by line0 on 12-12-5.
//  Copyright (c) 2012年 line0. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

@implementation NSData (Addition)

- (NSData *)dataWithObject:(id)object {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    return data;
}

- (id)convertDataToObject {
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:self];
    return array;
}

/**
 * Returns hexadecimal string of NSData. 
 * Empty string if data is empty.   
 */
- (NSString *)hexadecimalString {
    const unsigned char *dataBuffer = (const unsigned char *) [self bytes];

    if (!dataBuffer)
        return [NSString string];

    NSUInteger dataLength = [self length];
    NSMutableString *hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];

    for (int i = 0; i < dataLength; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long) dataBuffer[i]]];

    return [NSString stringWithString:hexString];
}

- (NSString *)md5 {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (int) self.length, result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
    ];
}

@end
