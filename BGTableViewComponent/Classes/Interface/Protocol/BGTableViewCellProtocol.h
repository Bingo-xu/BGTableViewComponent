//
//  BGTableViewDefineHeader.h
//  Pods
//
//  Created by Bingo on 2022/10/14.
//  Copyright © 2022 xb. All rights reserved.
//

#import "BGTableViewCellOtherEventInterface.h"

#pragma mark- 数据刷新
/**数据刷新协议，cell、组视图数据源加载*/
@protocol BGTableViewReloadDataProtocol <NSObject>

/**刷新数据*/
- (void)bg_refreshUIWithData:(id _Nonnull)data;

@end


/**
 使用BGTableViewComponent外部cell需要遵守的协议
 */
@protocol BGTableViewCellProtocol <BGTableViewReloadDataProtocol,BGTableViewCellOtherEventInterface>

//用于方法扩展
@optional
/**获取cell高度*/
+ (CGFloat)bg_getTableViewCellHeightWithData:(nullable BGTableViewRowData *)data;

@end

