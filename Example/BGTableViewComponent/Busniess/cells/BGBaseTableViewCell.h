//
//  BGBaseTableViewCell.h
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/7.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BGTableViewComponent/BGTableViewComponent.h>
#import <Masonry/Masonry.h>
#import "UILabel+BGTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface BGBaseTableViewCell : UITableViewCell <BGTableViewCellProtocol>

@property (nonatomic, strong) UIView *bottomLineView;

- (void)commonInit __attribute((objc_requires_super));

- (void)addLine;

@end

NS_ASSUME_NONNULL_END
