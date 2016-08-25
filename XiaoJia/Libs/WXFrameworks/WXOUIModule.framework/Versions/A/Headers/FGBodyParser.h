//
//  FGBodyParser.h
//  Messenger
//
//  Created by 慕桥(黄玉坤) on 3/4/15.
//
//

#import <Foundation/Foundation.h>

@class FGBox;

@interface FGBodyParser : NSObject
@property (nonatomic, strong) FGBox *rootBox;
@property (nonatomic, assign) NSInteger grid_columns;
@property (nonatomic, assign) NSInteger grid_rows;

/// 解析模板数据
- (void)parseWithData:(NSDictionary *)data;
@end
