//
//  YIConfigUtil+Business.m
//  Dobby
//
//  Created by efeng on 14-10-15.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//


@implementation YIConfigUtil (Business)


+ (void)toOpenWxScan {
    NSString *pqyUrlScheme = @"weixin://dl/scan";
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:pqyUrlScheme]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:pqyUrlScheme]];
    }
}

+ (void)toOpenUrl:(NSString *)url {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}


@end
