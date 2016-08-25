//
//  YWGroup.h
//  WXOpenIMSDK
//
//  Created by sidian on 15/12/23.
//  Copyright © 2015年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWGroup : NSObject

@property (nonatomic, strong, readonly) NSNumber *groupId;            //分组id，64位整形
@property (nonatomic, copy)   NSString *groupName;          //分组名称

@end
