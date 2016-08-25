//
//  WXODegreeBubbleViewModel.h
//  Messenger
//
//  Created by 慕桥(黄玉坤) on 12/8/14.
//
//

#import "YWBaseBubbleViewModel.h"

typedef enum : NSUInteger {
    DB_DegradeType_Text = 0,         // 展示degradeText
    DB_DegradeType_Action,           // 展示degradeText+升级文本+响应升级操作
    DB_DegradeType_Ignore,
} DB_DegradeType;

@interface WXODegradeBubbleViewModel : YWBaseBubbleViewModel
@property (nonatomic, assign) DB_DegradeType degradeType;
@property (nonatomic, strong) NSString *degradeText;
@property (nonatomic, strong) NSString *degreeTitle;

typedef void (^WXODegrateBubbleAsk4Upgrade) ();
@property (nonatomic,   copy) WXODegrateBubbleAsk4Upgrade upgradeBlock;
- (void)setUpgradeBlock:(WXODegrateBubbleAsk4Upgrade)upgradeBlock;

@end
