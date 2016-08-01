//
//  EditView.m
//  imageEdit
//
//  Created by 黄成 on 16/4/27.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "EditView.h"
#import "EditImageManager.h"

@interface EditView ()

@property(nonatomic, strong) NSMutableArray *paintLineArray;
@property(nonatomic, strong) NSMutableArray *paintPointArray;

@property(nonatomic, strong) NSMutableArray *eraseLineArray;
@property(nonatomic, strong) NSMutableArray *erasePointArray;

@property(nonatomic, strong) NSMutableArray *lineArray;
@property(nonatomic, strong) NSMutableArray *pointArray;


@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) UIImage *currentImage;
@property(nonatomic, strong) UIImage *originImage;
@property(nonatomic, strong) UIImage *filterImage;

@end

@implementation EditView

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        self.drawType = 0;
        self.paintDegree = 35;
        self.paintLineArray = [NSMutableArray array];
        self.eraseLineArray = [NSMutableArray array];
        self.lineArray = [NSMutableArray array];

        self.image = image;
    }

    return self;
}

+ (instancetype)viewWithImage:(UIImage *)image {
    return [[self alloc] initWithImage:image];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.currentImage = [UIImage scaleImage:self.image toSize:self.bounds.size];
    self.originImage = self.currentImage;//[self.currentImage copy];// [UIImage scaleImage:self.image toSize:self.bounds.size];
    self.filterImage = [EditImageManager filterForGaussianBlur:self.originImage];
}

- (void)setDrawType:(int)drawType {
    _drawType = drawType;

    self.currentImage = [self savedImage];
    self.lineArray = [NSMutableArray array];
    [self setNeedsDisplay];
}

- (void)setPaintDegree:(int)paintDegree {
    _paintDegree = paintDegree;

    self.currentImage = [self savedImage];
    self.lineArray = [NSMutableArray array];
    [self setNeedsDisplay];
}


- (void)initPoint:(CGPoint)p {
    /*
    if (self.drawType == 0) {
        self.paintPointArray = [NSMutableArray array];
        [self.paintLineArray addObject:self.paintPointArray];
        [self addPoint:p];
    } else {
        self.erasePointArray = [NSMutableArray array];
        [self.eraseLineArray addObject:self.erasePointArray];
        [self addPoint:p];
    }
     */

}

- (void)initPoint2:(CGPoint)p {
    self.pointArray = [NSMutableArray array];
    [self.lineArray addObject:self.pointArray];
    [self addPoint2:p];
}

- (void)addPoint2:(CGPoint)p {
    NSValue *pointValue = [NSValue valueWithCGPoint:p];
    NSDictionary *pointDic = @{@"type" : @(self.drawType), @"point" : pointValue};
    [self.pointArray addObject:pointDic];

    [self setNeedsDisplay];
}

- (void)addPoint:(CGPoint)p {
    NSValue *pointValue = [NSValue valueWithCGPoint:p];
    if (self.drawType == 0) {
        [self.paintPointArray addObject:pointValue];
    } else {
        [self.erasePointArray addObject:pointValue];
    }
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    CGPoint p = [[touches anyObject] locationInView:self];

    [self initPoint2:p];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    CGPoint p = [[touches anyObject] locationInView:self];

    [self addPoint2:p];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    CGPoint p = [[touches anyObject] locationInView:self];
    [self addPoint2:p];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    CGPoint p = [[touches anyObject] locationInView:self];
    [self addPoint2:p];
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound); // 4. 设置线顶部的样式
    CGContextSetLineJoin(context, kCGLineJoinRound); // 5. 设置线连接处的样式 // 可以使线画出来更圆滑
    CGContextSetLineWidth(context, self.paintDegree); // 3. 设置线宽
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor colorWithPatternImage:self.currentImage].CGColor);
    CGContextFillRect(context, rect);

//	if (self.drawType == 0) {
//		[self drawErasePath:context];
//		[self drawPaintPath:context];
//	} else {
//		[self drawPaintPath:context];
//		[self drawErasePath:context];
//	}

//	CGContextSetStrokeColorWithColor(context, [UIColor colorWithPatternImage:self.filterGaussan].CGColor);
//	CGContextSetLineWidth(context, 20);

    NSLog(@"array = %@", self.lineArray);

    for (int i = 0; i < self.lineArray.count; i++) {
        NSMutableArray *array = [self.lineArray objectAtIndex:i];
        for (int i = 0; i < array.count; i++) {
            NSDictionary *dic = array[i];
            if ([dic[@"type"] intValue] == 0) {
                CGContextSetStrokeColorWithColor(context, [UIColor colorWithPatternImage:self.filterImage].CGColor);
            } else {
                CGContextSetStrokeColorWithColor(context, [UIColor colorWithPatternImage:self.originImage].CGColor);
            }
            CGContextSetLineWidth(context, self.paintDegree);

            NSValue *value = dic[@"point"];
            CGPoint p = [value CGPointValue];
            if (i == 0) {
                CGContextMoveToPoint(context, p.x, p.y);
                CGContextAddLineToPoint(context, p.x, p.y);
            } else {
                CGContextAddLineToPoint(context, p.x, p.y);
            }
        }
    }
    CGContextDrawPath(context, kCGPathFillStroke);

}

- (void)drawPaintPath:(CGContextRef)context {
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithPatternImage:self.filterImage].CGColor);
    CGContextSetLineWidth(context, 20);
    for (int i = 0; i < self.paintLineArray.count; i++) {
        NSMutableArray *array = [self.paintLineArray objectAtIndex:i];
        for (int i = 0; i < array.count; i++) {
            NSValue *value = [array objectAtIndex:i];
            CGPoint p = [value CGPointValue];
            if (i == 0) {
                CGContextMoveToPoint(context, p.x, p.y);
                CGContextAddLineToPoint(context, p.x, p.y);
            } else {
                CGContextAddLineToPoint(context, p.x, p.y);
            }
        }
    }
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)drawErasePath:(CGContextRef)context {
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithPatternImage:self.image].CGColor);
    CGContextSetLineWidth(context, 20);
    for (int i = 0; i < self.eraseLineArray.count; i++) {
        NSMutableArray *array = [self.eraseLineArray objectAtIndex:i];
        for (int i = 0; i < array.count; i++) {
            NSValue *value = [array objectAtIndex:i];
            CGPoint p = [value CGPointValue];
            if (i == 0) {
                CGContextMoveToPoint(context, p.x, p.y);
                CGContextAddLineToPoint(context, p.x, p.y);
            } else {
                CGContextAddLineToPoint(context, p.x, p.y);
            }
        }
    }
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (UIImage *)savedImage {
    //hide controls if needed
    CGRect rect = [self bounds];
    if (rect.size.width == 0 || rect.size.height == 0) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(rect.size, self.opaque, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end