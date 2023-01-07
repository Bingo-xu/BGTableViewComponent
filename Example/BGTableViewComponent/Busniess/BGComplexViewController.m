//
//  BGComplexViewController.m
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/9.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import "BGComplexViewController.h"
#import <BGTableViewComponent/BGTableViewComponent.h>
#import "BGDefine.h"
#import "BGTableViewButtonCell.h"
#import "BGSectionView.h"
#import "BGBannerTableViewCell.h"
#import "BGSettingCellData.h"

typedef NS_ENUM(NSUInteger, BGComplexCellStyle) {
    /** 样式一*/
    BGComplexCellStyleTypeOne = 0,
    /** 样式二*/
    BGComplexCellStyleTypeTwo,
    /** 样式三*/
    BGComplexCellStyleTypeThree,
    /** 样式四*/
    BGComplexCellStyleTypeFour,
};

@interface BGComplexViewController ()<BGTableViewDelegate>
@property (nonatomic, strong) BGTableViewComponent *tableViewComponent;

@end

@implementation BGComplexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"复杂列表";
    // Do any additional setup after loading the view.
    [self.tableViewComponent resetDataSourecs:[self creatDataSource]];
}
#pragma mark- 数据处理
- (NSArray*)creatDataSource {
    BGTableViewSectionData *sectionData1 = [BGTableViewSectionData new];
    sectionData1.header = [BGTableViewSection creatSectionWith:[BGSectionView new] height:50 sectionData:@"组头1"];
    sectionData1.footer = [BGTableViewSection creatSectionWith:[BGSectionView new] height:50 sectionData:@"组尾1"];
    
    NSMutableArray*cellArr1 = [NSMutableArray new];
    //第一行
    BGTableViewRowData*cellData = [BGTableViewRowData creatDataWith:@"BGTableViewButtonCell" data:@"BGTableViewButtonCell" cellHeight:105];
    cellData.selecteCellEventType = BGComplexCellStyleTypeOne;
    [cellArr1 addObject:cellData];
    
    NSArray *bannerArr = @[@{@"imgUrl":@"https://cdn.kikakeyboard.com/picture/ios_keyboard/banner/diy_banner2x.png",@"actionUrl":@"kika://custom"},

    @{@"imgUrl":@"https://cdn.kikakeyboard.com/picture/ios_keyboard/banner/avatar_banner2x.png",@"actionUrl":@"kika://avatars"},

                           @{@"imgUrl":@"https://cdn.kikakeyboard.com/picture/ios_keyboard/banner/sticker_banner2x.png",@"actionUrl":@"kika://sticker"}];
    NSMutableArray*bannerModelArr = [NSMutableArray new];
    for (NSDictionary*dic in bannerArr) {
        BGBannerModel *banner = [BGBannerModel new];
        banner.imageUrl = dic[@"imgUrl"];
        banner.actionUrl = dic[@"actionUrl"];
        [bannerModelArr addObject:banner];
    }
    
    //第二行
    BGTableViewRowData*cellData2 = [BGTableViewRowData creatDataWith:@"BGBannerTableViewCell" data:bannerModelArr cellHeight:[BGBannerTableViewCell bg_getTableViewCellHeightWithData:nil]];
    cellData2.selecteCellEventType = BGComplexCellStyleTypeTwo;
    [cellArr1 addObject:cellData2];
    
    //第三行
    BGTableViewRowData *smsData = [BGSettingCellData creatCellDataWith:@"短信通知" eventType:BGComplexCellStyleTypeThree bottomLineShow:YES];
    [(BGSettingCellData*)smsData.data setStyle:BGSettingCellStyleTypeSwitch];
    [cellArr1 addObject:smsData];
    
    
    BGTableViewRowData*cellData4 = [BGTableViewRowData creatDataWith:@"BGMessageTableViewCell" data:@"" cellHeight:150];
    cellData4.selecteCellEventType = BGComplexCellStyleTypeFour;
    [cellArr1 addObject:cellData4];
    
    sectionData1.dataList = cellArr1;
    
    
    
    BGTableViewSectionData *sectionData2 = [BGTableViewSectionData new];
    sectionData2.header = [BGTableViewSection creatSectionWith:[BGSectionView new] height:50 sectionData:@"组头2"];

    NSMutableArray*cellArr2 = [NSMutableArray new];
    
    BGTableViewRowData*cellData5 = [BGTableViewRowData creatDataWith:@"BGMessageTableViewCell" data:@"" cellHeight:150];
    cellData5.selecteCellEventType = BGComplexCellStyleTypeFour;
    [cellArr2 addObject:cellData5];
    

    BGTableViewRowData*cellData6 = [BGTableViewRowData creatDataWith:@"BGBannerTableViewCell" data:bannerModelArr cellHeight:[BGBannerTableViewCell bg_getTableViewCellHeightWithData:nil]];
    cellData6.selecteCellEventType = BGComplexCellStyleTypeTwo;
    [cellArr2 addObject:cellData6];
    
    sectionData2.dataList = cellArr2;
    
    return @[sectionData1,sectionData2];
}


#pragma mark-BGTableViewDelegate
- (void)bg_selecteCellImplementationWithCell:(UITableViewCell *)cell data:(BGTableViewRowData *)data {
    NSInteger type = data.selecteCellEventType;
    NSLog(@"cell选中事件%ld",type);
}

- (void)bg_clickCellOtherEventImplementationWithCell:(UITableViewCell *)cell data:(BGTableViewRowData *)data eventType:(NSInteger)eventType otherParameters:(NSDictionary *)otherParameters {
    NSInteger type = data.selecteCellEventType;
    if (type == BGComplexCellStyleTypeTwo) { //banner点击事件
        BGBannerModel *banner = [otherParameters valueForKey:@"model"];
        NSLog(@"广告点击地址：%@",banner.actionUrl);
    }else if (type == BGComplexCellStyleTypeThree) { //通知短信
        BOOL switchOn = [[otherParameters valueForKey:@"isOn"] boolValue];
        NSLog(@"通知短信开关%d",switchOn);
    }else if (type == BGComplexCellStyleTypeOne) { //BGTableViewButtonCell
        if (eventType == BGTableViewCellOtherEventTypeOne) {
            NSLog(@"cell类型%ld  事件一",data.selecteCellEventType);
            [self.navigationController pushViewControllerName:@"BGSettingViewController" info:nil];
        }else if (eventType == BGTableViewCellOtherEventTypeTwo) {
            NSLog(@"cell类型%ld  事件二",data.selecteCellEventType);
        }else if (eventType == BGTableViewCellOtherEventTypeThree) {
            NSLog(@"cell类型%ld  事件三",data.selecteCellEventType);
        }
    }
}

- (BGTableViewComponent *)tableViewComponent {
    if (!_tableViewComponent) {
        _tableViewComponent = [BGTableViewComponent initWithTableViewStyle:UITableViewStyleGrouped frame:CGRectMake(0,KNavBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - KNavBarHeight - KTabbarHeight) superView:self.view delegate:self];
    }
    return _tableViewComponent;
}


@end
