//
//  NSArray+Addition.m
//  Dobby
//
//  Created by efeng on 14/12/9.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

#import "NSArray+Addition.h"

@implementation NSArray (Addition)

- (NSString *)json {
    NSString *json = nil;
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    return (error ? nil : json);
}


@end
