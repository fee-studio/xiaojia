//
//  YIConfigUtil+Business.h
//  Dobby
//
//  Created by efeng on 14-10-15.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//
//  业务相关的配置


#import "YIConfigUtil.h"

@interface YIConfigUtil (Business)

+ (void)toOpenWxScan;

+ (void)toOpenUrl:(NSString *)url;
@end
