//
//  YIToolPickerVc.m
//  YIBox
//
//  Created by efeng on 16/7/14.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "YIToolPickerVc.h"

@interface YIToolPickerVc ()

@property(nonatomic, strong) NSArray *tools;

@end

@implementation YIToolPickerVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self loadData];
}

#pragma mark -

- (void)loadData {
    NSString *pathDefaultToolPlist = [[NSBundle mainBundle] pathForResource:@"default-tool" ofType:@"plist"];
    NSArray *willTools = [NSArray arrayWithContentsOfFile:pathDefaultToolPlist];

    self.tools = willTools;
    [self.baseTableView reloadData];
}

#pragma mark - table view delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _tools.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tools[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"IndexCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }

    id targetObject = _tools[indexPath.section][indexPath.row][@"target"];
    if ([targetObject isEqual:mGlobalData.homeVc]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    cell.imageView.image = [UIImage imageNamed:_tools[indexPath.section][indexPath.row][@"image"]];
    cell.textLabel.text = _tools[indexPath.section][indexPath.row][@"name"];
    cell.textLabel.textColor = kAppColorTextDeep;
    cell.detailTextLabel.text = _tools[indexPath.section][indexPath.row][@"detail"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    id targetObject = _tools[indexPath.section][indexPath.row][@"target"];
    NSNumber *itemId = _tools[indexPath.section][indexPath.row][@"id"];
    NSInteger itemIdCode = [itemId integerValue];

    // 设置为默认的vc
    [mGlobalData setHomeVc:targetObject];

    [self.baseTableView reloadData];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
{
    if (section == 0) {
        return @"下次启动应用将直接进入所选工具哦！";
    } else {
        return @"";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section; {
    if (section == 0) {
        return 40;
    } else {
        return 0;
    }
}


#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
