//
// Created by efeng on 16/9/3.
// Copyright (c) 2016 buerguo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YIRealmUtil : NSObject

+ (YIRealmUtil *)instance;
- (void)initRealm;

- (void)buildDefaultData;
@end