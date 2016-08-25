//
//  LocationBubbleViewModel.h
//  Messenger
//
//  Created by 慕桥(黄玉坤) on 12/1/14.
//
//

#import <Foundation/Foundation.h>
#import "YWBaseBubbleViewModel.h"

@interface WXOLocationBubbleViewModel : YWBaseBubbleViewModel
@property (nonatomic, strong) NSString *positionName;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;

typedef void (^WXOLocationBubbleAsk4ViewMap) ();
@property (nonatomic,   copy) WXOLocationBubbleAsk4ViewMap viewMapBlock;
- (void)setViewMapBlock:(WXOLocationBubbleAsk4ViewMap)viewMapBlock;
@end
