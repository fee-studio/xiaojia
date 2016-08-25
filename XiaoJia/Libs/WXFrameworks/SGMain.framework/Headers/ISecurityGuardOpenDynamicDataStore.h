//
//  ISecurityGuardOpenDynamicDataStore.h
//  SecurityGuardMain
//
//  Created by lifengzhong on 15/11/10.
//  Copyright © 2015年 Li Fengzhong. All rights reserved.
//

#ifndef ISecurityGuardOpenDynamicDataStore_h
#define ISecurityGuardOpenDynamicDataStore_h

#import <SecurityGuardSDK/Open/OpenDynamicDataStore/IOpenDynamicDataStoreComponent.h>
#import <SecurityGuardSDK/Open/IOpenSecurityGuardPlugin.h>

@protocol ISecurityGuardOpenDynamicDataStore <NSObject, IOpenDynamicDataStoreComponent, IOpenSecurityGuardPluginInterface>

@end

#endif /* ISecurityGuardOpenDynamicDataStore_h */
