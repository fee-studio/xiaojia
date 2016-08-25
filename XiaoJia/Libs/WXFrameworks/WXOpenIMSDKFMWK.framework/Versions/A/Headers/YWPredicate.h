//
//  YWPredicate.h
//  WXOpenIMSDK
//
//  Created by Jai Chen on 16/4/1.
//  Copyright © 2016年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWPredicate : NSObject

+ (nonnull instancetype)predicateWithClass:(nonnull Class)objectClass
                                  property:(nonnull NSString *)property
                         predicateOperator:(NSPredicateOperatorType)predicateOperator
                                     value:(nullable id)value;
@end



@interface YWCompoundPredicate : YWPredicate

+ (nullable YWCompoundPredicate *)andPredicateWithSubpredicates:(nonnull NSArray<YWPredicate *> *)subpredicates;
+ (nullable YWCompoundPredicate *)orPredicateWithSubpredicates:(nonnull NSArray<YWPredicate *> *)subpredicates;
+ (nullable YWCompoundPredicate *)notPredicateWithSubpredicate:(nonnull YWPredicate *)predicate;

@end
