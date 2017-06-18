//
// Created by efeng on 16/9/3.
// Copyright (c) 2016 buerguo. All rights reserved.
//

#import "YIAddFamilyVc.h"
#import "YITextField.h"
#import "RLMRealm.h"
#import "YIFamily.h"

@interface YIAddFamilyVc () {

    YITextField *textField;
    UIBarButtonItem *finishItem;
}

@end

@implementation YIAddFamilyVc {

}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"添加家庭名";
    self.edgesForExtendedLayout = UIRectEdgeNone;

    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(cancelItemAction:)];
    self.navigationItem.leftBarButtonItem = cancelItem;


    finishItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                  style:UIBarButtonItemStylePlain
                                                 target:self
                                                 action:@selector(finishItemAction:)];
    self.navigationItem.rightBarButtonItem = finishItem;

    finishItem.enabled = (BOOL) textField.text.length;

    [self loadUI];
}

- (void)loadUI {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = kAppColorGray;
    label.text = @"名字";
    label.font = kAppSmlFont;
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.superview).offset(10);
        make.top.equalTo(label.superview).offset(10);
        make.width.equalTo(label.superview);
        make.height.equalTo(@20);
    }];

    textField = [[YITextField alloc] init];
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    textField.backgroundColor = kAppColorWhite;
    textField.placeholder = @"请输入您家庭的代号，如：FYY的家庭";
    [self.view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textField.superview);
        make.top.equalTo(label.mas_bottom).offset(5);
        make.width.equalTo(textField.superview);
        make.height.equalTo(@44);
    }];
}

- (void)cancelItemAction:(UIBarButtonItem *)item {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)finishItemAction:(UIBarButtonItem *)item {

    [[RLMRealm defaultRealm] beginWriteTransaction];
    YIFamily *family = [[YIFamily alloc] init];
    family.name = textField.text;
    [[RLMRealm defaultRealm] addObject:family];
    [[RLMRealm defaultRealm] commitWriteTransaction];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textFieldDidChange:(UITextField *)theTextField {
    NSLog(@"text changed: %@", theTextField.text);

    finishItem.enabled = (BOOL) theTextField.text.length;
}


@end
