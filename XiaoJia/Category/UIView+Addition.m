//
//  UIView+Addition.m
//  Line0New
//
//  Created by line0 on 13-5-17.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

@implementation UIView (Addition)


- (UIView *)subViewWithTag:(int)tag {
    for (UIView *v in self.subviews) {
        if (v.tag == tag) {
            return v;
        }
    }
    return nil;
}


+ (UIView *)loadNibView:(NSString *)viewName {
    return [[NSBundle mainBundle] loadNibNamed:viewName owner:self options:nil][0];
}

+ (UIView *)loadNibView:(NSString *)viewName index:(NSUInteger)index {

    NSArray *views = [[NSBundle mainBundle] loadNibNamed:viewName owner:self options:nil];

    if (views.count > index) {
        return views[index];
    }

    return nil;
}


- (UIImage *)toImage {
    UIImage *snapshotImage;
    if ([UIDevice currentDevice].systemVersion.floatValue < 7.0) {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, self.window.screen.scale);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

    } else {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, self.window.screen.scale);
        [self drawViewHierarchyInRect:self.frame afterScreenUpdates:YES];
        snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

    }
    return snapshotImage;
}

- (void)borderAndCornerStyle {
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.layer.cornerRadius = 5.f;
    self.layer.borderWidth = .5f;
    self.layer.masksToBounds = YES;
}

- (void)cornerStyle {
    self.layer.cornerRadius = 4.f;
    self.layer.masksToBounds = YES;
}

- (void)borderStyle {
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.layer.borderWidth = .5f;
    self.layer.masksToBounds = YES;
}

- (void)circleStyle {
    self.layer.cornerRadius = self.width / 2.f;
    self.layer.masksToBounds = YES;
}

- (void)flashlightSwitchStyle {
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.layer.borderWidth = 5.f;
    self.layer.cornerRadius = self.width / 2.f;
    self.layer.masksToBounds = YES;
}


@end
