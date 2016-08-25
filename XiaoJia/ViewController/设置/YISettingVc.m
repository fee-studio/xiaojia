//
// Created by efeng on 16/7/13.
// Copyright (c) 2016 buerguo. All rights reserved.
//

#import "YISettingVc.h"

#if __has_include("YWFeedbackServiceFMWK/YWFeedbackServiceFMWK.h")
#import <YWFeedbackServiceFMWK/YWFeedbackServiceFMWK.h>
#define HAS_FEEDBACK 1
#endif


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
	
	NSDictionary *option = _settingOptions[indexPath.section][indexPath.row];
	id target = option[@"target"];
	NSInteger index = [option[@"id"] integerValue];
	
	if (target && ![target isEqual:@""]) {
		Class targetClass = NSClassFromString(target);
		YIBaseViewController *vc = [[targetClass alloc] init];
		[self.navigationController pushViewController:vc animated:YES];
	} else {
		if (index == 1002) {
			
			__weak typeof(self) weakSelf = self;
			[YWAnonFeedbackService makeFeedbackConversationWithCompletionBlock:^(YWFeedbackConversation *conversation, NSError *error) {
				if ( conversation != nil ) {
					YWFeedbackViewController *feedback = [[mAppDelegate ywIMKit] makeFeedbackViewControllerWithConversation:conversation];
					[weakSelf.navigationController pushViewController:feedback animated:YES];
					
					
//					if ( [aViewController isKindOfClass:[UINavigationController class]] ) {
//						UINavigationController *nav = (UINavigationController *)aViewController;
//						[nav setNavigationBarHidden:NO animated:YES];
//						[nav pushViewController:feedback animated:YES];
//					} else {
//						if ( aViewController.navigationController ) {
//							[aViewController.navigationController setNavigationBarHidden:NO animated:NO];
//							[aViewController.navigationController pushViewController:feedback animated:YES];
//						} else {
//							UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedback];
//							
//							UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain andBlock:^{
//								[aViewController dismissViewControllerAnimated:YES completion:nil];
//							}];
//							
//							feedback.navigationItem.rightBarButtonItem = rightBarButtonItem;
//							
//							[aViewController presentViewController:navigationController animated:YES completion:nil];
//						}
//					}
				} else {
//					[[SPUtil sharedInstance] showNotificationInViewController:nil title:@"反馈页面打开出错"
//																	 subtitle:[NSString stringWithFormat:@"%@", error]
//																		 type:SPMessageNotificationTypeError];
				}
			}];
			 
		} else {
			
		}
	}
}


@end