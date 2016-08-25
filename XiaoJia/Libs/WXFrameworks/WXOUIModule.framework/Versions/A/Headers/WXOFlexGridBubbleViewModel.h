//
//  FlexGridBubbleViewModel.h
//  Messenger
//
//  Created by 慕桥(黄玉坤) on 3/6/15.
//
//

#import "YWBaseBubbleViewModel.h"
#import "FGBodyParser.h"

@interface WXOFlexGridBubbleViewModel : YWBaseBubbleViewModel
@property (nonatomic, strong) FGBodyParser *parser;

typedef void (^FGBActionProcessBlock) (NSString *action);
@property (nonatomic, copy) FGBActionProcessBlock actionProcessBlock;
- (void)setActionProcessBlock:(FGBActionProcessBlock)actionProcessBlock;
@end
