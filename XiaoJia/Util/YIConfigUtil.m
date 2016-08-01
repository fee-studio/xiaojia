//
//  YIConfigUtil.m
//  Dobby
//
//  Created by efeng on 14-6-30.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>


@implementation YIConfigUtil

+ (NSString *)userInfoSavedPath {
    NSString *path = [[YIFileUtil appDocumentDirectory] stringByAppendingPathComponent:@"9527.plist"];
    return path;
}

+ (NSURL *)downloadFileSaveToTargetFolder:(NSString *)orderId {
    if (orderId == nil) orderId = @"";

    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager]
            URLForDirectory:NSCachesDirectory
                   inDomain:NSUserDomainMask
          appropriateForURL:nil
                     create:NO
                      error:nil];

    NSURL *fileTargetPath = [documentsDirectoryURL URLByAppendingPathComponent:orderId];
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:[fileTargetPath path]];
    if (isExist) {
        return fileTargetPath;
    } else {
        BOOL isOk = [[NSFileManager defaultManager] createDirectoryAtURL:fileTargetPath withIntermediateDirectories:YES attributes:nil error:nil];
        if (isOk) {
            return fileTargetPath;
        }
    }

    return nil;
}

+ (NSURL *)thumbURLWithString:(NSString *)string andSize:(CGSize)size {
    if (!CGSizeEqualToSize(size, CGSizeZero)) {
        string = [string stringByAppendingPathComponent:[NSString stringWithFormat:@"%d_%d", (int) size.width * 2, (int) size.height * 2]];
        string = [string stringByAppendingPathComponent:@"3"]; // 3 是按比例缩小fill的
    } else {
//        string = [string stringByAppendingPathComponent:[NSString stringWithFormat:@"%d_%d", 300,300]];
    }
    NSURL *url = [NSURL URLWithString:string];
    return url;
}

+ (NSInteger)currentTimeAtServer; {
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    return (NSInteger) nowTime + mGlobalData.localTimeOffset;
}

+ (NSInteger)currentTimeAtLocal; {
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    return (NSInteger) nowTime;
}

// 检查系统相册 当前的权限
+ (ALAuthorizationStatus)checkAlbumAuthorization {
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if (status == ALAuthorizationStatusDenied) {
        NSString *subTitle = [NSString stringWithFormat:@"请到系统[设置]-[隐私]-[照片]-[%@]项，打开权限。", [YICommonUtil appName]];
        [TSMessage showNotificationWithTitle:@"无法访问你的相册"
                                    subtitle:subTitle
                                        type:TSMessageNotificationTypeWarning];
    }
    return status;
}


+ (NSString *)getMacAddress {
    int mgmtInfoBase[6];
    char *msgBuffer = NULL;
    size_t length;
    unsigned char macAddress[6];
    struct if_msghdr *interfaceMsgStruct;
    struct sockaddr_dl *socketStruct;
    NSString *errorFlag = NULL;

    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces

    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }

    // Befor going any further...
    if (errorFlag != NULL) {
        NSLog(@"Error: %@", errorFlag);
        return errorFlag;
    }

    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;

    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);

    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);

    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x",
                                                            macAddress[0], macAddress[1], macAddress[2],
                                                            macAddress[3], macAddress[4], macAddress[5]];
    NSLog(@"Mac Address: %@", macAddressString);

    // Release the buffer memory
    free(msgBuffer);

    return macAddressString;
}

// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to mlamb.
+ (NSString *)macaddress {

    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;

    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;

    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }

    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }

    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }

    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }

    ifm = (struct if_msghdr *) buf;
    sdl = (struct sockaddr_dl *) (ifm + 1);
    ptr = (unsigned char *) LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr + 1), *(ptr + 2), *(ptr + 3), *(ptr + 4), *(ptr + 5)];

    //    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];

    NSLog(@"outString:%@", outstring);

    free(buf);

    return [outstring uppercaseString];
}

@end

