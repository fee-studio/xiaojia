//
//  ISecurityGuardOpenStaticDataStore.h
//  SecurityGuardMain
//
//  Created by lifengzhong on 15/11/7.
//  Copyright © 2015年 Li Fengzhong. All rights reserved.
//

#ifndef ISecurityGuardOpenStaticDataStore_h
#define ISecurityGuardOpenStaticDataStore_h

#import <SecurityGuardSDK/Open/OpenStaticDataStore/IOpenStaticDataStoreComponent.h>
#import <SecurityGuardSDK/Open/OpenStaticDataStore/OpenStaticDataStoreDefine.h>
#import <SecurityGuardSDK/Open/IOpenSecurityGuardPlugin.h>

@protocol ISecurityGuardOpenStaticDataStore <NSObject, IOpenStaticDataStoreComponent, IOpenSecurityGuardPluginInterface>
@end


#endif /* ISecurityGuardOpenStaticDataStore_h */
