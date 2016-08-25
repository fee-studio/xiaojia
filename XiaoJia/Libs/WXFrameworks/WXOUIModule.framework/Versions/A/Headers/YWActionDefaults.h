//
//  YWPerson+Action.h
//  WXOpenIMUIKit
//
//  Created by huanglei on 4/30/15.
//  Copyright (c) 2015 www.alibaba.com. All rights reserved.
//

#import <WXOpenIMSDKFMWK/YWPerson.h>


/**
 *  这个头文件中包含了很多YWAction使用的定义
 *  例如Person对象的JSON字符串定义
 *  例如云旺内置的Action
 */


/// 在Action中往往要传递Person对象，因为我们的Action可能是通过网络下发，所以所有的参数都必须是字符串形式，我们用如下的JSON字符串表示Person对象
/// {"appkey": "23015524", "personId": "uid1"}
#define YWActionPersonAppkey    @"appkey"
#define YWActionPersonPersonId  @"personId"


#pragma mark - 云旺内置Action

/// 打开H5页面，如果你使用IMKit，则默认实现了这个Handler。如果您使用IMCore，则需要自己注册Handler
#define YWActionDefaultOpenH5OpenIM                 @"wangwang://h5/open"

/// 所要打开的url参数
#define YWActionDefaultOpenH5PageUrl    @"url"


/// 发送单聊文本消息
#define YWActionDefaultP2PText                      @"wangwang://p2pconversation/sendText"
/// 发送单聊文本消息的参数封装在params中
#define YWActionDefaultP2PTextParam         @"params"
/// 消息接收者，Person由上面的Person JSON字符串表示
#define YWActionDefaultP2PTextParamPerson    @"person"
/// 消息文本
#define YWActionDefaultP2PTextParamText     @"text"


/// h5页面需要免登
#define YWActionDefaultAutoLoginForH5               @"wangwang://h5/autologin"


@interface YWPerson (Action)

- (instancetype)initWithActionDictionary:(NSDictionary *)aDictionary;

@end
