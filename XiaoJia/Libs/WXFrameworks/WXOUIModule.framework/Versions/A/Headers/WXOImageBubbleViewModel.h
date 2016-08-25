//
//  WXOImageBubbleViewModel.h
//  Messenger
//
//  Created by 慕桥(黄玉坤) on 12/1/14.
//
//

#import <Foundation/Foundation.h>
#import "YWBaseBubbleViewModel.h"

@interface WXOImageBubbleViewModel : YWBaseBubbleViewModel

@property (nonatomic, strong) id thumbnailObject;
@property (nonatomic, assign) CGSize thumbnailImageSize;

- (BOOL)isOriginalImageTypeGif;

typedef void (^WXOImageBubbleAsk2PreviewBlock) (UIView *aFromView);
@property (nonatomic,   copy) WXOImageBubbleAsk2PreviewBlock ask2PreviewBlock;
- (void)setAsk2PreviewBlock:(WXOImageBubbleAsk2PreviewBlock)ask2PreviewBlock;
@end
