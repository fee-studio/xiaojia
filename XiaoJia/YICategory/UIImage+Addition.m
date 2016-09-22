//
//  UIImage+WSK.m
//  CorePlotDemo
//
//  Created by 何 振东 on 12-9-26.
//  Copyright (c) 2012年 开趣. All rights reserved.
//

@implementation UIImage (Addition)

CGFloat DegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
};

CGFloat RadiansToDegrees(CGFloat radians) {
    return radians * 180 / M_PI;
};

+ (UIImage *)grabScreenWithScale:(CGFloat)scale {
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    //    UIGraphicsBeginImageContext(screenWindow.frame.size);
    UIGraphicsBeginImageContextWithOptions(screenWindow.frame.size, YES, scale);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

+ (UIImage *)grabImageWithView:(UIView *)view scale:(CGFloat)scale {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);

    return image;
}

+ (UIImage *)captureView:(UIView *)view frame:(CGRect)frame {
    UIGraphicsBeginImageContext(view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef ref = CGImageCreateWithImageInRect(img.CGImage, frame);
    UIImage *i = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return i;
}

+ (UIImage *)mergeWithImage1:(UIImage *)image1 image2:(UIImage *)image2 frame1:(CGRect)frame1 frame2:(CGRect)frame2 size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image1 drawInRect:frame1 blendMode:kCGBlendModeLuminosity alpha:1.0];
    [image2 drawInRect:frame2 blendMode:kCGBlendModeLuminosity alpha:0.2];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

+ (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)mask {
    CGImageRef imgRef = [image CGImage];
    CGImageRef maskRef = [mask CGImage];
    CGImageRef actualMask = CGImageMaskCreate(CGImageGetWidth(maskRef),
            CGImageGetHeight(maskRef),
            CGImageGetBitsPerComponent(maskRef),
            CGImageGetBitsPerPixel(maskRef),
            CGImageGetBytesPerRow(maskRef),
            CGImageGetDataProvider(maskRef), NULL, true);
    CGImageRef masked = CGImageCreateWithMask(imgRef, actualMask);
    UIImage *resultImg = [UIImage imageWithCGImage:masked];
    CGImageRelease(actualMask);
    CGImageRelease(masked);

    return resultImg;
}

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size {
//    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return scaledImage;
}

+ (UIImage *)colorizeImage:(UIImage *)image withColor:(UIColor *)color {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, image.CGImage);
    [color set];
    CGContextFillRect(ctx, area);
    CGContextRestoreGState(ctx);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextDrawImage(ctx, area, image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}


- (UIImage *)imageAtRect:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *subImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);

    return subImage;
}

- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize {
    UIImage *sourceImage = self;
    UIImage *newImage = nil;

    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;

    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;

    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;

    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);

    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {

        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;

        if (widthFactor > heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;

        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;

        // center the image

        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }

    // this is actually the interesting part:

    UIGraphicsBeginImageContext(targetSize);

    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;

    [sourceImage drawInRect:thumbnailRect];

    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    if (newImage == nil) NSLog(@"could not scale image");

    return newImage;
}

- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize {
    UIImage *sourceImage = self;
    UIImage *newImage = nil;

    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;

    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;

    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;

    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);

    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {

        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;

        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;

        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;

        // center the image

        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }


    // this is actually the interesting part:

    UIGraphicsBeginImageContext(targetSize);

    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;

    [sourceImage drawInRect:thumbnailRect];

    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    if (newImage == nil) NSLog(@"could not scale image");

    return newImage;
}

- (UIImage *)imageByScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = self;
    UIImage *newImage = nil;

    //   CGSize imageSize = sourceImage.size;
    //   CGFloat width = imageSize.width;
    //   CGFloat height = imageSize.height;

    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;

    //   CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;

    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);

    // this is actually the interesting part:

    UIGraphicsBeginImageContext(targetSize);

    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;

    [sourceImage drawInRect:thumbnailRect];

    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    if (newImage == nil) NSLog(@"could not scale image");


    return newImage;
}

- (UIImage *)imageRotatedByRadians:(CGFloat)radians {
    return [self imageRotatedByDegrees:RadiansToDegrees(radians)];
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees {
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;

    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();

    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width / 2, rotatedSize.height / 2);

    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));

    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;

}

/**
 *  处理图片拉伸
 *
 *  UIImageResizingModeStretch：
 *      拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
 *  UIImageResizingModeTile：
 *      平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图片
 *
 *  @param image  原始图片
 *  @param top    距顶的高度
 *  @param left   距左的高度
 *  @param bottom 距底的高度
 *  @param right  距右的高度
 *
 *  @return 被拉伸的图片
 */
- (UIImage *)resizableWithTop:(CGFloat)top
                         left:(CGFloat)left
                       bottom:(CGFloat)bottom
                        right:(CGFloat)right {

    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    return [self resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}

/**
 *  处理图片拉伸
 *
 *  @param image 原始图片
 *  @param value 四边的值都相等
 *
 *  @return 被拉伸的图片
 */
- (UIImage *)resizableWithMarginValue:(CGFloat)value {
    return [self resizableWithTop:value left:value bottom:value right:value];
}

- (UIImage *)toGrayscale {
    const int RED = 1;
    const int GREEN = 2;
    const int BLUE = 3;

    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, self.size.width * self.scale, self.size.height * self.scale);

    int width = imageRect.size.width;
    int height = imageRect.size.height;

    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));

    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
            kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);

    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [self CGImage]);

    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];

            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            uint8_t gray = (uint8_t) ((30 * rgbaPixel[RED] + 59 * rgbaPixel[GREEN] + 11 * rgbaPixel[BLUE]) / 100);

            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }

    // create a new CGImageRef from our context with the modified pixels
    CGImageRef image = CGBitmapContextCreateImage(context);

    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);

    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:image
                                                 scale:self.scale
                                           orientation:UIImageOrientationUp];

    // we're done with image now too
    CGImageRelease(image);

    return resultUIImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (UIImage *)image32k {
    int imageWidth = 100;
    UIImage *finalImage = self;
    NSData *imageData = UIImageJPEGRepresentation(finalImage, 1);
    while (imageData.length > 32 * 1000) {
        finalImage = [finalImage imageByScalingProportionallyToMinimumSize:CGSizeMake(imageWidth, imageWidth)];
        imageData = UIImageJPEGRepresentation(finalImage, 1);
        imageWidth /= 2.0;
    }

    return finalImage;
}

@end
