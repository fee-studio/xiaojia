//
//  ActionNode.h
//  Messenger
//
//  Created by admin on 14-9-1.
//
//

#import <Foundation/Foundation.h>

@interface ActionNode : NSObject
@property (nonatomic, strong) NSString *action;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *bizType;

+ (NSString *)actionFromJSONObj:(id)jsonObj;
@end
