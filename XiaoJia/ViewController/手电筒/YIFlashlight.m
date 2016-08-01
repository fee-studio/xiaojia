//
//  YIFlashlight.m
//  YIBox
//
//  Created by efeng on 2/13/16.
//  Copyright © 2016 buerguo. All rights reserved.
//

@implementation YIFlashlight

+ (instancetype)sharedInstance {
    static YIFlashlight *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[[self class] alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
//		self.type = FlashlightTypeFlash;
        self.brightness = [[UIScreen mainScreen] brightness];
    }
    return self;
}


- (void)setType:(FlashlightType)type {
    [mUserDefaults setInteger:type forKey:@"flashlight_type"];
    [mUserDefaults synchronize];
}

- (FlashlightType)type {
    FlashlightType type = [mUserDefaults integerForKey:@"flashlight_type"];
    return type;
}


@end
