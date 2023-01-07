//
//  BGTableviewComponent.h
//  BGTableViewComponent
//
//  Created by Bingo on 2022/10/14.
//  Copyright © 2022 xb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BGTableViewDelegate.h"
#import "BGTableViewCellProtocol.h"
#import "BGTableviewComponentInterface.h"

NS_ASSUME_NONNULL_BEGIN

/**
 一款快捷搭建复杂tableview的组件
 */
@interface BGTableViewComponent : UIView <BGTableviewComponentInterface>

/**
 滑动及点击事件代理
 */
@property (nonatomic,weak) id <BGTableViewDelegate> delegate;

@property (nonatomic,strong,readonly) UITableView *tableView;

#pragma mark- 初始化
+ (BGTableViewComponent *)initWithTableViewStyle:(UITableViewStyle)style;
/**
 指定TableViewStyle，默认UITableViewStylePlain
 传入父视图、tableView的frame
 */
+ (BGTableViewComponent *)initWithTableViewStyle:(UITableViewStyle)style frame:(CGRect)frame superView:(nullable UIView* )superView;
/**
 指定TableViewStyle，默认UITableViewStylePlain
 传入父视图、tableView的frame、代理
 */
+ (BGTableViewComponent *)initWithTableViewStyle:(UITableViewStyle)style frame:(CGRect)frame superView:(nullable UIView* )superView delegate:(id <BGTableViewDelegate>)delegate;

#pragma mark- 设置数据源
/**单组列表，无组头组尾，重置数据源。内部创建section*/
- (void)resetSingleSectionDataSourecs:(nullable NSArray<BGTableViewRowData*>*)dataArr;

/**重置数据源，组头组尾外部设置*/
- (void)resetDataSourecs:(nullable NSArray<BGTableViewSectionData*>*)dataArr;

#pragma mark-查
/**获取某一行数据*/
- (BGTableViewRowData*)getRowDataModelWith:(NSIndexPath*)indexPath;

/**获取某一组数据*/
- (BGTableViewSectionData*)getSectionDataModelWith:(NSInteger)section;

/**数据源*/
- (NSArray<BGTableViewSectionData*>*)dataSources;

#pragma mark- 刷新列表

/**重载所有列表*/
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
