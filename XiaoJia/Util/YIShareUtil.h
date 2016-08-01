//
//  YIShareUtil.h
//  YIBox
//
//  Created by efeng on 2/20/16.
//  Copyright © 2016 buerguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"


@interface YIShareUtil : NSObject

// 微信分享
+ (BOOL)toWxShare:(enum WXScene)scene
            title:(NSString *)title
      description:(NSString *)desc
       thumbImage:(UIImage *)thumbImage
       webpageUrl:(NSString *)webpageUrl;

// 分享App推广页
+ (void)toWxShareAppPromotionPage;

+ (BOOL)toWxShare:(enum WXScene)scene
             text:(NSString *)text;

+ (BOOL)toWxShare:(enum WXScene)scene
           images:(NSArray *)images;
@end
