//
//  WXOMediaBubbleViewModel.h
//  Messenger
//
//  Created by 慕桥(黄玉坤) on 12/1/14.
//
//

#import <Foundation/Foundation.h>
#import "YWBaseBubbleViewModel.h"

typedef enum : NSUInteger {
    MB_MediaType_Music,
    MB_MediaType_Video,
} MB_MediaType;

@interface WXOMediaBubbleViewModel : YWBaseBubbleViewModel
@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *descText;
@property (nonatomic, strong) NSString *playIcon;
@property (nonatomic, strong) NSString *mediaUrl;
@property (nonatomic, assign) MB_MediaType mediaType;

typedef void (^WXOMediaBubbleAsk4Play) (WXOMediaBubbleViewModel *viewModel);
@property (nonatomic,   copy) WXOMediaBubbleAsk4Play playBlock;
- (void)setPlayBlock:(WXOMediaBubbleAsk4Play)playBlock;
@end
