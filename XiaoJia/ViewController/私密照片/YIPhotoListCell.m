//
//  MJCollectionViewCell.m
//  RCCPeakableImageSample
//
//  Created by Mayur on 4/1/14.
//  Copyright (c) 2014 RCCBox. All rights reserved.
//

#import "YIPhotoListCell.h"

@interface YIPhotoListCell ()

@property(nonatomic, strong, readwrite) UIImageView *MJImageView;
//@property (nonatomic, strong, readwrite) UIActivityIndicatorView *indicatorView;

@end

@implementation YIPhotoListCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) [self setupImageView];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) [self setupImageView];
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - Setup Method

- (void)setupImageView {
    // Clip subviews
    self.clipsToBounds = YES;

    // Add image subview
    self.MJImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.MJImageView.backgroundColor = [UIColor whiteColor];
    self.MJImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.MJImageView.clipsToBounds = YES;
    [self addSubview:self.MJImageView];

    self.selectedView = [self mySelectedView];
    [self addSubview:_selectedView];
    [_selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_selectedView.superview);
    }];
    _selectedView.hidden = YES;


    self.unselectedView = [self myUnselectedView];
    [self addSubview:_unselectedView];
    [_unselectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_unselectedView.superview);
    }];
    _unselectedView.hidden = YES;
}

- (UIView *)mySelectedView {
    UIView *view = [UIView new];
    view.userInteractionEnabled = NO;
    view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.4];

    UIImage *checkmarkImage = [UIImage imageNamed:@"Checkmark"];
    checkmarkImage = [checkmarkImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *checkmarkImageView = [[UIImageView alloc] initWithImage:checkmarkImage];
    checkmarkImageView.userInteractionEnabled = NO;
    [view addSubview:checkmarkImageView];
    [checkmarkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(checkmarkImageView.superview).offset(-5 - 4);
        make.bottom.equalTo(checkmarkImageView.superview).offset(-5 - 4);
    }];

    return view;
}

- (UIView *)myUnselectedView {
    UIView *view = [UIView new];
    view.userInteractionEnabled = NO;
    view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.1];

    UIImage *checkmarkImage = [UIImage imageNamed:@"CheckmarkUnselected"];
//	checkmarkImage = [checkmarkImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *checkmarkImageView = [[UIImageView alloc] initWithImage:checkmarkImage];
    checkmarkImageView.userInteractionEnabled = NO;
    [view addSubview:checkmarkImageView];
    [checkmarkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(checkmarkImageView.superview).offset(-5);
        make.bottom.equalTo(checkmarkImageView.superview).offset(-5);
    }];

    return view;
}

# pragma mark - Setters

- (void)setImage:(UIImage *)image {
    // Store image
    self.MJImageView.image = image;

    // Update padding
    [self setImageOffset:self.imageOffset];
}

//- (void)setupCell:(id)picture {
//	ALAsset *pictureAsset = (ALAsset *)picture;
//	self.MJImageView.image = [UIImage imageWithCGImage:pictureAsset.thumbnail];
//}

- (void)setupCell:(PHAsset *)asset {
    PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
    requestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;

    PHImageManager *manager = [PHImageManager defaultManager];
    CGFloat scale = UIScreen.mainScreen.scale;
    CGSize targetSize = CGSizeMake(200, 200);

    [manager requestImageForAsset:asset
                       targetSize:targetSize
                      contentMode:PHImageContentModeAspectFill
                          options:requestOptions
                    resultHandler:^(UIImage *image, NSDictionary *info) {
                        [self setImage:image];
                    }];
}

- (void)setupCell:(NSString *)fileName relativePath:(NSString *)path {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [UIImage imageWithContentsOfFile:[path stringByAppendingPathComponent:fileName]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
        });
    });

//	UIImage *image = [UIImage imageWithContentsOfFile:[path stringByAppendingPathComponent:fileName]];
//	self.image = image;
}

- (void)setImageOffset:(CGPoint)imageOffset {
    // Store padding value
    _imageOffset = imageOffset;

    // Grow image view
    CGRect frame = self.MJImageView.bounds;
    CGRect offsetFrame = CGRectOffset(frame, _imageOffset.x, _imageOffset.y);
    self.MJImageView.frame = offsetFrame;
}

@end
