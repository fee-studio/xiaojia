//
//  YIBaseTableViewCell.m
//  Emma
//
//  Created by efeng on 15/7/23.
//  Copyright (c) 2015年 weiboyi. All rights reserved.
//

@implementation YIBaseTableViewCell

+ (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([self class])
                          bundle:[NSBundle mainBundle]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
