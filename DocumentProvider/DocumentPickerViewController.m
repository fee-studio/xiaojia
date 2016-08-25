//
//  DocumentPickerViewController.m
//  DocumentProvider
//
//  Created by efeng on 16/8/1.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "DocumentPickerViewController.h"
#import "YIConfigUtil+UI.h"
#import "HexColor.h"


#define APP_GROUP_ID @"group.com.buerguo.box"
#define APP_FILE_NAME @"XiaoJiaFile"

#define CellIdentifier @"cellIde"


@interface DocumentPickerViewController ()

@end

@implementation DocumentPickerViewController {
    NSArray<NSString *> *fileNamesArray;
    NSString *storagePath;

    __weak IBOutlet UITableView *itemsTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [itemsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    itemsTableView.backgroundColor = [UIColor whiteColor];
	
	
//	UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 44)];
//	[btn setTitle:@"导出到这里啦~" forState:UIControlStateNormal];
//	[btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//	[btn addTarget:self action:@selector(exportFile) forControlEvents:UIControlEventTouchUpInside];
//	btn.backgroundColor = [UIColor grayColor];
//	[self.view addSubview:btn];
	
	NSLog(@"2222");
	
}

- (void)loadData {
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    storagePath = [[self.documentStorageURL path] stringByAppendingPathComponent:APP_FILE_NAME];
    fileNamesArray = [fileMgr contentsOfDirectoryAtPath:storagePath error:nil];
    [itemsTableView reloadData];
}

- (void)prepareForPresentationInMode:(UIDocumentPickerMode)mode {
	NSLog(@"3333");
    switch (mode) {
        case UIDocumentPickerModeImport: {
            self.navigationItem.title = @"请选择导入文件";
        }
            break;
        case UIDocumentPickerModeOpen: {
            self.navigationItem.title = @"请选择打开文件";
        }
            break;

        case UIDocumentPickerModeExportToService: {
            self.navigationItem.title = @"导出文件";
        }
            break;
        case UIDocumentPickerModeMoveToService: {
            self.navigationItem.title = @"移动文件";
        }
        default:
            break;
    }

    [self loadData];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return fileNamesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text = fileNamesArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.documentPickerMode == UIDocumentPickerModeExportToService ||
            self.documentPickerMode == UIDocumentPickerModeMoveToService) {
        return;
    }
    //    NSString *filePath = [storagePath stringByAppendingPathComponent: @"fileNotExist.txt"];
    NSString *filePath = [storagePath stringByAppendingPathComponent:fileNamesArray[indexPath.row]];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    [self dismissGrantingAccessToURL:fileURL];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.documentPickerMode == UIDocumentPickerModeExportToService ||
            self.documentPickerMode == UIDocumentPickerModeMoveToService) {

        NSString *btnTitle = @"导出到这里";
        if (self.documentPickerMode == UIDocumentPickerModeMoveToService) {
            btnTitle = @"移动到这里";
        }

        UIView *tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
		tableFootView.userInteractionEnabled = YES;
        UIButton *btn = [[UIButton alloc] initWithFrame:tableFootView.bounds];
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(exportFile) forControlEvents:UIControlEventTouchUpInside];
		btn.backgroundColor = kAppColorMain;
        [tableFootView addSubview:btn];
        return tableFootView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	if (self.documentPickerMode == UIDocumentPickerModeExportToService ||
		self.documentPickerMode == UIDocumentPickerModeMoveToService) {
		return 44;
	} else {
		return 0.01f;
	}
}

#pragma mark - exportFile

- (void)exportFile {
	NSLog(@"1111");
	
    NSURL *originalURL = self.originalURL;
    NSString *fileName = [originalURL lastPathComponent];
    NSString *exportFilePath = [storagePath stringByAppendingPathComponent:fileName];

    //1. 获取安全访问权限
    BOOL access = [originalURL startAccessingSecurityScopedResource];

    if (access) {
        //2. 通过文件协调器访问读取该文件
        NSFileCoordinator *fileCoordinator = [NSFileCoordinator new];
        NSError *error = nil;
        [fileCoordinator coordinateReadingItemAtURL:originalURL
											options:NSFileCoordinatorReadingWithoutChanges
											  error:&error
										 byAccessor:^(NSURL *_Nonnull newURL) {
            //3.保存文件到共享容器
            [self saveFileFromURL:newURL toFileURL:[NSURL fileURLWithPath:exportFilePath]];
        }];

    }

    //4. 停止安全访问权限
    [originalURL stopAccessingSecurityScopedResource];
}

#pragma mark - saveFile

- (void)saveFileFromURL:(NSURL *)fileURL toFileURL:(NSURL *)toFileURL {
    NSString *fileName = [fileURL lastPathComponent];

    void (^saveBlock)(NSString *) = ^(NSString *newFileName) {
        NSString *fileCont = [NSString stringWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:nil];
        NSURL *saveURL = [toFileURL URLByDeletingLastPathComponent];
        NSURL *newFileURL = [saveURL URLByAppendingPathComponent:newFileName];
        if ([fileCont writeToURL:newFileURL atomically:YES encoding:NSUTF8StringEncoding error:nil]) {
            [self dismissGrantingAccessToURL:newFileURL];
        } else {
            NSLog(@"保存失败");
        }
    };

    if ([fileNamesArray containsObject:fileName]) {
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"是否覆盖已有文件" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"覆盖" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            saveBlock(fileName);
        }]];

        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"更名保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            saveBlock([self getOneSuitableFileName:fileName index:2]);
        }]];
        [self presentViewController:alertCtrl animated:YES completion:nil];

        return;
    }

    saveBlock(fileName);
}

- (NSString *)getOneSuitableFileName:(NSString *)originalName index:(NSInteger)index {
    NSString *pathExtension = [originalName pathExtension];
    NSString *fileNameNoExtension = [originalName stringByDeletingPathExtension];
    fileNameNoExtension = [NSString stringWithFormat:@"%@(%@)", fileNameNoExtension, @(index)];
    NSString *newFileName = [fileNameNoExtension stringByAppendingPathExtension:pathExtension];
    if ([fileNamesArray containsObject:newFileName]) {
        return [self getOneSuitableFileName:originalName index:index + 1];
    } else {
        return newFileName;
    }
}

@end
