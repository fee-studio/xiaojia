//
//  WXOPTMixBubbleViewModel.h
//  Messenger
//
//  Created by 慕桥(黄玉坤) on 12/2/14.
//
//

#import <Foundation/Foundation.h>
#import "YWBaseBubbleViewModel.h"
#import "PTMixRegionBox.h"

typedef enum : NSUInteger {
    PTMixType_H = 1,
    PTMixType_V,
    PTMixType_Flow,
} PTMixType;

@interface WXOPTMixBubbleViewModel : YWBaseBubbleViewModel
@property (nonatomic, strong) NSArray *cellItems;
@property (nonatomic, strong) PTMixHead *headItem;
@property (nonatomic, assign) PTMixType mixType;

typedef void (^PTMActionProcessBlock) (NSString *action);
@property (nonatomic, copy) PTMActionProcessBlock actionProcessBlock;
- (void)setActionProcessBlock:(PTMActionProcessBlock)actionProcessBlock;
@end
