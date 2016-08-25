//
//  YWPhotoPickerHelper.h
//  WXOpenIMUIKit
//
//  Created by huanglei on 16/4/5.
//  Copyright © 2016年 www.alibaba.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YWIMKit;

typedef NS_ENUM(NSUInteger, YWPhotoPickerType) {
    YWPhotoPickerTypeTakePhoto, /// 拍照
    YWPhotoPickerTypeSingle, /// 相册单选
    YWPhotoPickerTypeMultiEnableOriginalCheck, /// 相册多选，显示原图选项
//    YWPhotoPickerTypeMultiDisableOriginal, /// 相册多选，隐藏原图选项
};


typedef void(^YWPhotoPickerResultBlock)(NSDictionary *aUserInfo);

/// 所选中的图片数据组成的NSArray
FOUNDATION_EXTERN NSString *const YWPhotoPickerResultKeySelectedImageDatasArray;

/// 用户勾选了发送原图
FOUNDATION_EXTERN NSString *const YWPhotoPickerResultKeyOriginalChecked;


/**
 *  开放接口，用于选择图片；
 *  支持单选，多选，拍照
 */

@interface YWPhotoPickerHelper : NSObject

- (instancetype)initWithYWIMKit:(YWIMKit *)aIMKit;

@property (nonatomic, assign) YWPhotoPickerType photoPickerType;

@property (nonatomic, copy) YWPhotoPickerResultBlock photoPickerResultBlock;

- (void)setPhotoPickerResultBlock:(YWPhotoPickerResultBlock)photoPickerResultBlock;

- (void)presentFromController:(UIViewController *)aController;

@end
