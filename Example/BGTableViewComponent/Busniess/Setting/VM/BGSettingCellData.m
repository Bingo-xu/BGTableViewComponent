//
//  BGSettingCellData.m
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/10.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import "BGSettingCellData.h"


@implementation BGSettingCellData

+ (BGTableViewRowData *)creatCellDataWith:(NSString* )title eventType:(BGSettingCellEventType)eventType bottomLineShow:(BOOL)bottomLineShow {
    BGSettingCellData*model = [BGSettingCellData new];
    model.title = title;
    model.bottomLineShow = bottomLineShow;
    BGTableViewRowData *data = [BGTableViewRowData creatDataWith:@"BGSettingTableViewCell" data:model cellHeight:55 cellEventType:eventType];
    return data;
}

+ (BGTableViewSectionData*)creatSectionData {
    BGTableViewSectionData*sectionData = [BGTableViewSectionData new];
    sectionData.header = [BGTableViewSection creatSectionWith:[UIView new] height:15];
    return sectionData;
}

+ (NSArray* )creatDataSource {
    //第一组
    BGTableViewSectionData*sectionData0 = [self creatSectionData];
    sectionData0.dataList = @[[self creatCellDataWith:@"账号管理" eventType:BGSettingCellEventTypeAcountManagement bottomLineShow:NO]];
    //第二组
    BGTableViewSectionData*sectionData1 = [self creatSectionData];
    NSMutableArray *secs1 = [NSMutableArray new];
    [secs1 addObject:[self creatCellDataWith:@"安全设置" eventType:BGSettingCellEventTypeSafeSetting bottomLineShow:YES]];
    
    BGTableViewRowData *smsData = [self creatCellDataWith:@"短信通知" eventType:BGSettingCellEventTypeSMS bottomLineShow:YES];
    [(BGSettingCellData*)smsData.data setStyle:BGSettingCellStyleTypeSwitch];
    [secs1 addObject:smsData];
    
    //恢复交易有权限，默认隐藏
    BGTableViewRowData *trData = [self creatCellDataWith:@"恢复交易" eventType:BGSettingCellEventTypeTradingResumed bottomLineShow:YES];
    [secs1 addObject:trData];
    sectionData1.dataList = secs1;
    
    //第三组
    BGTableViewSectionData*sectionData2 = [self creatSectionData];
    sectionData2.dataList = @[[self creatCellDataWith:@"账号注销" eventType:BGSettingCellEventTypeAccountCancellation bottomLineShow:NO]];
 
    //第四组
    BGTableViewSectionData*sectionData3 = [self creatSectionData];
    BGTableViewRowData *normallyData = [self creatCellDataWith:@"APP屏幕常亮" eventType:BGSettingCellEventTypeNormally  bottomLineShow:NO];
    BGSettingCellData *cellData = normallyData.data;
    cellData.style = BGSettingCellStyleTypeSwitch;
    cellData.switchOn = YES;
    sectionData3.dataList = @[normallyData];
    
    //第五组
    BGTableViewSectionData*sectionData4 = [self creatSectionData];
    sectionData4.dataList = @[
        [self creatCellDataWith:@"隐私政策" eventType:BGSettingCellEventTypePrivacy bottomLineShow:YES],
        [self creatCellDataWith:@"用户协议" eventType:BGSettingCellEventTypeUserAgreement bottomLineShow:YES],
        [self creatCellDataWith:@"第三方SDK列表" eventType:BGSettingCellEventTypeSDK bottomLineShow:YES],
        [self creatCellDataWith:@"个人信息收集清单" eventType:BGSettingCellEventTypePrivateInfoList bottomLineShow:YES],
        [self creatCellDataWith:@"应用权限" eventType:BGSettingCellEventTypeAPPLimit bottomLineShow:NO]
                            ];
    NSMutableArray* dataSource = [NSMutableArray new];
    [dataSource addObject:sectionData0];
    [dataSource addObject:sectionData1];
    [dataSource addObject:sectionData2];
    [dataSource addObject:sectionData3];
    [dataSource addObject:sectionData4];
    return dataSource;
}

@end
