//
// Created by efeng on 16/7/13.
// Copyright (c) 2016 buerguo. All rights reserved.
//

#import "YISettingVc.h"

@interface YISettingVc () {

}

@property(nonatomic, strong) NSArray *settingOptions;

@end

@implementation YISettingVc


- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];
}

- (void)loadData {
    NSString *pathIndexPlist = [[NSBundle mainBundle] pathForResource:@"setting" ofType:@"plist"];
    self.settingOptions = [NSArray arrayWithContentsOfFile:pathIndexPlist];
    [self.baseTableView reloadData];
}

#pragma mark - table view delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _settingOptions.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_settingOptions[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"IndexCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.imageView.image = [UIImage imageNamed:_settingOptions[indexPath.section][indexPath.row][@"image"]];
    cell.textLabel.text = _settingOptions[indexPath.section][indexPath.row][@"name"];
    cell.textLabel.textColor = kAppColorTextDeep;
    cell.detailTextLabel.text = _settingOptions[indexPath.section][indexPath.row][@"detail"];
    cell.detailTextLabel.font = kAppSmlFont;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    id target = _settingOptions[indexPath.section][indexPath.row][@"target"];

    Class targetClass = NSClassFromString(target);
    YIBaseViewController *vc = [[targetClass alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end