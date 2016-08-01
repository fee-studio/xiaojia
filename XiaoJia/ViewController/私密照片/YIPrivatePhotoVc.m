//
//  YIPrivatePhotoVc.m
//  YIBox
//
//  Created by efeng on 16/2/25.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "YIPrivatePhotoVc.h"
#import "UIScrollView+EmptyDataSet.h"
#import <CTAssetsPickerController/CTAssetsPickerController.h>
#import "YIPhotoListCell.h"
#import "YIPrivateSettingVc.h"
#import "YIPhotoCollectionViewLayout.h"
#import "YIProgressHUD.h"
#import "YIPhotoPreviewViewController.h"
#import "YITransitionPhotoListToPreview.h"


@interface YIPrivatePhotoVc () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,
        CTAssetsPickerControllerDelegate, YIPhotoPreviewViewControllerDelegate, UINavigationControllerDelegate> {
    NSString *privatePhotosPath;
    NSString *privatePhotosPathThumbnail;
    BOOL isEditing;
    UIView *toolbar;

    PHAssetCollection *collection;
}

@property(nonatomic, strong) NSArray *assets;
@property(nonatomic, strong) NSMutableArray *selectedAssets;
@property(nonatomic, strong) NSMutableSet *onlySelectedAssets;


@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@property(nonatomic, strong) PHImageRequestOptions *requestOptions;


@end

@implementation YIPrivatePhotoVc

- (instancetype)init {
    self = [super init];
    if (self) {
        // 默认为非编辑状态
        isEditing = NO;

        NSString *homePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *privatePhotosName = @"private_photos";
        NSString *privatePhotosNameThumbnail = @"thumbnail";
        NSString *albumName = @"album_default";

        // 主图片的家
        BOOL ppSuccess = [NSFileManager createFolder:privatePhotosName atPath:homePath];
        if (ppSuccess) {
            privatePhotosPath = [homePath stringByAppendingPathComponent:privatePhotosName];

            //缩略图片的家
            BOOL ttSuccess = [NSFileManager createFolder:privatePhotosNameThumbnail atPath:privatePhotosPath];
            if (ttSuccess) {
                privatePhotosPathThumbnail = [privatePhotosPath stringByAppendingPathComponent:privatePhotosNameThumbnail];
            }
        }
    }
    return self;
}

- (void)viewDidLoad {
    YIPhotoCollectionViewLayout *pcvl = [[YIPhotoCollectionViewLayout alloc] init];
    self.layout = pcvl;

    [super viewDidLoad];

    // init properties
    self.assets = [[NSMutableArray alloc] init];

    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    self.dateFormatter.timeStyle = NSDateFormatterMediumStyle;

    self.requestOptions = [[PHImageRequestOptions alloc] init];
    self.requestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    self.requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;

    self.edgesForExtendedLayout = UIRectEdgeNone;

    // 空数据时显示配置
    self.baseCollectionView.emptyDataSetSource = self;
    self.baseCollectionView.emptyDataSetDelegate = self;
    [self.baseCollectionView reloadEmptyDataSet];

    [self.baseCollectionView registerClass:[YIPhotoListCell class] forCellWithReuseIdentifier:@"YIPhotoListCell"];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"设置"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(passwrodSettingTapped:)];

    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(editPrivatePhotoAction:)];
    self.navigationItem.rightBarButtonItems = @[item, editItem];

    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitleColor:kAppColorMain forState:UIControlStateNormal];
    [addBtn setBackgroundColor:kAppColorWhite];
    [addBtn setTitle:@"添加照片" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(pickAssets:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@49);
    }];
    UIView *topBoard = [UIView new];
    topBoard.backgroundColor = kAppColorMain;
    topBoard.userInteractionEnabled = NO;
    [addBtn addSubview:topBoard];
    [topBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(topBoard.superview);
        make.trailing.equalTo(topBoard.superview);
        make.top.equalTo(topBoard.superview);
        make.height.equalTo(@5);
    }];

    // 重设collection view的大小
    [self.baseCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(addBtn.mas_top);
    }];

    [self loadLocationgPhotoFile];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//	self.navigationController.delegate = self;
}

#pragma mark - 编辑按钮

// 编辑按键切换
- (void)editPrivatePhotoAction:(UIBarButtonItem *)item {
    isEditing = !isEditing;
    self.baseCollectionView.allowsMultipleSelection = isEditing;
    item.title = isEditing ? @"退出编辑" : @"编辑";
    // 显示工具栏
    [self showToolbar:isEditing];

    if (isEditing) {
        self.selectedAssets = [NSMutableArray array];
        self.onlySelectedAssets = [NSMutableSet set];
        [_assets enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            [self.selectedAssets addObject:@(0)];
        }];
    } else {
        self.selectedAssets = nil;
        self.onlySelectedAssets = nil;
    }

    // 显示可选择的层
    NSArray *visibleCells = [self.baseCollectionView visibleCells];
    [visibleCells enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        YIPhotoListCell *cell = (YIPhotoListCell *) obj;
        cell.unselectedView.hidden = !isEditing;
        cell.selectedView.hidden = YES;
    }];
}

#pragma mark - 加载本地私密照片

- (void)loadLocationgPhotoFile {
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:privatePhotosPathThumbnail error:nil];
    self.assets = files;
    [self.baseCollectionView reloadData];
}

- (void)passwrodSettingTapped:(UIBarButtonItem *)item {
    YIPrivateSettingVc *vc = [[YIPrivateSettingVc alloc] init];
    YIBaseNavigationController *bnc = [[YIBaseNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:bnc animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"placeholder_dropbox"];
}

/*
 - (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
	NSMutableDictionary *attributes = [NSMutableDictionary new];
	
	NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
	paragraph.lineBreakMode = NSLineBreakByWordWrapping;
	paragraph.alignment = NSTextAlignmentCenter;
	
	NSString *text = nil;
	UIFont *font = nil;
	UIColor *textColor = nil;
	
	text = @"Favorites are saved for offline access.";
	font = [UIFont systemFontOfSize:14.5];
	textColor = [UIColor colorFromHexString:@"7b8994"];
	
	if (font) [attributes setObject:font forKey:NSFontAttributeName];
	if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
	if (paragraph) [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
	
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
	
	return attributedString;
 }
 
 - (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
 {
	return [[NSAttributedString alloc] initWithString:@"添加私密照片"];
 }
 */

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor colorFromHexString:@"f0f3f5"];
}

#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    NSLog(@"%s", __FUNCTION__);
    [self pickAssets:nil];
}

- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView {
    NSLog(@"%s", __FUNCTION__);
    [self pickAssets:nil];
}

#pragma mark -

- (void)pickAssets:(id)sender {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{

            // init picker
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];

            // set delegate
            picker.delegate = self;

            // create options for fetching photo only
            PHFetchOptions *fetchOptions = [PHFetchOptions new];
            fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %d", PHAssetMediaTypeImage];

            // assign options
            picker.assetsFetchOptions = fetchOptions;

            // set initial selected assets
            //			picker.selectedAssets = [NSMutableArray arrayWithArray:self.assets];

            // to present picker as a form sheet in iPad
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                picker.modalPresentationStyle = UIModalPresentationFormSheet;

            // present picker
            [self presentViewController:picker animated:YES completion:nil];

        });
    }];
}

#pragma mark - 显示工具栏

- (void)showToolbar:(BOOL)isShow {
    if (toolbar == nil) {
        toolbar = [UIView new];
        toolbar.backgroundColor = kAppColorMain;
        [self.view addSubview:toolbar];
        [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
            make.height.equalTo(@49);
        }];
        UIView *topBoard = [UIView new];
        topBoard.backgroundColor = kAppColorOrange;
        topBoard.userInteractionEnabled = NO;
        [toolbar addSubview:topBoard];
        [topBoard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(topBoard.superview);
            make.trailing.equalTo(topBoard.superview);
            make.top.equalTo(topBoard.superview);
            make.height.equalTo(@5);
        }];


        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //		deleteBtn.backgroundColor = kAppColorMain;
        [deleteBtn setImage:[UIImage imageNamed:@"iconfont-shanchu"] forState:UIControlStateNormal];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteSeletedPhotosAction) forControlEvents:UIControlEventTouchUpInside];
        [toolbar addSubview:deleteBtn];

        UIButton *publicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //		publicBtn.backgroundColor = kAppColorMain;
        [publicBtn setImage:[UIImage imageNamed:@"iconfont-iconfontsuo"] forState:UIControlStateNormal];
        [publicBtn setTitle:@"解密" forState:UIControlStateNormal];
        [publicBtn addTarget:self action:@selector(publicSelectedPhotosAction) forControlEvents:UIControlEventTouchUpInside];
        [toolbar addSubview:publicBtn];

        UIButton *allSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //		allSelectBtn.backgroundColor = kAppColorMain;
        [allSelectBtn setImage:[UIImage imageNamed:@"iconfont-select"] forState:UIControlStateNormal];
        [allSelectBtn setImage:[UIImage imageNamed:@"iconfont-unselect"] forState:UIControlStateSelected];
        [allSelectBtn setTitle:@"全选" forState:UIControlStateNormal];
        [allSelectBtn setTitle:@"全不选" forState:UIControlStateSelected];
        [allSelectBtn addTarget:self action:@selector(allSeletedPhotosAction:) forControlEvents:UIControlEventTouchUpInside];
        [toolbar addSubview:allSelectBtn];

        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(toolbar);
            make.left.equalTo(toolbar);
            make.right.equalTo(publicBtn.mas_left);
            make.height.equalTo(toolbar);
            make.width.equalTo(publicBtn);
        }];
        [publicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(toolbar);
            make.left.equalTo(deleteBtn.mas_right);
            make.right.equalTo(allSelectBtn.mas_left);
            make.height.equalTo(toolbar);
            make.width.equalTo(allSelectBtn);
        }];
        [allSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(toolbar);
            make.left.equalTo(publicBtn.mas_right);
            make.right.equalTo(toolbar);
            make.height.equalTo(toolbar);
            make.width.equalTo(deleteBtn);
        }];
    }

    toolbar.hidden = !isShow;
}

#pragma mark - 编辑的三种操作

- (void)deleteSeletedPhotosAction {
    if (_onlySelectedAssets.count) {
        RIButtonItem *cancelItem = [RIButtonItem itemWithLabel:@"取消" action:^{

        }];

        RIButtonItem *deleteItem = [RIButtonItem itemWithLabel:@"删除" action:^{
            [self deleteSelectedPhotos];
            [YIProgressHUD showProgressHUDText:@"搞定！"];
        }];

        [[[UIAlertView alloc] initWithTitle:@"删除后将无法恢复，请确认是否删除"
                                    message:nil
                           cancelButtonItem:cancelItem
                           otherButtonItems:deleteItem, nil] show];
    } else {
        [YIProgressHUD showProgressHUDText:@"请先选择照片"];
    }
}

- (void)publicSelectedPhotosAction {
    if (_onlySelectedAssets.count) {
        RIButtonItem *deleteItem = [RIButtonItem itemWithLabel:@"删除" action:^{
            [self publicSelectedPhotos:YES];
        }];

        RIButtonItem *keepItem = [RIButtonItem itemWithLabel:@"保留" action:^{
            [self publicSelectedPhotos:NO];
        }];

        [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"解密后的照片将保存到相册%@，是否要从这里删除？", [YICommonUtil appName]]
                                    message:nil
                           cancelButtonItem:deleteItem
                           otherButtonItems:keepItem, nil] show];
    } else {
        [YIProgressHUD showProgressHUDText:@"请先选择照片"];
    }
}

- (void)allSeletedPhotosAction:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        [_assets enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            [_selectedAssets replaceObjectAtIndex:idx withObject:obj];
            [_onlySelectedAssets addObject:obj];
        }];
    } else {
        [_assets enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            [_selectedAssets replaceObjectAtIndex:idx withObject:@(0)];
            if ([_onlySelectedAssets containsObject:obj]) {
                [_onlySelectedAssets removeObject:obj];
            }
        }];
    }

    NSArray *visibleCells = [self.baseCollectionView visibleCells];
    [visibleCells enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        YIPhotoListCell *cell = (YIPhotoListCell *) obj;
        cell.selectedView.hidden = !button.selected;
    }];
}

- (void)deleteSelectedPhotos {
    [_onlySelectedAssets enumerateObjectsUsingBlock:^(id _Nonnull obj, BOOL *_Nonnull stop) {
        [NSFileManager deleteFile:obj atPath:privatePhotosPath];
        [NSFileManager deleteFile:obj atPath:privatePhotosPathThumbnail];
        [_selectedAssets enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
            if ([obj isKindOfClass:[NSString class]]) {
                [_selectedAssets removeObject:obj];
            }
        }];
        [_onlySelectedAssets removeObject:obj];
        [self loadLocationgPhotoFile];
    }];
}

- (void)publicSelectedPhotos:(BOOL)willDelete {

    collection = [self getCollection];


    [_onlySelectedAssets enumerateObjectsUsingBlock:^(id _Nonnull obj, BOOL *_Nonnull stop) {
        [self saveImage:[privatePhotosPath stringByAppendingPathComponent:obj] completionHandler:^(BOOL success, NSError *_Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    if (willDelete) {
                        [self deleteSelectedPhotos];
                    }
                    [YIProgressHUD showProgressHUDText:@"搞定！"];
                }
            });
        }];
    }];
}

#pragma mark - 保存照片

- (void)saveImage:(NSString *)imagePath completionHandler:(nullable void (^)(BOOL success, NSError *__nullable error))completionHandler; {
    //保存图片
    __block NSString *assetId = nil;
    // 1. 存储图片到"相机胶卷"
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        NSURL *url = [NSURL fileURLWithPath:imagePath];
        // 新建一个PHAssetCreationRequest对象
        // 返回PHAsset(图片)的字符串标识
        assetId = [PHAssetCreationRequest creationRequestForAssetFromImageAtFileURL:url].placeholderForCreatedAsset.localIdentifier;
    }                                 completionHandler:^(BOOL success, NSError *_Nullable error) {
        // 2. 获得相册对象
//		PHAssetCollection *collection = [self getCollection];
        // 3. 将“相机胶卷”中的图片添加到新的相册
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
            NSLog(@"%@", [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil]);
            // 根据唯一标示获得相片对象
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
            // 添加图片到相册中
            [request addAssets:@[asset]];
        }                                 completionHandler:^(BOOL success, NSError *_Nullable error) {
            NSLog(@"成功保存到相簿：%@", collection.localizedTitle);
            completionHandler(success, error);
        }];
    }];
}

- (PHAssetCollection *)getCollection {
    // 先获得之前创建过的相册
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                                                                    subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:[YICommonUtil appName]]) {
            return collection;
        }
    }

    // 如果相册不存在,就创建新的相册(文件夹)
    __block NSString *collectionId = nil; // __block修改block外部的变量的值
    // 这个方法会在相册创建完毕后才会返回
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 新建一个PHAssertCollectionChangeRequest对象, 用来创建一个新的相册
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:[YICommonUtil appName]].placeholderForCreatedAssetCollection.localIdentifier;
    }                                                    error:nil];

    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject;
}


#pragma mark - Assets Picker Delegate

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    [picker dismissViewControllerAnimated:YES completion:nil];

    [self saveSelectedPhotosToLocation:assets];
}

- (void)saveSelectedPhotosToLocation:(NSArray *)assets {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = [NSString stringWithFormat:@"正在加密照片"];

    __block int savedCount = 0;

    [assets enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([obj isKindOfClass:[PHAsset class]]) {
            PHAsset *asset = (PHAsset *) obj;
            PHImageManager *manager = [PHImageManager defaultManager];
            [manager requestImageForAsset:asset
                               targetSize:PHImageManagerMaximumSize
                              contentMode:PHImageContentModeDefault
                                  options:[[PHImageRequestOptions alloc] init]
                            resultHandler:^(UIImage *image, NSDictionary *info) {
                                NSString *extension = [info[@"PHImageFileURLKey"] pathExtension];
                                NSString *name = [info[@"PHImageFileURLKey"] lastPathComponent];
                                NSData *data;
                                NSData *thumbnailData;
                                CGFloat oriW = image.size.width;
                                CGFloat oriH = image.size.height;
                                UIImage *thumbnailImage = [UIImage scaleImage:image toSize:CGSizeMake(200, 200 * oriH / oriW)];
                                if ([extension isEqualToString:@"JPG"] || [extension isEqualToString:@"JPEG"]) {
                                    data = UIImageJPEGRepresentation(image, 1);
                                    thumbnailData = UIImageJPEGRepresentation(thumbnailImage, 1);
                                } else {
                                    data = UIImagePNGRepresentation(image);
                                    thumbnailData = UIImagePNGRepresentation(image);
                                }

                                NSString *millisecond = [self millisecond];
                                NSString *uuid = [[NSUUID UUID] UUIDString];
                                NSString *filename = [NSString stringWithFormat:@"%@-%@-%@", millisecond, uuid, name];

                                // 保存图片与缩略图
                                [NSFileManager saveData:data withName:filename atPath:privatePhotosPath];
                                [NSFileManager saveData:thumbnailData withName:filename atPath:[privatePhotosPath stringByAppendingPathComponent:@"thumbnail"]];
                                // 记数加1
                                savedCount++;

                                if (savedCount == assets.count) {
                                    [self loadLocationgPhotoFile];
                                    [hud hide:YES];
                                }
                            }];
        }
    }];
}

- (NSString *)millisecond {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd_HH:mm:ss.SSS"];
    NSString *milisecond = [dateFormatter stringFromDate:[NSDate date]];
    return milisecond;
}

#pragma mark -  UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YIPhotoListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YIPhotoListCell" forIndexPath:indexPath];
    id asset = _assets[indexPath.item];
    if ([asset isKindOfClass:[NSString class]]) {
        [cell setupCell:asset relativePath:privatePhotosPathThumbnail];
    } else {
        [cell setupCell:asset];
    }

    cell.unselectedView.hidden = !isEditing;

    if (isEditing) {
        id item = _selectedAssets[indexPath.item];
        if ([item isKindOfClass:[NSNumber class]] && [item intValue] == 0) {
            cell.selectedView.hidden = YES;
        } else {
            cell.selectedView.hidden = NO;
        }
    } else {
        cell.selectedView.hidden = YES;
    }

    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark -  UICollectionViewDelegate

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (isEditing) {
        [self toggleSelectedView:indexPath];
    } else {
        YIPhotoPreviewViewController *ppvc = [[YIPhotoPreviewViewController alloc] init];
        ppvc.photoParentPath = privatePhotosPath;
        ppvc.photoArray = [NSMutableArray arrayWithArray:_assets];
        ppvc.curIndexPath = indexPath;
        ppvc.delegate = self;
        [self.navigationController pushViewController:ppvc animated:YES];
    }
}

//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (isEditing) {
        [self toggleSelectedView:indexPath];
    } else {
//		YIPreviewLayout *pl = [[YIPreviewLayout alloc] init];
//		YIPhotoPreviewViewController *ppvc = [[YIPhotoPreviewViewController alloc] init];
//		ppvc.customCVLayout = pl;
//		ppvc.photoArray = [NSMutableArray arrayWithArray:_thumbPictureArray];
//		ppvc.curIndexPath = indexPath;
//		ppvc.delegate = self;
//		ppvc.oriSize = [[collectionView cellForItemAtIndexPath:indexPath] bounds].size;
//		NSLog(@"item = %d, secion = %d",indexPath.item,indexPath.section);
//		[self.navigationController pushViewController:ppvc animated:YES];
    }

}

- (void)toggleSelectedView:(NSIndexPath *)indexPath {
    if (isEditing) {
        YIPhotoListCell *cell = (YIPhotoListCell *) [self.baseCollectionView cellForItemAtIndexPath:indexPath];
        id item = _selectedAssets[indexPath.item];
        NSString *asset = _assets[indexPath.item];
        if ([item isKindOfClass:[NSNumber class]] && [item intValue] == 0) {
            [_selectedAssets replaceObjectAtIndex:indexPath.item withObject:asset];
            cell.selectedView.hidden = NO;
            [_onlySelectedAssets addObject:asset];
        } else {
            [_selectedAssets replaceObjectAtIndex:indexPath.item withObject:@(0)];
            cell.selectedView.hidden = YES;
            if ([_onlySelectedAssets containsObject:asset]) {
                [_onlySelectedAssets removeObject:asset];
            }
        }
    }
}

#pragma mark - UINavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {

    if (fromVC == self && [toVC isKindOfClass:[YIPhotoPreviewViewController class]]) {
        return [[YITransitionPhotoListToPreview alloc] init];
    } else {
        return nil;
    }
}

#pragma mark - YIPhotoPreviewViewControllerDelegate

- (void)myScrollToItemAtIndexPath:(NSIndexPath *)indexPath {

    [self.baseCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
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
