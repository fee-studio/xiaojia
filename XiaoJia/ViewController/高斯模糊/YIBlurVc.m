//
//  YIBlurVc.m
//  YIBox
//
//  Created by efeng on 16/1/30.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "YIBlurVc.h"
#import <LTNavigationBar/UINavigationBar+Awesome.h>
#import "FXBlurView.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"


@interface YIBlurVc () <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    FXBlurView *blurView;
    UIImagePickerController *imagePicker;
    UIImage *curImage;

    UIView *toolView;
}

@property(weak, nonatomic) IBOutlet UIButton *openAlbumBtn;
@property(weak, nonatomic) IBOutlet UIButton *saveImageBtn;
@property(weak, nonatomic) IBOutlet UISlider *blurRadiusSlider;
@property(weak, nonatomic) IBOutlet UIImageView *filterIv;


@end

@implementation YIBlurVc

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

//	blurView = [[FXBlurView alloc] init];
//	[self.view addSubview:blurView];
//	[blurView mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.edges.equalTo(blurView.superview);
//	}];

    _blurRadiusSlider.minimumValue = -10;
    _blurRadiusSlider.maximumValue = 50;
    _blurRadiusSlider.value = 5;

    [self.view bringSubviewToFront:_openAlbumBtn];
    [self.view bringSubviewToFront:_saveImageBtn];
    [self.view bringSubviewToFront:_blurRadiusSlider];

//	blurView.blurRadius = _blurRadiusSlider.value;

    curImage = [_filterIv.image copy];


//	UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//	UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];

    [self loadToolView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass(self.class)];

    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    // 第二种方法
    //	[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //	self.navigationController.navigationBar.translucent = YES; //iOS7必须显示指定，否则无透明
    //	self.navigationController.navigationBar.shadowImage = [UIImage new]; //若bar是全透明，用此干掉bar底的线

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass(self.class)];

    [self.navigationController.navigationBar lt_reset];
}

- (void)loadToolView {
    if (toolView) {
        [toolView removeFromSuperview];
    }

    toolView = [[UIView alloc] init];
    toolView.backgroundColor = [UIColor ivoryColor];
    [self.view addSubview:toolView];
    [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toolView.superview);
        make.bottom.equalTo(toolView.superview);
        make.width.equalTo(toolView.superview);
        make.height.equalTo(@49);
    }];

    UIButton *pickerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pickerBtn orangeStyle];
    pickerBtn.titleLabel.font = kAppSmlFont;
    [pickerBtn setTitle:@"选择图片" forState:UIControlStateNormal];
    [pickerBtn addTarget:self action:@selector(openAlbumBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:pickerBtn];
    [pickerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pickerBtn.superview).offset(10);
        make.centerY.equalTo(pickerBtn.superview);
        make.width.equalTo(@70);
        make.height.equalTo(@30);
    }];

    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn greenStyle];
    saveBtn.titleLabel.font = kAppSmlFont;
    [saveBtn setTitle:@"保存图片" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveImageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(saveBtn.superview).offset(-10);
        make.centerY.equalTo(saveBtn.superview);
        make.width.equalTo(@70);
        make.height.equalTo(@30);
    }];

    UISlider *slider = [[UISlider alloc] init];
    slider.minimumValue = -10;
    slider.maximumValue = 50;
    slider.value = 5;
    [slider addTarget:self action:@selector(blurSliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:slider];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pickerBtn.mas_right).offset(5);
        make.right.equalTo(saveBtn.mas_left).offset(-5);
        make.centerY.equalTo(slider.superview);
    }];
}

- (IBAction)blurRadiusSliderValueChanged:(id)sender {
//	blurView.blurRadius = _blurRadiusSlider.value;


//	_filterIv.image = [YIBlurVc boxblurImage:_filterIv.image withBlurNumber:_blurRadiusSlider.value];


//	dispatch_async(dispatch_get_main_queue(), ^{
//		_filterIv.image = [curImage blurredImageWithRadius:_blurRadiusSlider.value
//												iterations:3
//												 tintColor:[UIColor clearColor]];
//	});

//	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//		UIImage *blurredImage = [curImage blurredImageWithRadius:_blurRadiusSlider.value
//												iterations:2
//												 tintColor:[UIColor clearColor]];
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//			_filterIv.image = blurredImage;
//        });
//    });


}

#pragma mark - 打开相册

- (IBAction)openAlbumBtnAction:(id)sender {
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

//当选择一张图片后进入这里
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.filterIv.image = image;

//	blurView.blurRadius = _blurRadiusSlider.value;

    curImage = [_filterIv.image copy];

    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - 保存图片

- (IBAction)saveImageBtnAction:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.color = kAppColorMain;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = [NSString stringWithFormat:@"保存到相册: %@", [YICommonUtil appName]];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        [assetsLibrary saveImage:_filterIv.image
                         toAlbum:[YICommonUtil appName]
             withCompletionBlock:^(NSError *error) {
                 if (error) {
                     UIImage *image = [UIImage imageNamed:@"failure"];
                     UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                     hud.customView = imageView;
                     hud.mode = MBProgressHUDModeCustomView;
                     hud.labelText = @"保存失败!";
                     hud.detailsLabelText = [NSString stringWithFormat:@"请操作: [设置]>[隐私]>[照片]>[%@]", [YICommonUtil appName]];
                     [hud hide:YES afterDelay:5.f];
                 } else {
                     UIImage *image = [UIImage imageNamed:@"success"];
                     UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                     hud.customView = imageView;
                     hud.mode = MBProgressHUDModeCustomView;
                     hud.labelText = @"保存成功!";
                     [hud hide:YES afterDelay:1.f];
                 }
             }];
    });

}

#pragma mark -

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//	[self.navigationController.navigationBar lt_reset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int) (blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;

    CGImageRef img = image.CGImage;

    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;

    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);

    inBuffer.data = (void *) CFDataGetBytePtr(inBitmapData);

    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
            CGImageGetHeight(img));

    if (pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");

    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);

    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);

    if (error) {
        NSLog(@"error from convolution %ld", error);
    }

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
            outBuffer.data,
            outBuffer.width,
            outBuffer.height,
            8,
            outBuffer.rowBytes,
            colorSpace,
            kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];

    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);

    free(pixelBuffer);
    CFRelease(inBitmapData);

    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);

    return returnImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)blurSliderAction:(id)sender {
//		dispatch_async(dispatch_get_main_queue(), ^{
    UISlider *slider = (UISlider *) sender;
    _filterIv.image = [curImage blurredImageWithRadius:slider.value
                                            iterations:3
                                             tintColor:[UIColor clearColor]];
//		});


//	_filterIv.image = [[self class] boxblurImage:curImage withBlurNumber:_blurRadiusSlider.value];
}

@end
