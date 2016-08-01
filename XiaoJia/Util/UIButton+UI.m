//
//  UIButton+UI.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/26.
//  Copyright © 2015年 buerguo. All rights reserved.
//

@implementation UIButton (UI)

- (void)orangeStyle {
    [self setBackgroundColor:[UIColor cantaloupeColor]];
    [self cornerStyle];
    [self setTitleColor:kAppColorWhite forState:UIControlStateNormal];
}

- (void)greenStyle {
    [self setBackgroundColor:[UIColor grassColor]];
    [self cornerStyle];
    [self setTitleColor:kAppColorWhite forState:UIControlStateNormal];
}

- (void)mainColorStyle {
    [self setBackgroundColor:kAppColorMain];
    [self cornerStyle];
    [self setTitleColor:kAppColorWhite forState:UIControlStateNormal];
}


@end
