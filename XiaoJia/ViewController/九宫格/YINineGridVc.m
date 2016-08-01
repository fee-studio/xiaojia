//
//  YINineGridVc.m
//  YIBox
//
//  Created by efeng on 16/2/3.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "YINineGridVc.h"
#import "PECropViewController.h"
#import "UIImage+PECrop.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "YIShareUtil.h"


@interface YINineGridVc () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, PECropViewControllerDelegate> {
    UIImage *didCropImage;
    UIView *sampleView;
    UIView *toolView;

    MBProgressHUD *hud;
}

@property(nonatomic, strong) NSMutableArray *croppedImageMa;


@end

@implementation YINineGridVc

- (void)viewDidLoad {
    [super viewDidLoad];

    didCropImage = [UIImage imageNamed:@"crop.jpg"];

    [self loadPyqSampleView];
    [self loadToolView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass(self.class)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass(self.class)];
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
    [pickerBtn addTarget:self action:@selector(selecteWillCropPicAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:pickerBtn];
    [pickerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pickerBtn.superview).offset(10);
        make.centerY.equalTo(pickerBtn.superview);
        make.width.equalTo(@70);
        make.height.equalTo(@34);
    }];

    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn greenStyle];
    saveBtn.titleLabel.font = kAppSmlFont;
    [saveBtn setTitle:@"保存图片" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveCroppedPicAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(saveBtn.superview).offset(-10);
        make.centerY.equalTo(saveBtn.superview);
        make.width.equalTo(@70);
        make.height.equalTo(@34);
    }];

//	UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//	[shareBtn mainColorStyle];
//	shareBtn.titleLabel.font = kAppSmlFont;
//	[shareBtn setTitle:@"分享到朋友圈" forState:UIControlStateNormal];
//	[shareBtn addTarget:self action:@selector(shareCroppedPicAction:) forControlEvents:UIControlEventTouchUpInside];
//	[toolView addSubview:shareBtn];
//	[shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//		make.left.equalTo(saveBtn.mas_right).offset(10);
//		make.right.equalTo(shareBtn.superview).offset(-10);
//		make.centerY.equalTo(shareBtn.superview);
//		make.width.equalTo(@70);
//		make.height.equalTo(@34);
//	}];
}

- (void)loadPyqSampleView {
    if (sampleView) {
        [sampleView removeFromSuperview];
    }

    sampleView = [[UIView alloc] init];
    sampleView.backgroundColor = kAppColorWhite;
    [self.view addSubview:sampleView];
    [sampleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sampleView.superview).offset(20 + 44 + 20);
        make.left.equalTo(sampleView.superview);
        make.width.equalTo(sampleView.superview);
        make.height.equalTo(@320);
    }];

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [YICommonUtil appIconImage];
    [sampleView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.superview).offset(10);
        make.left.equalTo(imageView.superview).offset(10);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];

    UILabel *nameLbl = [[UILabel alloc] init];
    nameLbl.text = [YICommonUtil appName];
    nameLbl.font = [UIFont boldSystemFontOfSize:16];
    nameLbl.textColor = [UIColor denimColor];
    [sampleView addSubview:nameLbl];
    [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView);
        make.left.equalTo(imageView.mas_right).offset(10);
        make.right.equalTo(nameLbl.superview);
    }];

    UILabel *contentLbl = [[UILabel alloc] init];
    contentLbl.numberOfLines = 0;
    contentLbl.font = [UIFont systemFontOfSize:15];
    contentLbl.text = @"朋友圈-九宫分图, 效果如下:";
    [sampleView addSubview:contentLbl];
    [contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLbl.mas_bottom).offset(4);
        make.left.equalTo(imageView.mas_right).offset(10);
        make.right.equalTo(nameLbl.superview);
    }];

    [self cropNineGridView];
}

#pragma makr - create nine grid

- (void)cropNineGridView {
    self.croppedImageMa = [NSMutableArray array];

    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            [self cropViewWithWith:j height:i];
        }
    }
}

- (void)cropViewWithWith:(CGFloat)w height:(CGFloat)h {
    CGFloat width = didCropImage.size.width / 3.0f;
    CGFloat widthView = 80;
    CGFloat separtor = 3;

    CGRect rect = CGRectMake(width * w, width * h, width, width);
    UIImage *image = [didCropImage rotatedImageWithtransform:CGAffineTransformIdentity croppedToRect:rect];
    NSLog(@"image = %@", image);
    [_croppedImageMa addObject:image];

    CGRect rectView = CGRectMake(60 + (widthView + separtor) * w, 60 + (widthView + separtor) * h, widthView, widthView);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rectView];
    imageView.image = image;
    NSLog(@"imageView = %@", imageView);
    [sampleView addSubview:imageView];

//	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//		CGRect rect = CGRectMake(width * w, width * h, width, width);
//		UIImage *image = [croppedImage rotatedImageWithtransform:CGAffineTransformIdentity croppedToRect:rect];
//		NSLog(@"image = %@", image);
//		dispatch_async(dispatch_get_main_queue(), ^{
//			CGRect rectView = CGRectMake((widthView+separtor) * w, 100 + (widthView+separtor) * h, widthView, widthView);
//			UIImageView *imageView = [[UIImageView alloc] initWithFrame:rectView];
//			imageView.image = image;
//			NSLog(@"imageView = %@", imageView);
//			[self.view addSubview:imageView];
//		});
//		
//		[_croppedImageMa addObject:image];
//	});
}

#pragma mark - PECropViewControllerDelegate methods

- (void)cropViewController:(PECropViewController *)controller
    didFinishCroppingImage:(UIImage *)croppedImage
                 transform:(CGAffineTransform)transform
                  cropRect:(CGRect)cropRect {
    [controller dismissViewControllerAnimated:YES completion:NULL];

    // 9格分图
    didCropImage = croppedImage;

    [self loadPyqSampleView];
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -

- (IBAction)selecteWillCropPicAction:(id)sender {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:controller animated:YES completion:NULL];
}

- (void)saveImageToAlbum:(UIImage *)image index:(int)index {
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [assetsLibrary saveImage:image
                         toAlbum:[YICommonUtil appName]
             withCompletionBlock:^(NSError *error) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     if (error) {
                         // 再保存此张
                         [self saveImageToAlbum:image index:index];
                     } else {
                         // 保存下一张
                         int idx = index + 1;
                         if (idx < _croppedImageMa.count) {
                             UIImage *image = _croppedImageMa[idx];
                             [self saveImageToAlbum:image index:idx];
                         } else {
                             // 保存成功提示
                             UIImage *image = [UIImage imageNamed:@"success"];
                             UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                             hud.customView = imageView;
                             hud.mode = MBProgressHUDModeCustomView;
                             hud.labelText = @"保存成功!";
                             [hud hide:YES afterDelay:1.f];
                         }
                     }
                 });
             }];
    });
}

- (IBAction)saveCroppedPicAction:(id)sender {
    if (_croppedImageMa.count) {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.color = kAppColorMain;
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = [NSString stringWithFormat:@"保存到相册: %@", [YICommonUtil appName]];

        UIImage *image = _croppedImageMa[0];
        [self saveImageToAlbum:image index:0];
    }
}

- (void)shareCroppedPicAction:(id)action {
//	[YIShareUtil toWxShare:WXSceneTimeline images:nil];
    [YIShareUtil toWxShare:WXSceneTimeline text:nil];
}

#pragma mark - UIImagePickerControllerDelegate methods

/*
 Open PECropViewController automattically when image selected.
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    didCropImage = image;

    [picker dismissViewControllerAnimated:YES completion:^{
        [self openEditor:nil];
    }];
}

#pragma mark - 打开图片编辑器

- (IBAction)openEditor:(id)sender {
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.image = didCropImage;
    controller.keepingCropAspectRatio = YES;
    controller.toolbarHidden = YES;

    UIImage *image = didCropImage;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat length = MIN(width, height);
    controller.imageCropRect = CGRectMake((width - length) / 2,
            (height - length) / 2,
            length,
            length);

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];

//	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//		navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
//	}

    [self presentViewController:navigationController animated:YES completion:NULL];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
