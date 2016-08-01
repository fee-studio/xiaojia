//
// Created by efeng on 15/9/5.
// Copyright (c) 2015 buerguo. All rights reserved.
//


@implementation NSString (YI)

- (BOOL)isOK {
    if (self
            && ![[self stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]]
            isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}


@end