//
//  BGSettingTableViewCell.h
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/10.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import "BGBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BGSettingTableViewCell : BGBaseTableViewCell

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *contentLabel;

@property (nonatomic,strong) UIImageView *arrowImage;

@property (nonatomic,strong) UISwitch *switchBtn;

@end

NS_ASSUME_NONNULL_END
