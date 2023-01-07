//
//  BGBannerTableViewCell.h
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/10.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import "BGBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BGBannerModel : NSObject

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *actionUrl;

@end

@interface BGBannerTableViewCell : BGBaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
