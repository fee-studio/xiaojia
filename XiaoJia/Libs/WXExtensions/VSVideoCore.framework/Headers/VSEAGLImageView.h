#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "VSImageView.h"

@interface VSEAGLImageView : VSImageView


/*
 render frame , return CIImage
 */
- (CIImage*)didRenderFrame:(CVPixelBufferRef)input;

/*
 render frame , return CVPixelBufferRef
 */
- (CVPixelBufferRef)didRenderFrameReturnCVPixelBuffer:(CVPixelBufferRef)input;


- (UIImage *)UIImageByProcessingUIImage:(UIImage *)uiImage;

/**
 The filter to apply when rendering. If nil is set, no filter will be applied
 */
@property (strong, nonatomic) VSFilter *filter;

@end
