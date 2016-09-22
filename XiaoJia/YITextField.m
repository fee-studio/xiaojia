//
//  YITextField.m
//  XiaoJia
//
//  Created by efeng on 16/9/3.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "YITextField.h"

@implementation YITextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
	return CGRectInset(bounds, 10, 10);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
	return CGRectInset(bounds, 10, 10);
}


@end
