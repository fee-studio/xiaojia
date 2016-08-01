//
//  YIMosaicsVc.m
//  YIBox
//
//  Created by efeng on 2/23/16.
//  Copyright © 2016 buerguo. All rights reserved.
//

#import "YIMosaicsVc.h"
#import "YIMosaicsView.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "EditView.h"
#import "ASValueTrackingSlider.h"


@interface YIMosaicsVc () <UINavigationControllerDelegate,
        UIImagePickerControllerDelegate> {
    UIView *toolView;
    UIView *toolView2;

    UIImagePickerController *imagePicker;
    YIMosaicsView *mosaicsView;

    UIButton *paintBtn;
    UIButton *eraseBtn;

    UILabel *lblValue;
    ASValueTrackingSlider *slider;
}

//@property (weak, nonatomic) IBOutlet UIImageView *originalIv;
//@property (weak, nonatomic) IBOutlet UIImageView *mosaicsIv;
//@property (weak, nonatomic) IBOutlet UIImageView *displayIv;

@end

@implementation YIMosaicsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载工具栏
    [self loadToolView];
    [self loadToolView2];

    // 为了进来的快~
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadMosaicsView:[UIImage imageNamed:@"5.pic.jpg"]];
    });
}

- (void)loadMosaicsView:(UIImage *)image {
    if (mosaicsView) {
        [mosaicsView removeFromSuperview];
        mosaicsView = nil;
    }
    mosaicsView = [YIMosaicsView viewWithMosaicsImage:image];
    [self.view insertSubview:mosaicsView atIndex:0];
    UIEdgeInsets insets = UIEdgeInsetsMake(64, 0, 49 * 2, 0);
    [mosaicsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(mosaicsView.superview).insets(insets);
    }];
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

}

- (void)loadToolView2 {

    if (toolView2) {
        [toolView2 removeFromSuperview];
    }

    toolView2 = [[UIView alloc] init];
    toolView2.backgroundColor = [UIColor ivoryColor];
    [self.view addSubview:toolView2];
    [toolView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toolView2.superview);
        make.bottom.equalTo(toolView.mas_top);
        make.width.equalTo(toolView2.superview);
        make.height.equalTo(@49);
    }];


    paintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [paintBtn setBackgroundImage:[UIImage imageWithColor:[UIColor robinEggColor]] forState:UIControlStateNormal];
    [paintBtn setBackgroundImage:[UIImage imageWithColor:[UIColor denimColor]] forState:UIControlStateSelected];
    [paintBtn cornerStyle];
    [paintBtn setTitleColor:kAppColorWhite forState:UIControlStateNormal];
    paintBtn.selected = YES;
    paintBtn.titleLabel.font = kAppSmlFont;
    [paintBtn setTitle:@"涂抹" forState:UIControlStateNormal];
    [paintBtn addTarget:self action:@selector(paintBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolView2 addSubview:paintBtn];
    [paintBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(paintBtn.superview).offset(10);
        make.centerY.equalTo(paintBtn.superview);
        make.width.equalTo(@70);
        make.height.equalTo(@30);
    }];


    eraseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [eraseBtn setBackgroundImage:[UIImage imageWithColor:[UIColor robinEggColor]] forState:UIControlStateNormal];
    [eraseBtn setBackgroundImage:[UIImage imageWithColor:[UIColor denimColor]] forState:UIControlStateSelected];
    [eraseBtn cornerStyle];
    [eraseBtn setTitleColor:kAppColorWhite forState:UIControlStateNormal];
    eraseBtn.titleLabel.font = kAppSmlFont;
    [eraseBtn setTitle:@"擦除" forState:UIControlStateNormal];
    [eraseBtn addTarget:self action:@selector(eraseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolView2 addSubview:eraseBtn];
    [eraseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(paintBtn.mas_right).offset(1);
        make.centerY.equalTo(eraseBtn.superview);
        make.width.equalTo(paintBtn);
        make.height.equalTo(@30);
    }];

    lblValue = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    lblValue.backgroundColor = kAppColorMain;
    lblValue.textAlignment = NSTextAlignmentCenter;
    lblValue.font = kAppMidFont;
    lblValue.textColor = kAppColorWhite;
    lblValue.layer.cornerRadius = 15;
    lblValue.layer.masksToBounds = YES;

    slider = [[ASValueTrackingSlider alloc] init];
    slider.minimumValue = 20;
    slider.maximumValue = 50;
    slider.value = 35;
    [slider addTarget:self action:@selector(onChangeSlider:) forControlEvents:UIControlEventValueChanged];
    [toolView2 addSubview:slider];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(eraseBtn.mas_right).offset(10);
        make.right.equalTo(slider.superview).offset(-10);
        make.centerY.equalTo(slider.superview);
    }];

    slider.popUpViewCornerRadius = 10.0;
    [slider setMaxFractionDigitsDisplayed:0];
    [slider setPopUpViewArrowLength:6.f];
    [slider setPopUpViewHeightPaddingFactor:1.2f];
    [slider setPopUpViewWidthPaddingFactor:1.5f];
    slider.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
    slider.font = [UIFont fontWithName:@"GillSans-Bold" size:22];
    slider.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];

}

- (void)onChangeSlider:(UISlider *)slider {
    mosaicsView.editView.paintDegree = (int) slider.value;

//	dispatch_async(dispatch_get_main_queue(), ^{
//		float value = slider.value;
////		[self sliderToChange:value];
//	});
}

- (void)sliderToChange:(float)value {
    lblValue.text = [NSString stringWithFormat:@"%d", (int) value];
//	UIImage *image = [lblValue toImage];
    [slider setThumbImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [slider setNeedsLayout];
    [toolView2 setNeedsDisplay];
}

- (void)paintBtnAction:(id)sender {
    paintBtn.selected = YES;
    eraseBtn.selected = NO;

    mosaicsView.editView.drawType = 0;
}

- (void)eraseBtnAction:(id)sender {
    paintBtn.selected = NO;
    eraseBtn.selected = YES;

    mosaicsView.editView.drawType = 1;
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

    [self dismissViewControllerAnimated:YES completion:^{
        [self loadMosaicsView:image];
    }];
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
        [assetsLibrary saveImage:[mosaicsView savedImage]
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
