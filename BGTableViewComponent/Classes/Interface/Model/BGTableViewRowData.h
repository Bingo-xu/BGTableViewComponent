//
//  BGTableViewRowData.h
//  BGTableViewComponent
//
//  Created by Bingo on 2022/10/14.
//  Copyright © 2022 xb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface BGTableViewRowData : NSObject <NSCopying>

/**未设置行高，底层根据数据计算行高，默认NO*/
@property (nonatomic, assign) BOOL autoHeight;
/**
 cell的类名
 */
@property (nonatomic,copy) NSString *cellClassName;
/**使用xib时的bundle，默认为nil，使用mainBundle*/
@property (nonatomic,strong) NSBundle *xibCellBundle;
/**数据源*/
@property (nonatomic,strong) id data;
/**cell的高度*/
@property (nonatomic,assign) float cellHeight;
/**
 用于标记cell选中事件
 调用方可定义枚举使用
 */
@property (nonatomic,assign) NSInteger selecteCellEventType;
/**
 记录cell位置
 调用方不用赋值
 */
@property (nonatomic,strong) NSIndexPath *indexPath;

#pragma mark- =============数据源装载=================
/**
 cellClassName：cell的类名，默认为纯代码。xib类名需拼接XIBSuffix
 */
+ (BGTableViewRowData* )creatDataWith:(NSString*)cellClass data:(id)data;

/**
 cellClassName：cell的类名，默认为纯代码。xib类名需拼接XIBSuffix
 */
+ (BGTableViewRowData* )creatDataWith:(NSString*)cellClass data:(id)data cellHeight:(float)cellHeight;

/**
 cellClassName：cell的类名，默认为纯代码。xib类名需拼接XIBSuffix
 */
+ (BGTableViewRowData* )creatDataWith:(NSString*)cellClass data:(id)data cellHeight:(float)cellHeight cellEventType:(NSInteger )cellEventType;

/**
 cellClassName：cell的类名，默认为纯代码。
 普通单个类型cell，cell无其他点击事件，复杂的需要自己创建数据源
 数据源是普通数据源
 底层帮封装成BGTableViewRowData类型
 */
+ (NSArray <BGTableViewRowData*>*)creatDataSourcesWithCellClassName:(NSString*)cellClassName dataArr:(NSArray*)dataArr cellHeight:(CGFloat )cellHeight;

/**
 cellClassName：cell的类名
 bundle: 使用xib时的bundle，默认为nil，使用mainBundle
 普通单个类型cell，cell无其他点击事件，复杂的需要自己创建数据源
 数据源是普通数据源
 底层帮封装成BGTableViewRowData类型
 */
+ (NSArray <BGTableViewRowData*>*)creatDataSourcesWithCellClassName:(NSString*)cellClassName bundle:(nullable NSBundle*)bundle dataArr:(NSArray*)dataArr cellHeight:(CGFloat )cellHeight;

@end

NS_ASSUME_NONNULL_END
