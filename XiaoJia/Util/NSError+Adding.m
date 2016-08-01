//
// Created by efeng on 15/6/24.
// Copyright (c) 2015 weiboyi. All rights reserved.
//

#import <objc/runtime.h>

static const void *ErrorArg1Key = &ErrorArg1Key;


@implementation NSError (Adding)

#pragma mark - errorArg1 - getter setter

- (NSString *)errorArg1 {
    return objc_getAssociatedObject(self, ErrorArg1Key);
}

- (void)setErrorArg1:(NSString *)indieBandName {
    objc_setAssociatedObject(self, ErrorArg1Key, indieBandName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -

+ (instancetype)dobbyErrorWithCode:(NSInteger)code andMsg:(NSString *)msg {
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey : msg ? msg : @""};
    return [NSError errorWithDomain:DobbyErrorDomain code:code userInfo:userInfo];
}


+ (id)networkNotReachableError {
    return [self dobbyErrorWithCode:ErrorCodeNetworkNotReachable andMsg:kMessageNetworkAnomaly];
}

+ (id)noCacheDataError {
    return [self dobbyErrorWithCode:ErrorCodeNoCacheData andMsg:kMessageNoCacheData];
}

#pragma mark -

- (id)toHandle {
    [mNotificationCenter postNotificationName:APP_ERROR_HANDLE_NOTIFICATION object:self];
    return self;
}

@end
