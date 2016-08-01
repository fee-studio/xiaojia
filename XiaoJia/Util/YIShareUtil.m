//
//  YIShareUtil.m
//  YIBox
//
//  Created by efeng on 2/20/16.
//  Copyright © 2016 buerguo. All rights reserved.
//

#import "YIShareUtil.h"

static NSString *const WEIXIN_APPID = @"wx476f226515637245";


@implementation YIShareUtil

+ (BOOL)toWxShare:(enum WXScene)scene
            title:(NSString *)title
      description:(NSString *)desc
       thumbImage:(UIImage *)thumbImage
       webpageUrl:(NSString *)webpageUrl {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = desc;
    [message setThumbImage:[thumbImage image32k]];

    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = webpageUrl;
    message.mediaObject = ext;
    message.mediaTagName = @"XIAOJIA_WEBPAGE";

    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    return [WXApi sendReq:req];
}

+ (void)toWxShareAppPromotionPage {
    [WXApi registerApp:WEIXIN_APPID];
    [self toWxShare:WXSceneTimeline
              title:@"小加, 一个小而美的手机助手!"
        description:@""
         thumbImage:[YICommonUtil appIconImage]
         webpageUrl:@"http://www.buerguo.com"];
}

+ (BOOL)toWxShare:(enum WXScene)scene
             text:(NSString *)text {
    [WXApi registerApp:WEIXIN_APPID];

    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
    req.text = @"分享文字的地方在这里了。";
    req.scene = scene;
    return [WXApi sendReq:req];
}

+ (BOOL)toWxShare:(enum WXScene)scene
           images:(NSArray *)images {
    [WXApi registerApp:WEIXIN_APPID];

    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@"placeholder"]];


    WXImageObject *imageObject = [WXImageObject object];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"icon_120" ofType:@"png"];
    imageObject.imageData = [NSData dataWithContentsOfFile:filePath];

    message.mediaObject = imageObject;


    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.scene = scene;
    req.message = message;
    BOOL success = [WXApi sendReq:req];
    return success;
}

@end
