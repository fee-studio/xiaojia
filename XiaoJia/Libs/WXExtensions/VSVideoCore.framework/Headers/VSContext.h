//
//  VSContext.h
//  VideoStudio
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <Metal/Metal.h>


typedef NS_ENUM(NSInteger, VSContextType) {

    /**
     Automatically choose an appropriate VSContext context
     */
    VSContextTypeAuto,
    

    /**
     Create a hardware accelerated VSContext with Metal
     */
    VSContextTypeMetal,

    /**
     Create a hardware accelerated VSContext with CoreGraphics
     */
    VSContextTypeCoreGraphics,

    /**
     Create a hardware accelerated VSContext with EAGL (OpenGL)
     */
    VSContextTypeEAGL,

    /**
     Creates a standard VSContext hardware accelerated.
     */
    VSContextTypeDefault,

    /**
     Create a software rendered VSContext (no hardware acceleration)
     */
    VSContextTypeCPU
};

extern NSString *__nonnull const VSContextOptionsCGContextKey;
extern NSString *__nonnull const VSContextOptionsEAGLContextKey;
extern NSString *__nonnull const VSContextOptionsMTLDeviceKey;


/**
 Simple abstraction over CIContext.
 */
@interface VSContext : NSObject

/**
 The CIContext
 */
@property (readonly, nonatomic) CIContext *__nonnull CIContext;

/**
 The type with with which this VSContext was created
 */
@property (readonly, nonatomic) VSContextType type;

/**
 Will be non null if the type is VSContextTypeEAGL
 */
@property (readonly, nonatomic) EAGLContext *__nullable EAGLContext;

/**
Will be non null if the type is VSContextTypeMetal
*/
@property (readonly, nonatomic) id<MTLDevice> __nullable MTLDevice;

/**
 Will be non null if the type is VSContextTypeCoreGraphics
 */
@property (readonly, nonatomic) CGContextRef __nullable CGContext;

/**
 Create and returns a new context with the given type. You must check
 whether the contextType is supported by calling +[VSContext supportsType:] before.
 */
+ (VSContext *__nonnull)contextWithType:(VSContextType)type options:(NSDictionary *__nullable)options;

/**
 Returns whether the contextType can be safely created and used using +[VSContext contextWithType:]
 */
+ (BOOL)supportsType:(VSContextType)contextType;

/**
 The context that will be used when using an Auto context type;
 */
+ (VSContextType)suggestedContextType;

@end
