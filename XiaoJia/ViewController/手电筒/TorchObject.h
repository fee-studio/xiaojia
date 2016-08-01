//
//  TorchObject.h
//  FlashlightHero
//
//  Created by Guanshan Liu on 08/01/2012.
//  Copyright (c) 2012 Guanshan Liu. All rights reserved.
//

/*
 Copyright (C) 2013 Guanshan Liu
 
 This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or any later version.
 
 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/
 */

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface TorchObject : NSObject

#if !TARGET_IPHONE_SIMULATOR
@property(nonatomic, retain) AVCaptureDevice *torchDevice;
#endif

+ (id)sharedInstance;

- (void)setTorchOn:(BOOL)torchOn;

- (BOOL)isTorchOn;

- (void)toggleTorch;

- (void)setTorchLevel:(float)torchLevel;

- (float)torchLevel;

@end
