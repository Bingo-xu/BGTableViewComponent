//
//  BGTableViewSectionData+BGArray.h
//  BGTableViewComponent
//
//  Created by Bingo on 2022/10/14.
//  Copyright © 2022 xb. All rights reserved.
//

#import "BGTableViewSectionData.h"
#import "BGThreadSafeMutableArray.h"

NS_ASSUME_NONNULL_BEGIN

@interface BGTableViewSectionData (BGArray)

@property (nonatomic,strong) BGThreadSafeMutableArray *mDataList;

/**添加数据*/
- (void)addCellData:(BGTableViewRowData*)data;
/**添加数据*/
- (void)addCellDataArr:(NSArray<BGTableViewRowData*>*)dataArr;
/**清空数据源*/
- (void)removeAllCellData;
/**删除某一行数据*/
- (void)removeCellDataAtIndex:(NSInteger)index;
/**交换数据*/
- (void)exchangeCellDataAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
/**插入数据*/
- (void)insertCellDataAtIndex:(NSUInteger)idx1 cellData:(BGTableViewRowData*)data;

@end

NS_ASSUME_NONNULL_END
