//
// Created by efeng on 15/11/8.
// Copyright (c) 2015 buerguo. All rights reserved.
//

#import "YIBaseCollectionViewCell.h"


@implementation YIBaseCollectionViewCell {

}

+ (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([self class])
                          bundle:[NSBundle mainBundle]];
}

- (void)awakeFromNib {
    // Initialization code
}

@end