//
//  YIAddBillVc.h
//  XiaoJia
//
//  Created by efeng on 16/9/11.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "YIBaseViewController.h"
#import "YIPhase.h"

@interface YIAddBillVc : YIBaseViewController

@property (nonatomic, strong) YIPhase *phase;

@end



@protocol FrequencyViewDelegate <NSObject>

- (void)didSelectFrequencyItem:(YIFrequency *)frequency;

@end


@interface FrequencyView : UIView

@property (nonatomic, weak) id<FrequencyViewDelegate> delegate;

- (void)loadUI;

@end
