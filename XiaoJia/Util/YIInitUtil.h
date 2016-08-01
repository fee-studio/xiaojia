//
//  YIInitUtil.h
//  YIBox
//
//  Created by efeng on 16/3/7.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YIInitUtil : NSObject


+ (YIInitUtil *)instance;

+ (void)loadBaseInit;

+ (void)registerAPNS;


@end
