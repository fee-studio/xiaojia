//
//  YIPrivateSetting.m
//  YIBox
//
//  Created by efeng on 16/2/27.
//  Copyright © 2016年 buerguo. All rights reserved.
//

@implementation YIPrivateSetting

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:self.class];
}


- (id)init {
    self = [super init];
    if (self) {
        self.enterHideState = PPSEnterHideStateClosed;
        self.simplePasswordState = PPSSimplePasswordStateOpen;
        self.fingerprintState = PPSFingerprintStateClosed;
        self.simplePassword = @"";
        self.promptOnVersion = 1;
    }
    return self;
}


@end
