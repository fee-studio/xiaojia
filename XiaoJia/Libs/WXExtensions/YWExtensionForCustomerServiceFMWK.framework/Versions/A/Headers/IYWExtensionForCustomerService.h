//
//  IWXOpenIMExtensionForUserTrack.h
//  WXOpenIMExtensionForCustomerService
//
//  Created by sidian on 15/9/30.
//  Copyright © 2015年 SiDian. All rights reserved.
//

@class YWPerson;

typedef void (^YWCSUpdateCompletionBlock)(NSError *error, NSDictionary *resultDict);

/// 这个协议是开发者用来向云旺服务器更新轨迹，打点数据上传后可以在应用的管理界面查看
@protocol IYWExtensionForCustomerService <NSObject>

/* 
 * 所有的轨迹都需要指定一个person对象，如果不指定，将会使用YWSDKTypeFree类型的YWIMCore登录成功之后获取的person对象
 * 建议在application:didFinishLaunchingWithOptions:中执行。
 */
- (void)setYWCSPerson:(YWPerson *)person;

/* 
 * 更新用户信息，参考http://baichuan.taobao.com/doc2/detail?spm=0.0.0.0.aEXBLc&treeId=41&articleId=103769&docType=1#s1
 * @param uiParam，KV字符串，千牛插件会展现此类KV集合
 * @param extraParam, 开发者可以使用自定义param字段，OpenIM不做数据的展现，只是打通数据从C端传递到B端获取的通道，开发者可以使用该字段完成业务参数的传递
 * @param completionBlock, 回调
 */
- (void)updateExtraInfoWithExtraUI:(NSString *)uiParam andExtraParam:(NSString *)extraParam withCompletionBlock:(YWCSUpdateCompletionBlock)completionBlock;

@end

/* IWXOpenIMExtensionForUserTrack_h */
