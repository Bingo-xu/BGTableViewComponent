//
//  BGTableViewRowData.m
//  BGTableViewComponent
//
//  Created by Bingo on 2022/10/14.
//  Copyright © 2022 xb. All rights reserved.
//

#import "BGTableViewRowData.h"

@implementation BGTableViewRowData

+ (BGTableViewRowData* )creatDataWith:(NSString*)cellClass data:(id)data {
    BGTableViewRowData* dataSource = [BGTableViewRowData new];
    dataSource.data = data;
    dataSource.cellClassName = cellClass;
    return dataSource;
}

+ (BGTableViewRowData* )creatDataWith:(NSString*)cellClass data:(id)data cellHeight:(float)cellHeight {
    BGTableViewRowData* dataSource = [self creatDataWith:cellClass data:data];
    dataSource.cellHeight = cellHeight;
    return dataSource;
}

+ (BGTableViewRowData* )creatDataWith:(NSString*)cellClass data:(id)data cellHeight:(float)cellHeight cellEventType:(NSInteger )cellEventType {
    BGTableViewRowData* dataSource = [self creatDataWith:cellClass data:data cellHeight:cellHeight];
    dataSource.selecteCellEventType = cellEventType;
    return dataSource;
}

/**创建数组*/
+ (NSArray <BGTableViewRowData*>*)creatDataSourcesWithCellClassName:(NSString*)cellClassName dataArr:(NSArray*)dataArr cellHeight:(CGFloat )cellHeight {
    return [self creatDataSourcesWithCellClassName:cellClassName bundle:nil dataArr:dataArr cellHeight:cellHeight];
}

+ (NSArray <BGTableViewRowData*>*)creatDataSourcesWithCellClassName:(NSString*)cellClassName bundle:(nullable NSBundle*)bundle dataArr:(NSArray*)dataArr cellHeight:(CGFloat )cellHeight {
    if (!dataArr.count) {
        return nil;
    }
    NSMutableArray*arr = [NSMutableArray new];
    for (id model in dataArr) {
        BGTableViewRowData* data = [BGTableViewRowData creatDataWith:cellClassName data:model];
        data.cellHeight = cellHeight;
        data.xibCellBundle = bundle;
        [arr addObject:data];
    }
    return arr;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    BGTableViewRowData *copy = [[BGTableViewRowData allocWithZone:zone] init];
    copy.cellClassName = self.cellClassName;
    copy.data = self.data;
    copy.cellHeight = self.cellHeight;
    copy.indexPath = [self.indexPath mutableCopy];
    copy.selecteCellEventType = self.selecteCellEventType;
    copy.autoHeight = self.autoHeight;
    copy.xibCellBundle = self.xibCellBundle;
    return copy;
}

@end
