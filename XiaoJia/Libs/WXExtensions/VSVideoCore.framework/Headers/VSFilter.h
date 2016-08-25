//
//  VSFilter.h
//  CoreImageShop
//
// 
//
//

#import <Foundation/Foundation.h>

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
#import <CoreImage/CoreImage.h>
#else
#import <QuartzCore/QuartzCore.h>
#endif

#import "VSFilterAnimation.h"



typedef NS_ENUM(int, VSFilterType) {
    VSFilterTypeOriginal = 0,//原始
    VSFilterTypeRefined,//炫丽
    VSFilterTypeElegant,//雅致
    VSFilterTypeBeautiful,//优美
    VSFilterTypeSunrise,//日出
    VSFilterTypeLOMO,//LOMO
    VSFilterTypeMemory,//怀旧
    VSFilterTypePhotograph//胶片
};



@class VSFilter;
@protocol VSFilterDelegate <NSObject, NSCopying>

/**
 Called when a parameter changed from the VSFilter instance.
 */
- (void)filter:(VSFilter *__nonnull)filter didChangeParameter:(NSString *__nonnull)parameterKey;

/**
 Called before the filter start processing an image.
 */
- (void)filter:(VSFilter *__nonnull)filter willProcessImage:(CIImage *__nullable)image atTime:(CFTimeInterval)time;

/**
 Called when the parameter values has been reset to defaults.
 */
- (void)filterDidResetToDefaults:(VSFilter *__nonnull)filter;

@end

@interface VSFilter : NSObject<NSCoding>

/**
 The underlying CIFilter attached to this VSFilter instance.
 */
@property (readonly, nonatomic) CIFilter *__nullable CIFilter;

/**
 The name of this filter. By default it takes the name of the attached
 CIFilter.
 */
@property (strong, nonatomic) NSString *__nullable name;

/**
 Whether this filter should process the images from imageByProcessingImage:.
 */
@property (assign, nonatomic) BOOL enabled;

/**
 Whether this VSFilter and all its subfilters have no CIFilter attached.
 If YES, it means that calling imageByProcessingImage: will always return the input
 image without any modification.
 */
@property (readonly, nonatomic) BOOL isEmpty;

/**
 Contains every added sub filters.
 */
@property (readonly, nonatomic) NSArray *__nonnull subFilters;

/**
 Contains every added VSFilterAnimations
 */
@property (readonly, nonatomic) NSArray *__nonnull animations;

/**
 Set a delegate that will receive messages when some parameters change
 */
@property (weak, nonatomic) __nullable id<VSFilterDelegate> delegate;

/**
 Initialize a VSFilter with an attached CIFilter.
 CIFilter can be nil.
 */
- (nullable instancetype)initWithCIFilter:(CIFilter *__nullable)filter;

/**
 Returns the attached CIFilter parameter value for the given key.
 */
- (__nullable id)parameterValueForKey:(NSString *__nonnull)key;

/**
 Set the attached CIFilter parameter value for the given key.
 */
- (void)setParameterValue:(__nullable id)value forKey:(NSString *__nonnull)key;

/**
 Add a VSFilterAnimation that can animate parameter values.
 */
- (void)addAnimation:(VSFilterAnimation *__nonnull)animation;

/**
 Convenience method to create and add an VSFilterAnimation that can animate parameter values.
 */
- (VSFilterAnimation *__nonnull)addAnimationForParameterKey:(NSString *__nonnull)key startValue:(__nullable id)startValue endValue:(__nullable id)endValue startTime:(CFTimeInterval)startTime duration:(CFTimeInterval)duration;

/**
 Remove an already added VSFilterAnimation.
 */
- (void)removeAnimation:(VSFilterAnimation *__nonnull)animation;

/**
 Remove all added VSFilterAnimation animations
 */
- (void)removeAllAnimations;

/**
 Reset the attached CIFilter parameter values to default for this instance
 and all the sub filters.
 */
- (void)resetToDefaults;

/**
 Add a sub filter. When processing an image, this VSFilter instance will first process the
 image using its attached CIFilter, then it will ask every sub filters added to process the
 given image.
 */
- (void)addSubFilter:(VSFilter *__nonnull)subFilter;

/**
 Remove a sub filter.
 */
- (void)removeSubFilter:(VSFilter *__nonnull)subFilter;

/**
 Remove a sub filter at a given index.
 */
- (void)removeSubFilterAtIndex:(NSInteger)index;

/**
 Insert a sub filter at a given index.
 */
- (void)insertSubFilter:(VSFilter *__nonnull)subFilter atIndex:(NSInteger)index;

/**
 Write this filter to a specific file.
 This filter can then be restored from this file using [VSFilter filterWithContentsOfUrl:].
 */
- (void)writeToFile:(NSURL *__nonnull)fileUrl error:(NSError *__nullable*__nullable)error;

/**
 Returns the CIImage by processing the given CIImage.
 */
- (CIImage *__nullable)imageByProcessingImage:(CIImage *__nullable)image;

/**
 Returns the CIImage by processing the given CIImage with the given time.
 */
- (CIImage *__nullable)imageByProcessingImage:(CIImage *__nullable)image atTime:(CFTimeInterval)time;

/**
 Creates and returns an empty VSFilter that has no CIFilter attached to it.
 It won't do anything when processing an image unless you add a non empty sub filter to it.
 */
+ (VSFilter *__nonnull)emptyFilter;

/**
 Creates and returns an VSFilter that will have the given CIFilter attached.
 */
+ (VSFilter *__nonnull)filterWithCIFilter:(CIFilter *__nullable)CIFilter;

/**
 Creates and returns an VSFilter attached to a newly created CIFilter from the given CIFilter name.
 */
+ (VSFilter *__nonnull)filterWithCIFilterName:(NSString *__nonnull)name;

/**
 Creates and returns an VSFilter that will process the images using the given affine transform.
 */
+ (VSFilter *__nonnull)filterWithAffineTransform:(CGAffineTransform)affineTransform;

/**
 Creates and returns a filter with a serialized filter data.
 */
+ (VSFilter *__nonnull)filterWithData:(NSData *__nonnull)data;

/**
 Creates and returns a filter with a serialized filter data.
 */
+ (VSFilter *__nonnull)filterWithData:(NSData *__nonnull)data error:(NSError *__nullable*__nullable)error;

/**
 Creates and returns a filter with an URL containing a serialized filter data.
 */
+ (VSFilter *__nonnull)filterWithContentsOfURL:(NSURL *__nullable)url;

/**
 Creates and returns a filter containg the given sub VSFilters.
 */
+ (VSFilter *__nonnull)filterWithFilters:(NSArray *__nonnull)filters;

/**
 Creates and returns a filter that will apply a CIImage on top
 */
+ (VSFilter *__nonnull)filterWithCIImage:(CIImage *__nonnull)image;


@property (assign, nonatomic) VSFilterType filterType;

@end


@interface VSFilter (CustomShader)
//根据传入的VSFilterType，创建一个滤镜对象
+ (VSFilter *__nonnull)filterWithFilterType:(VSFilterType)type;

@end