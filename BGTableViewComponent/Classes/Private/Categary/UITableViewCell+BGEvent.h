//
//  UITableViewCell+BGEvent.h
//  BGTableViewComponent
//
//  Created by Bingo on 2022/10/14.
//  Copyright © 2022 xb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGTableViewCellOtherEventInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (BGEvent) <BGTableViewCellOtherEventInterface>

/**cell行数据赋值*/
- (void)setBGCellData:(BGTableViewRowData *_Nonnull)bgCellData;

@end

NS_ASSUME_NONNULL_END
