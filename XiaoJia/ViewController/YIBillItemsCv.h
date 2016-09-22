//
//  YIBillItemsCv.h
//  XiaoJia
//
//  Created by efeng on 16/9/11.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>


@protocol YIBillItemsCvDelegate <NSObject>

- (void)didSelectBillItem:(RLMObject *)item;

@end

@interface YIBillItemsCv : UIView

@property (nonatomic, weak) id<YIBillItemsCvDelegate> delegate;


@property (nonatomic, strong) RLMResults *items;
@end
