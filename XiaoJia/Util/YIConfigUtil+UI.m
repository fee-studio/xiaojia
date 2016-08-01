//
//  YIConfigUtil+UI.m
//  Dobby
//
//  Created by efeng on 15/6/23.
//  Copyright (c) 2015年 weiboyi. All rights reserved.
//

@implementation YIConfigUtil (UI)


+ (NSString *)priceStringWithSign:(NSString *)priceValue; {
    if (priceValue.isOK) {
        return [NSString stringWithFormat:@"￥%@", priceValue];
    } else {
        return [NSString stringWithFormat:@"￥%@", @"0.00"];
    }
}

@end
