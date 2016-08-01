//
//  YIPhotoPreviewCell.m
//  LoveWallpaper
//
//  Created by efeng on 14-8-19.
//  Copyright (c) 2014年 buerguo. All rights reserved.
//

#import "YIPhotoPreviewCell.h"

#define PADDING                  10


@interface YIPhotoPreviewCell () {
    UIImageView *_previewIV;
}

@end

@implementation YIPhotoPreviewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _previewIV = [UIImageView new];
        _previewIV.backgroundColor = kAppColorBlack;// kAppColorYellow;
        _previewIV.contentMode = UIViewContentModeScaleAspectFit; // UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_previewIV];
        [_previewIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_previewIV.superview);
        }];
    }
    return self;
}


- (void)setupCell:(NSString *)picture {
    _previewIV.image = [UIImage imageWithContentsOfFile:picture];
}

- (CGRect)frameForPagingScrollView {
    CGRect frame = mScreenBounds;
    frame.origin.x -= PADDING;
    frame.size.width += (2 * PADDING);
    return CGRectIntegral(frame);
}

@end
