//
//  UILabel+Addition.m
//  Dobby
//
//  Created by efeng on 14-7-30.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

@implementation UILabel (Addition)

- (CGRect)resizeToStretch {

    CGSize size = [self expectedWidth];

    CGRect newFrame = [self frame];
    newFrame.size.width = ceilf(self.frame.size.width);
    newFrame.size.height = ceilf(size.height);
    [self setFrame:newFrame];

    return self.frame;
}

- (CGSize)expectedWidth {

    [self setNumberOfLines:0];

    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width, 9999);

    CGSize expectedLabelSize = [self.text calculateSize:maximumLabelSize font:self.font];

    CGFloat marginValue = 10.f;
    expectedLabelSize.width += marginValue;
    expectedLabelSize.height += marginValue;

    /*
    if (expectedLabelSize.width < self.frame.size.width) {
        expectedLabelSize.width = self.frame.size.width;
    } else {
        expectedLabelSize.width += marginValue;
    }
    
    if (expectedLabelSize.height < self.frame.size.height) {
        expectedLabelSize.height = self.frame.size.height;
    } else {
        expectedLabelSize.height += marginValue;
    }
     */

    return expectedLabelSize;
}

- (CGSize)calSizeOnText {
    [self setNumberOfLines:0];
    CGSize maximumLabelSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGRect rect = [self.text boundingRectWithSize:maximumLabelSize
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:nil
                                          context:nil];
    CGSize size = rect.size;
    NSLog(@"cal rect = %@", NSStringFromCGRect(rect));
    return size;
}

- (UILabel *)autoWidthOnText {
    if (self.text.isEmpty) {
        CGRect frame = self.frame;
        frame.size.width = 0;
        self.frame = frame;
    } else {
        CGSize maximumSize = CGSizeMake(MAXFLOAT, self.frame.size.height);
        CGSize size = [self.text calculateSize:maximumSize font:self.font];
        CGRect newFrame = self.frame;
        newFrame.size.width = ceilf(size.width) + 10;
        newFrame.size.height = ceilf(self.frame.size.height) + 10;
        self.frame = newFrame;
    }
    return self;
}

- (UILabel *)autoHeightOnText {
    [self setNumberOfLines:0];
    if (self.text.isEmpty) {
        CGRect frame = self.frame;
        frame.size.height = 0;
        self.frame = frame;
    } else {
        CGSize maximumSize = CGSizeMake(self.frame.size.width, MAXFLOAT);
        CGSize size = [self.text calculateSize:maximumSize font:self.font];
        CGRect newFrame = self.frame;
        newFrame.size.width = ceilf(self.frame.size.width) + 10;
        newFrame.size.height = ceilf(size.height) + 10;
        self.frame = newFrame;
    }
    return self;
}

- (void)alignTop {
    CGSize fontSize = [self.text sizeWithFont:self.font];
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad = (finalHeight - theStringSize.height) / fontSize.height;
    for (int i = 0; i < newLinesToPad; i++)
        self.text = [self.text stringByAppendingString:@"\n "];
}

- (void)alignBottom {
    CGSize fontSize = [self.text sizeWithFont:self.font];
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad = (finalHeight - theStringSize.height) / fontSize.height;
    for (int i = 0; i < newLinesToPad; i++)
        self.text = [NSString stringWithFormat:@" \n%@", self.text];
}

- (UIImage *)grabImage {
    // Create a "canvas" (image context) to draw in.
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);  // high res
    // Make the CALayer to draw in our "canvas".
    [[self layer] renderInContext:UIGraphicsGetCurrentContext()];
    // Fetch an UIImage of our "canvas".
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // Stop the "canvas" from accepting any input.
    UIGraphicsEndImageContext();
    // Return the image.
    return image;
}


@end
