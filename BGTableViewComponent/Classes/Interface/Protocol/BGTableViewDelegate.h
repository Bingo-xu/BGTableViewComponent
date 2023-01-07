//
//  BGTableViewDelegate.h
//  Pods
//
//  Created by Bingo on 2022/10/14.
//  Copyright © 2022 xb. All rights reserved.
//

#import "BGTableViewSectionData.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark- BGTableView协议

@protocol BGTableViewCellEventProtocol <NSObject, UIScrollViewDelegate>

/**
 cell选中事件
 */
- (void)bg_selecteCellImplementationWithCell:(UITableViewCell* )cell data:(BGTableViewRowData* )data;

@optional
/**
 cell上的其他事件
 eventType: 点击事件类型
 otherParameters: cell上其他事件传参
 */
- (void)bg_clickCellOtherEventImplementationWithCell:(UITableViewCell* )cell data:(BGTableViewRowData* )data eventType:(NSInteger)eventType otherParameters:(NSDictionary *)otherParameters;

@end



@protocol BGTableViewEditCellProtocol <NSObject>

@optional
/**是否可编辑*/
- (BOOL)bg_canEditRowAtIndexPath:(NSIndexPath *)indexPath;

/**单个删除按钮事件*/
- (void)bg_commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

/**多个按钮自定义*/
- (NSArray<UITableViewRowAction*>*)bg_editActionsForRowAtIndexPath:(NSIndexPath *)indexPath;

@end



@protocol BGTableViewCellDisplayProtocol <NSObject>

@optional
/**
 自定义cell，
 用于外层持有cell时需要，
 返回nil使用tableview使用原有cell
 */
- (UITableViewCell*)bg_customCellImplementationWithCell:(UITableViewCell* )cell data:(BGTableViewRowData* )data;

/**cell绘制时是否需要动画*/
- (void)bg_willDisplayCell:(UITableViewCell *)cell ForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


#pragma mark- BGTableView组件代理方法

/**
 使用BGTableViewComponent外部代理需要遵守的协议
 一般只需实现BGTableViewCellEventProtocol协议，选中cell的代理方法
 */
@protocol BGTableViewDelegate <BGTableViewCellEventProtocol,BGTableViewEditCellProtocol,BGTableViewCellDisplayProtocol>


@end

NS_ASSUME_NONNULL_END
