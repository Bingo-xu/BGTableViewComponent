//
//  BGTableViewCellOtherEventInterface.h
//  BGTableViewComponent
//
//  Created by 徐斌 on 2022/11/6.
//

#import "BGTableViewRowData.h"

/**cell上自定义的事件类型*/
typedef enum : NSUInteger {
    /**事件一*/
    BGTableViewCellOtherEventTypeOne = 1,
    /**事件二*/
    BGTableViewCellOtherEventTypeTwo,
    /**事件三*/
    BGTableViewCellOtherEventTypeThree,
    /**事件四*/
    BGTableViewCellOtherEventTypeFour,
    /**事件五*/
    BGTableViewCellOtherEventTypeFive,
    /**事件六*/
    BGTableViewCellOtherEventTypeSix,
    /**事件七*/
    BGTableViewCellOtherEventTypeSeven,
    /**事件八*/
    BGTableViewCellOtherEventTypeEight,
} BGTableViewCellOtherEventType;

/**
 cell对外扩展方法，外部可调用的接口，内部已实现
 */
@protocol BGTableViewCellOtherEventInterface <NSObject>

@optional

/**cell行数据*/
- (BGTableViewRowData* _Nonnull)bg_rowData;

/**
 cell自定义事件调用,通过BGTableViewDelegate代理
 方法bg_clickCellOtherEventImplementationWithCell:回调出去
 */
- (void)bg_cellOtherActionImplementationWithEventType:(NSInteger)eventType parameter:(NSDictionary * _Nullable)parameter;

/**取消选中效果，cell初始化时调用**/
- (void)cellSelectionStyleNone;

@end


