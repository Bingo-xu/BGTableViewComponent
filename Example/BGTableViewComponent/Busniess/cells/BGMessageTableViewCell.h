//
//  BGMessageTableViewCell.h
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/7.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import "BGBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BGMessageTableViewCell : BGBaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *arrowImageView;

@end

NS_ASSUME_NONNULL_END
