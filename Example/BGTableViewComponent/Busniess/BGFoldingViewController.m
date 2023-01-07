//
//  BGFoldingViewController.m
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/7.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import "BGFoldingViewController.h"
#import <BGTableViewComponent/BGTableViewComponent.h>
#import "BGDefine.h"
#import "BGTableViewButtonCell.h"
#import "BGSettingViewController.h"

@interface BGFoldingViewController () <BGTableViewDelegate>
@property (nonatomic, strong) BGTableViewComponent *tableViewComponent;

@end

@implementation BGFoldingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"展开收起";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableViewComponent resetDataSourecs:[self creatDataSource]];
    //
    [self.tableViewComponent getSectionDataModelWith:3];
    
//    [self.tableViewComponent insertRowDataAtIndex:10 cellData:[BGTableViewRowData creatDataWith:@"BGMessageTableViewCellddda" data:[NSString stringWithFormat:@"展开cell第%d行",10] cellHeight:105] section:0];
}

- (NSArray*)creatDataSource {
    NSMutableArray*cellArr = [NSMutableArray new];
    ///不存在的cell数据是会过滤掉
    for (int i = 0; i<10; i++) {
        BGTableViewRowData*cellData = [BGTableViewRowData creatDataWith:@"BGMessageTableViewCellddda" data:[NSString stringWithFormat:@"展开cell第%d行",i] cellHeight:105];
        [cellArr addObject:cellData];
    }
    
    ///真实存在的cell数据
    for (int i = 0; i<10; i++) {
        BGTableViewRowData*cellData = [BGTableViewRowData creatDataWith:@"BGTableViewButtonCell" data:[NSString stringWithFormat:@"展开cell第%d行",i] cellHeight:105];
        cellData.selecteCellEventType = i;
        [cellArr addObject:cellData];
    }
    
    BGTableViewSectionData*sectionData1 = [BGTableViewSectionData new];
    sectionData1.isPackUp = YES;
    sectionData1.header = [BGTableViewSection creatSectionWith:[self headViewWithTag:100] height:50];
    sectionData1.dataList = cellArr;
    BGTableViewSectionData*sectionData2 = [BGTableViewSectionData new];
    sectionData2.isPackUp = YES;
    
    sectionData2.header = [BGTableViewSection creatSectionWith:[self headViewWithTag:200] height:50];
    sectionData2.dataList = cellArr;
    return @[sectionData1,sectionData2];
}

- (void)clickButtonAction:(UIButton*)sender {
    BGTableViewSectionData*sectionData = [self.tableViewComponent getSectionDataModelWith:(sender.tag/100 - 1)];
    sectionData.isPackUp = sender.isSelected;
    sender.selected = !sender.isSelected;
    [self.tableViewComponent reloadData];
}

- (UIView*)headViewWithTag:(NSInteger)tag {
    UIView*view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    UIButton*btn =  [[UIButton alloc] initWithFrame:CGRectMake(w-100, 0, 80, 50)];
    btn.backgroundColor = [UIColor redColor];
    btn.tag = tag;
    [btn setTitle:@"展开" forState:UIControlStateNormal];
    [btn setTitle:@"收起" forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    return view;
}

#pragma mark-BGTableViewDelegate
- (void)bg_selecteCellImplementationWithCell:(UITableViewCell *)cell data:(BGTableViewRowData *)data {
    NSInteger type = data.selecteCellEventType;
    NSLog(@"cell选中事件%ld",type);
}

- (void)bg_clickCellOtherEventImplementationWithCell:(UITableViewCell *)cell data:(BGTableViewRowData *)data eventType:(NSInteger)eventType otherParameters:(NSDictionary *)otherParameters {
    if (eventType == BGTableViewCellOtherEventTypeOne) {
        NSLog(@"cell类型%ld  事件一",data.selecteCellEventType);
        [self.navigationController pushViewControllerName:@"BGSettingViewController" info:nil];
    }else if (eventType == BGTableViewCellOtherEventTypeTwo) {
        NSLog(@"cell类型%ld  事件二",data.selecteCellEventType);
    }else if (eventType == BGTableViewCellOtherEventTypeThree) {
        NSLog(@"cell类型%ld  事件三",data.selecteCellEventType);
    }
}

- (BGTableViewComponent *)tableViewComponent {
    if (!_tableViewComponent) {
        _tableViewComponent = [BGTableViewComponent initWithTableViewStyle:UITableViewStylePlain frame:CGRectMake(0,KNavBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - KNavBarHeight - KTabbarHeight) superView:self.view delegate:self];
    }
    return _tableViewComponent;
}

@end
