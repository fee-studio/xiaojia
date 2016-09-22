//
// Created by efeng on 16/9/3.
// Copyright (c) 2016 buerguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "YIPhase.h"


typedef NS_ENUM(NSUInteger, PhaseSelectType) {
    PhaseSelectTypeCreate,
    PhaseSelectTypeModify,
};

@protocol YIAddPhaseVcDelegate<NSObject>

- (void)addPhaseSuccessWith:(YIPhase *)phase;

@end

@interface YIAddPhaseVc : YIBaseViewController

@property (nonatomic, weak) id<YIAddPhaseVcDelegate> delegate;
@property (nonatomic, assign)  PhaseSelectType selectType;

@property (nonatomic, strong) RLMArray<YIPhase *><YIPhase> *phaseList;

@end