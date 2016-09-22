//
//  UIColor+WSK.m
//  CTCockpit
//
//  Created by 何 振东 on 12-9-26.
//
//

@implementation UIColor (Addition)

+ (UIColor *)randomColor {

    CGFloat red = arc4random() / (CGFloat) INT_MAX;
    CGFloat green = arc4random() / (CGFloat) INT_MAX;
    CGFloat blue = arc4random() / (CGFloat) INT_MAX;
    return [UIColor colorWithRed:red
                           green:green
                            blue:blue
                           alpha:1.0];
}

+ (UIColor *)red:(int)red green:(int)green blue:(int)blue alpha:(CGFloat)alpha {
    UIColor *color = [UIColor colorWithRed:red / 255.f green:green / 255.f blue:blue / 255.f alpha:alpha];
    return color;
}

+ (NSArray *)convertColorToRBG:(UIColor *)uicolor {
    CGColorRef color = [uicolor CGColor];
    int numComponents = CGColorGetNumberOfComponents(color);
    NSArray *array = nil;

    if (numComponents == 4) {
        int rValue, gValue, bValue;
        const CGFloat *components = CGColorGetComponents(color);
        rValue = (int) (components[0] * 255);
        gValue = (int) (components[1] * 255);
        bValue = (int) (components[2] * 255);

        array = [NSArray arrayWithObjects:[NSNumber numberWithInt:rValue], [NSNumber numberWithInt:gValue], [NSNumber numberWithInt:bValue], nil];
    }

    return array;
}

UIColor *UIColorFromHex(NSInteger colorInHex) {
    // colorInHex should be value like 0xFFFFFF
    return [UIColor colorWithRed:((float) ((colorInHex & 0xFF0000) >> 16)) / 0xFF
                           green:((float) ((colorInHex & 0xFF00) >> 8)) / 0xFF
                            blue:((float) (colorInHex & 0xFF)) / 0xFF
                           alpha:1.0];
}

+ (UIColor *)convertHexColorToUIColor:(NSInteger)hexColor {
    return [UIColor colorWithRed:((float) ((hexColor & 0xFF0000) >> 16)) / 0xFF
                           green:((float) ((hexColor & 0xFF00) >> 8)) / 0xFF
                            blue:((float) (hexColor & 0xFF)) / 0xFF
                           alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    return [[self class] colorWithHexString:hexString alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    // Check for hash and add the missing hash
    if ('#' != [hexString characterAtIndex:0]) {
        hexString = [NSString stringWithFormat:@"#%@", hexString];
    }

    // check for string length
    assert(7 == hexString.length || 4 == hexString.length);

    // check for 3 character HexStrings
    hexString = [[self class] hexStringTransformFromThreeCharacters:hexString];

    NSString *redHex = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(1, 2)]];
    unsigned redInt = [[self class] hexValueToUnsigned:redHex];

    NSString *greenHex = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(3, 2)]];
    unsigned greenInt = [[self class] hexValueToUnsigned:greenHex];

    NSString *blueHex = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(5, 2)]];
    unsigned blueInt = [[self class] hexValueToUnsigned:blueHex];

    UIColor *color = [UIColor colorWith8BitRed:redInt green:greenInt blue:blueInt alpha:alpha];

    return color;
}

+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue {
    return [[self class] colorWith8BitRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha {
    UIColor *color = nil;
#if (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)
    color = [UIColor colorWithRed:(float) red / 255 green:(float) green / 255 blue:(float) blue / 255 alpha:alpha];
#else
    color = [UIColor colorWithCalibratedRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:alpha];
#endif

    return color;
}

+ (NSString *)hexStringTransformFromThreeCharacters:(NSString *)hexString {
    if (hexString.length == 4) {
        hexString = [NSString stringWithFormat:@"#%@%@%@%@%@%@",
                                               [hexString substringWithRange:NSMakeRange(1, 1)], [hexString substringWithRange:NSMakeRange(1, 1)],
                                               [hexString substringWithRange:NSMakeRange(2, 1)], [hexString substringWithRange:NSMakeRange(2, 1)],
                                               [hexString substringWithRange:NSMakeRange(3, 1)], [hexString substringWithRange:NSMakeRange(3, 1)]];
    }

    return hexString;
}

+ (unsigned)hexValueToUnsigned:(NSString *)hexValue {
    unsigned value = 0;

    NSScanner *hexValueScanner = [NSScanner scannerWithString:hexValue];
    [hexValueScanner scanHexInt:&value];

    return value;
}

@end
