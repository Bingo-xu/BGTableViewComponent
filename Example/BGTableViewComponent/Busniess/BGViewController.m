//
//  BGViewController.m
//  BGTableViewComponent
//
//  Created by bingo on 11/06/2022.
//  Copyright (c) 2022 bingo. All rights reserved.
//

#import "BGViewController.h"
#import "BGDefine.h"
#import "BGMessageTableViewCell.h"
#import "UILabel+BGTool.h"
#import "BGSectionView.h"

@interface BGViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"原始列表";
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self closeEstimateHeight];
    
    UIView*headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, CGFLOAT_MIN)];
    headView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = headView;
}

#pragma mark-UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BGSectionView *headView = [BGSectionView new];
    headView.titleLabel.text = [NSString stringWithFormat:@"组头%ld",section];
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击事件通过indexPath判断
    if (indexPath.row == 0) {
        
    }else if (indexPath.row == 1) {
        
    }
    
    [self.navigationController pushViewControllerName:@"BGSettingViewController" info:nil];
}


#pragma mark-UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BGMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BGMessageTableViewCell" forIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,KNavBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - KNavBarHeight - KTabbarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[BGMessageTableViewCell class] forCellReuseIdentifier:@"BGMessageTableViewCell"];
    }
    return _tableView;
}

- (void)closeEstimateHeight {
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    if (@available(iOS 15.0, *)) {//解决顶部会多出一截
        self.tableView.sectionHeaderTopPadding = 0;
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

@end
