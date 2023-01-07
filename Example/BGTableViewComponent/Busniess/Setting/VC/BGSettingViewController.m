//
//  BGSettingViewController.m
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/10.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import "BGSettingViewController.h"
#import <BGTableViewComponent/BGTableViewComponent.h>
#import "BGDefine.h"
#import "BGSettingTableViewCell.h"
#import "BGSettingFooterView.h"
#import "BGSettingCellData.h"

@interface BGSettingViewController ()<BGTableViewDelegate>
@property (nonatomic, strong) BGTableViewComponent *tableViewComponent;
@property (nonatomic, strong) BGSettingFooterView *footerView;

@end

@implementation BGSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableViewComponent resetDataSourecs:[BGSettingCellData creatDataSource]];
    self.tableViewComponent.tableView.tableFooterView = self.footerView;
}

- (void)logoutAction {
    NSLog(@"退出登录");
}

#pragma mark-BGTableViewDelegate
- (void)bg_selecteCellImplementationWithCell:(UITableViewCell *)cell data:(BGTableViewRowData *)data {
    NSInteger eventType = data.selecteCellEventType;
    switch (eventType) {
        case BGSettingCellEventTypeAcountManagement:
            NSLog(@"账号管理");
            break;
        case BGSettingCellEventTypeSafeSetting:
            NSLog(@"安全设置");
            break;
        case BGSettingCellEventTypeTradingResumed:
            NSLog(@"恢复交易");
            break;
        case BGSettingCellEventTypeAdvice:
            NSLog(@"建议");
            break;
        case BGSettingCellEventTypeAccountCancellation:
            // 去检查是否应该注销账户
            NSLog(@"注销账户");
            break;
        case BGSettingCellEventTypePrivacy:
            NSLog(@"隐私政策");
            break;
        case BGSettingCellEventTypeUserAgreement:
            NSLog(@"用户协议");
            break;
        case BGSettingCellEventTypeSDK:
            NSLog(@"SDK");
            break;
        case BGSettingCellEventTypePrivateInfoList:
            NSLog(@"InfoList");
            break;
        case BGSettingCellEventTypeAPPLimit:
            NSLog(@"APPLimit");
            break;
        default:
            break;
    }
}

- (void)bg_clickCellOtherEventImplementationWithCell:(UITableViewCell *)cell data:(BGTableViewRowData *)data eventType:(NSInteger)eventType otherParameters:(NSDictionary *)otherParameters {
    BOOL switchOn = [[otherParameters valueForKey:@"isOn"] boolValue];
    if (data.selecteCellEventType == BGSettingCellEventTypeNormally) { //屏幕常亮
        NSLog(@"屏幕常亮开关%d",switchOn);
    }else if (data.selecteCellEventType == BGSettingCellEventTypeSMS) { //通知短信
        NSLog(@"通知短信开关%d",switchOn);
    }
}

- (BGTableViewComponent *)tableViewComponent {
    if (!_tableViewComponent) {
        _tableViewComponent = [BGTableViewComponent initWithTableViewStyle:UITableViewStylePlain frame:CGRectMake(0,KNavBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - KNavBarHeight - KTabbarHeight) superView:self.view delegate:self];
    }
    return _tableViewComponent;
}


@end
