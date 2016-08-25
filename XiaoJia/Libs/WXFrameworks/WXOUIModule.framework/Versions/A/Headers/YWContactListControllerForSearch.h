//
//  YWContactListControllerForSearch.h
//  WXOpenIMUIKit
//
//  Created by huanglei on 15/7/24.
//  Copyright (c) 2015年 www.alibaba.com. All rights reserved.
//

#import "YWBaseContactListController.h"

@interface YWContactListControllerForSearch : YWBaseContactListController

- (id)initWithIMKit:(YWIMKit *)aIMKit;

- (void)changeKeyword:(NSString *)aKeyword;

@end
