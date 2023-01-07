//
//  BGTableviewComponent+DataSource.h
//  BGTableViewComponent
//
//  Created by Bingo on 2022/10/14.
//  Copyright © 2022 xb. All rights reserved.
//

#import <BGTableViewComponent/BGTableViewComponent.h>

NS_ASSUME_NONNULL_BEGIN

@interface BGTableViewComponent (DataSource)

/**单组列表，无组头组尾，重置数据源。内部创建section*/
- (void)bg_resetSingleSectionDataSourecs:(nullable NSArray<BGTableViewRowData*>*)dataArr;

/**重置数据源*/
- (void)bg_resetDataSourecs:(nullable NSArray<BGTableViewSectionData*>*)dataArr;

@end

NS_ASSUME_NONNULL_END
