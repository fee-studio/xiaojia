//
//  TFEImageAdvanceCut.h
//
//  Created by huamulou on 15-1-13.
//  Copyright (c) 2015年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFEImageAdvanceCut : NSObject

@property(nonatomic, readonly)int x;
@property(nonatomic, readonly)int y;
@property(nonatomic, readonly)int height;
@property(nonatomic, readonly)int width;
-(instancetype)initWithX:(int)x y:(int)y height:(int)height width:(int)width;
@end
