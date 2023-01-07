//
//  BGTableviewComponent+DataSource.m
//  BGTableViewComponent
//
//  Created by Bingo on 2022/10/14.
//  Copyright © 2022 xb. All rights reserved.
//

#import "BGTableViewComponent+DataSource.h"
#import "BGThreadSafeMutableArray.h"
#import "BGTableViewSectionData+BGArray.h"
#import "UITableView+BGLayout.h"

@implementation BGTableViewComponent (DataSource)

#pragma mark- 数据源处理
#pragma mark-增
/**单组列表，无组头组尾，重置数据源。内部创建section*/
- (void)bg_resetSingleSectionDataSourecs:(nullable NSArray<BGTableViewRowData*>*)dataArr {
    BGTableViewSectionData *section = [BGTableViewSectionData new];
    section.dataList = dataArr;
    [self resetDataSourecs:@[section]];
}

/**重置数据源*/
- (void)bg_resetDataSourecs:(nullable NSArray<BGTableViewSectionData*>*)dataArr {
    [self addCellDatas:dataArr additional:NO];
}

/**追加数据源*/
- (void)additionalSectionDatas:(nullable NSArray<BGTableViewSectionData*>*)dataArr {
    [self addCellDatas:dataArr additional:YES];
}

/**
 添加某一组的数据源
 分页场景
 */
- (void)addRowCellDatas:(nullable NSArray<BGTableViewRowData*>*)cellDatas section:(NSInteger)section {
    [self dealSectionCellDatasWith:cellDatas section:section isClear:NO];
}

/**
 重置某一组的数据源
 分页场景
 */
- (void)resetRowCellDatas:(nullable NSArray<BGTableViewRowData*>*)cellDatas section:(NSInteger)section {
    [self dealSectionCellDatasWith:cellDatas section:section isClear:YES];
}

- (void)dealSectionCellDatasWith:(nullable NSArray<BGTableViewRowData*>*)cellDatas section:(NSInteger)section isClear:(BOOL)isClear {
    if (!cellDatas || !cellDatas.count) {
        return;
    }
    BGTableViewSectionData*sectionData = [self.bg_mDataSource objectAtIndex:section];
    if (isClear) {
        [sectionData removeAllCellData];
    }
    NSMutableArray *rows = [NSMutableArray new];
    for (BGTableViewRowData *obj in cellDatas) {
        if ([obj isKindOfClass:[BGTableViewRowData class]]) {
            if ([self registCellWith:obj.cellClassName bundle:obj.xibCellBundle]) {
                [rows addObject:obj];
            }
        }
    }
    [sectionData addCellDataArr:rows];
    [self reloadData];
}

/**插入某组数据*/
- (void)insertSectionDataAtSection:(NSInteger)section sectionData:(BGTableViewSectionData*)sectionData {
    [self.bg_mDataSource insertObject:sectionData atIndex:section];
    for (BGTableViewRowData *obj in sectionData.dataList) {
        if ([obj isKindOfClass:[BGTableViewRowData class]]) {
            [self registCellWith:obj.cellClassName bundle:obj.xibCellBundle];
        }
    }
    [self reloadData];
}

/**某组内插入数据*/
- (void)insertRowDataAtIndex:(NSInteger)index cellData:(nullable BGTableViewRowData*)cellData section:(NSInteger)section {
    if ([cellData isKindOfClass:[BGTableViewRowData class]]) {
        [self registCellWith:cellData.cellClassName bundle:cellData.xibCellBundle];
    }
    [[self.bg_mDataSource objectAtIndex:section] insertCellDataAtIndex:index cellData:cellData];
    [self reloadData];
}

#pragma mark-删
/**删除某一组*/
- (void)removeSectionDataModelWith:(NSInteger)section {
    if ([self checkBeyondIndex:section]) {
        return;
    }
    [self.bg_mDataSource removeObjectAtIndex:section];
    [self reloadData];
}

/**删除某一组下面所有行数据*/
- (void)removeSectionAllRowDataWith:(NSInteger)section {
    if ([self checkBeyondIndex:section]) {
        return;
    }
    BGTableViewSectionData *sectionData = [self.bg_mDataSource objectAtIndex:section];
    [sectionData removeAllCellData];
}

/**删除某一行*/
- (void)removeRowDataModelWith:(NSIndexPath*)indexPath {
    if ([self checkBeyondIndex:indexPath.section]) {
        return;
    }
    BGTableViewSectionData*sectionData = [self.bg_mDataSource objectAtIndex:indexPath.section];
    [sectionData removeCellDataAtIndex:indexPath.row];
    [self reloadDataWithSection:indexPath.section];
}

- (BOOL)checkBeyondIndex:(NSInteger)index {
    if (index >= self.bg_mDataSource.count) {
        NSLog(@"BGTableViewComponent数组越界");
        return YES;
    }
    return NO;
}

#pragma mark-改
/**整个组交换顺序*/
- (void)exchangeSectionDataAtSection:(NSInteger)section1 withObjectAtSection:(NSUInteger)section2 {
    [self.bg_mDataSource exchangeObjectAtIndex:section1 withObjectAtIndex:section2];
    [self reloadData];
}

/**某组内交换顺序*/
- (void)exchangeRowDataAtIndex:(NSInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 section:(NSInteger)section {
    if (section >= self.bg_mDataSource.count) {
        NSLog(@"exchangeRowData数组越界");
        return;
    }
    BGTableViewSectionData*data = [self.bg_mDataSource objectAtIndex:section];
    [data exchangeCellDataAtIndex:idx1 withObjectAtIndex:idx2];
    [self reloadDataWithSection:section];
}

/**重载某一组*/
- (void)reloadDataWithSection:(NSInteger)section {
    [self reloadDataWithSectionSet:[NSIndexSet indexSetWithIndex:section]];
}

/**重载某几组*/
- (void)reloadDataWithSectionSet:(NSIndexSet *)sections {
    if (!sections) {
        [self reloadData];
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadSections:sections withRowAnimation:UITableViewRowAnimationNone];
    });
}

/**重载某一行*/
- (void)reloadDataWithIndexPath:(NSIndexPath*)indexPath {
    if (!indexPath) {
        [self reloadData];
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    });
}

#pragma mark- =============自定义方法=================
- (void)addOneCellData:(BGTableViewSectionData*)data {
    if (!data || ![data isKindOfClass:[BGTableViewSectionData class]]) {
        return;
    }
    NSMutableArray *dataList = [NSMutableArray new];
    for (BGTableViewRowData * obj in data.dataList) {
       BOOL isSuccess = [self registCellWith:obj.cellClassName bundle:obj.xibCellBundle];
        if (isSuccess) {
            [dataList addObject:obj];
        }
    }
    data.dataList = dataList;
    [self.bg_mDataSource addObject:data];
}

/**
 添加数据源
 additional: 是否是追加数据
 */
- (void)addCellDatas:(NSArray <BGTableViewSectionData*>*)dataArr additional:(BOOL)additional {
    if (!additional) {
        [self.bg_mDataSource removeAllObjects];
    }
    if (dataArr.count) {
        for (id data in dataArr) {
            [self addOneCellData:data];
        }
    }
    [self reloadData];
}
#pragma mark- cell注册
- (void)registCellsWith:(NSArray*)cellNameArr {
    for (NSString *cellName in cellNameArr) {
        [self registCellWith:cellName bundle:nil];
    }
}

- (BOOL)registCellWith:(nullable NSString*)cellName bundle:(nullable NSBundle* )bundle {
    if (!cellName) {
        return NO;
    }
    if (![self.bgCellClassArr containsObject:cellName]) {
        BOOL isSuccess = [self.tableView commonRegisterCellWithClassName:cellName bundle:bundle];
        if (isSuccess) {
            [self.bgCellClassArr addObject:cellName];
        }
        return isSuccess;
    }
    return YES;
}

- (BGThreadSafeMutableArray*)bg_mDataSource {
    return [self valueForKey:@"mDataSource"];
}

- (NSMutableArray *)bgCellClassArr {
    return [self valueForKey:@"cellClassArr"];
}

@end
