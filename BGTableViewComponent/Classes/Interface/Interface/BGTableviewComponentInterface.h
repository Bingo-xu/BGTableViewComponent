//
//  BGTableviewComponentInterface.h
//  BGTableViewComponent
//
//  Created by 徐斌 on 2022/11/6.
//


#import "BGTableViewSectionData.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - BGTableviewComponent对外暴露扩展的接口

/**外部可调用的接口，内部已实现*/
@protocol BGTableviewComponentInterface <NSObject>

@optional
#pragma mark- 数据源处理
#pragma mark-增

/**追加数据源，用于分页数据*/
- (void)additionalSectionDatas:(nullable NSArray<BGTableViewSectionData*>*)dataArr;

/**
 追加某一组的数据源
 分页场景
 */
- (void)addRowCellDatas:(nullable NSArray<BGTableViewRowData*>*)cellDatas section:(NSInteger)section;

/**
 重置某一组的数据源
 分页场景
 */
- (void)resetRowCellDatas:(nullable NSArray<BGTableViewRowData*>*)cellDatas section:(NSInteger)section;

/**插入某组数据*/
- (void)insertSectionDataAtSection:(NSInteger)section sectionData:(BGTableViewSectionData*)sectionData;

/**某组内插入数据*/
- (void)insertRowDataAtIndex:(NSInteger)index cellData:(nullable BGTableViewRowData*)cellData section:(NSInteger)section;

#pragma mark-删
/**删除某一组*/
- (void)removeSectionDataModelWith:(NSInteger)section;

/**删除某一组下面所有行数据*/
- (void)removeSectionAllRowDataWith:(NSInteger)section;

/**删除某一行*/
- (void)removeRowDataModelWith:(NSIndexPath*)indexPath;

#pragma mark-改
/**整个组交换顺序*/
- (void)exchangeSectionDataAtSection:(NSInteger)section1 withObjectAtSection:(NSUInteger)section2;
/**某组内交换顺序*/
- (void)exchangeRowDataAtIndex:(NSInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 section:(NSInteger)section;

#pragma mark- 刷新列表

/**重载某一组,不带动画*/
- (void)reloadDataWithSection:(NSInteger)section;

/**重载某几组,不带动画*/
- (void)reloadDataWithSectionSet:(NSIndexSet *)sections;

/**重载某一行,不带动画*/
- (void)reloadDataWithIndexPath:(NSIndexPath*)indexPath;

#pragma mark- cell注册

- (void)registCellsWith:(NSArray*)cellNameArr;

- (BOOL)registCellWith:(nullable NSString*)cellName bundle:(nullable NSBundle*)bundle;

@end

NS_ASSUME_NONNULL_END
