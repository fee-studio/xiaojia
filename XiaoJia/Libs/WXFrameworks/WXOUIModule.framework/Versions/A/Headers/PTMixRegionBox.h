//
//  PTMixRegionBox.h
//  WQClient
//
//  Created by muqiao.hyk on 14-12-10.
//  Copyright (c) 2014年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoxMsgLabelNode.h"
#import "BoxMsgImageNode.h"
#import "BoxMsgButtonNode.h"

@interface PTMixRegionBoxMutilTxt : NSObject
@property (strong, nonatomic) BoxMsgLabelNode *titleNode;
@property (strong, nonatomic) BoxMsgLabelNode *descNode;
@property (strong, nonatomic) NSString *action;
- (id)initWithDict:(NSDictionary *)multiTxtDict;
- (BOOL)shouldShow;

+ (id)parseFromDict:(NSDictionary *)dict;
@end

@interface PTMixCell : NSObject
@property (strong, nonatomic) PTMixRegionBoxMutilTxt *multiTxtNode;
@property (strong, nonatomic) BoxMsgImageNode *imageNode;
@property (strong, nonatomic) NSString *imageAlign;
@property (strong, nonatomic) NSString *action;
@property (nonatomic, strong) NSDictionary *userTrack;
@property (nonatomic, strong) NSString *degradeText;
@property (nonatomic, strong) NSNumber *degradeType;
- (id)initWithDict:(NSDictionary *)cellDict;
- (BOOL)shouldShow;
@end

@interface PTMixHead : NSObject
@property (nonatomic, strong) BoxMsgLabelNode *titleNode;
@property (nonatomic, strong) BoxMsgLabelNode *descNode;
@property (nonatomic, strong) BoxMsgImageNode *imageNode;
@property (nonatomic, strong) BoxMsgLabelNode *imageDescNode;
@property (nonatomic, strong) NSArray *buttomButtons;   // @[BoxMsgButtonNode,...]
@property (nonatomic, strong) NSString *action;
@property (nonatomic, strong) NSString *imageAlign;
@property (nonatomic, strong) NSDictionary *userTrack;
@property (nonatomic, strong) NSString *degradeText;
@property (nonatomic, strong) NSNumber *degradeType;
- (id)initWithDict:(NSDictionary *)headDict;
- (BOOL)shouldShow;
@end
