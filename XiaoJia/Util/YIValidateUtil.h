//
//  YIValidateUtil.h
//  Dobby
//
//  Created by efeng on 15/7/5.
//  Copyright (c) 2015年 weiboyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YIValidateUtil : NSObject

+ (BOOL)validateEmail:(NSString *)email;

+ (BOOL)validatePhone:(NSString *)phone;

@end
