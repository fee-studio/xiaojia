//
//  IWXOUIService.h
//  WXOpenIMSDK
//
//  Created by huanglei on 14/12/16.
//  Copyright (c) 2014年 taobao. All rights reserved.
//





/*********************************************************************************
 *********************************************************************************
 *********************************************************************************
 *********************************************************************************
 
 * 注意点：所有WXO或者IWXO开头命名的类、接口、类型、常量等都已废弃，请使用YW或者IYW开头的定义 *
 
 *********************************************************************************
 *********************************************************************************
 *********************************************************************************
 *********************************************************************************
 ********************************************************************************/






#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "IYWUIService.h"

@class WXOPerson;


#define WXOpenIMNewMessageTypeText      YWIMKitNewMessageTypeText
#define WXOpenIMNewMessageTypeVoice     YWIMKitNewMessageTypeVoice
#define WXOpenIMNewMessageTypeImage     YWIMKitNewMessageTypeImage
#define WXOpenIMNewMessageTypeOther     YWIMKitNewMessageTypeOther


#define WXOUIServiceErrorDomain         YWUIServiceErrorDomain
#define WXOUIServiceErrorDescriptionKey YWUIServiceErrorDescriptionKey

#define WXOOpenURLBlock                 YWOpenURLBlock
#define WXOUnreadCountChangedBlock      YWUnreadCountChangedBlock
#define WXOOnNewMessageBlock            YWOnNewMessageBlock




__deprecated_msg("请使用IYWUIService替代") @protocol IWXOUIService <NSObject, IYWUIService>


/// 以下接口都是为了保持兼容性

typedef void(^WXOFetchProfileCompletionBlock)(BOOL aIsSuccess, WXOPerson *aPerson, NSString *aDisplayName, UIImage *aAvatarImage);

typedef void(^WXOFetchProfileBlock)(WXOPerson *aPerson, WXOFetchProfileCompletionBlock aCompletionBlock);

- (void)setFetchProfileBlock:(WXOFetchProfileBlock)fetchProfileBlock;

typedef void(^WXOOpenProfileBlock)(WXOPerson *aPerson, UIViewController *aParentController);

- (void)setOpenProfileBlock:(WXOOpenProfileBlock)openProfileBlock;


@end


