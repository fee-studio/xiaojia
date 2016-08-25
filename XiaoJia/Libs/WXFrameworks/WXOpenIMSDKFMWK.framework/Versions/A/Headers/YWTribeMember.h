//
//  YWTribeMember.h
//  
//
//  Created by Jai Chen on 15/1/19.
//  Copyright (c) 2015年 taobao. All rights reserved.
//

#import "YWPerson.h"

/**
 群成员角色类型
 */
typedef NS_ENUM(NSUInteger, YWTribeMemberRole) {
   
    /// 群主
    YWTribeMemberRoleOwner = 1,
    /// 群管理员
    YWTribeMemberRoleManager =2,
    /// 普通群成员
    YWTribeMemberRoleNormal =3
};


/**
 *  群成员对象
 */
@interface YWTribeMember : YWPerson

/**
 *  群成员角色类型
 */
@property (assign, nonatomic) YWTribeMemberRole role;

/**
 *  群成员在群中的昵称
 */
@property (copy, nonatomic) NSString *nickname;

@end
