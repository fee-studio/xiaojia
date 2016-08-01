//
//  YILogUtil.m
//  Dobby
//
//  Created by efeng on 14-5-21.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

@implementation YILogUtil


+ (void)logFrameOfView:(UIView *)view andName:(NSString *)name {
//    NSLog(@"文件名: %s, 行号: %d",__FILE__,__LINE__);

    NSLog(@"=================================================================");
    NSLog(@"VIEW'S NAME : %@", name ?: @"DEFUALT");
    NSLog(@" x = %f", view.frame.origin.x);
    NSLog(@" y = %f", view.frame.origin.y);
    NSLog(@" w = %f", view.frame.size.width);
    NSLog(@" h = %f", view.frame.size.height);
    NSLog(@"=================================================================");

}

+ (void)logFrameOrBounds:(CGRect)rect andName:(NSString *)name {

    NSLog(@"=================================================================");
    NSLog(@"FRAME_OR_BOUNDS'S NAME : %@", name ?: @"DEFUALT");
    NSLog(@" x = %f", rect.origin.x);
    NSLog(@" y = %f", rect.origin.y);
    NSLog(@" w = %f", rect.size.width);
    NSLog(@" h = %f", rect.size.height);
    NSLog(@"=================================================================");

}

+ (void)logSize:(CGSize)size andName:(NSString *)name {

    NSLog(@"=================================================================");
    NSLog(@"SIZE'S NAME : %@", name ?: @"DEFUALT");
    NSLog(@" w = %f", size.width);
    NSLog(@" h = %f", size.height);
    NSLog(@"=================================================================");

}

+ (void)logPoint:(CGPoint)point andName:(NSString *)name {

    NSLog(@"=================================================================");
    NSLog(@"SIZE'S NAME : %@", name ?: @"DEFUALT");
    NSLog(@" x = %f", point.x);
    NSLog(@" y = %f", point.y);
    NSLog(@"=================================================================");

}

+ (void)logCurrentTimeWithName:(NSString *)name {

    NSLog(@"=================================================================");
    NSLog(@"Postion : %@, Time : %f", name, [NSDate timeIntervalSinceReferenceDate]);
    NSLog(@"=================================================================");
}


@end
